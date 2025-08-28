package com.tss.dao;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.tss.database.DBConnection;
import com.tss.model.Loan;

public class LoanDAO {
	public int create(Loan loan) throws SQLException {
		String sql = "INSERT INTO loans (customer_id, account_id, loan_type, amount, interest_rate, tenure_months, status) VALUES (?,?,?,?,?,?,?)";
		try (Connection conn = DBConnection.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
			ps.setInt(1, loan.getCustomerId());

			// ✅ handle NULL properly
			if (loan.getAccountId() == null) {
				ps.setNull(2, java.sql.Types.INTEGER);
			} else {
				ps.setInt(2, loan.getAccountId());
			}

			ps.setString(3, loan.getLoanType());
			ps.setBigDecimal(4, loan.getAmount() == null ? BigDecimal.ZERO : loan.getAmount());
			ps.setBigDecimal(5, loan.getInterestRate() == null ? BigDecimal.ZERO : loan.getInterestRate());
			ps.setInt(6, loan.getTenureMonths());
			ps.setString(7, loan.getStatus());

			ps.executeUpdate();
			try (ResultSet rs = ps.getGeneratedKeys()) {
				if (rs.next()) {
					return rs.getInt(1);
				}
			}
		}
		return 0;
	}

	public void updateStatus(int loanId, String status) throws SQLException {
		String sql = "UPDATE loans SET status=? WHERE loan_id=?";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, status);
			ps.setInt(2, loanId);
			ps.executeUpdate();
		}
	}

	public Loan findById(int id) throws SQLException {
		String sql = "SELECT * FROM loans WHERE loan_id = ?";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, id);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					return mapRow(rs);
				}
			}
		}
		return null;
	}

	public List<Loan> findByCustomerId(int customerId) throws SQLException {
		String sql = """
				SELECT l.loan_id, l.customer_id, l.account_id, l.loan_type,
				       l.amount, l.interest_rate, l.tenure_months, l.status, l.applied_date,
				       a.account_number,
				       (l.amount - COALESCE(SUM(r.amount_paid), 0)) AS outstanding_amount
				FROM loans l
				LEFT JOIN accounts a ON l.account_id = a.account_id
				LEFT JOIN loan_repayments r ON r.loan_id = l.loan_id
				WHERE l.customer_id = ?
				GROUP BY l.loan_id, l.customer_id, l.account_id, l.loan_type, l.amount, l.interest_rate,
				         l.tenure_months, l.status, l.applied_date, a.account_number
				ORDER BY l.loan_id DESC
				""";

		List<Loan> list = new ArrayList<>();
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, customerId);
			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					Loan l = new Loan();
					l.setLoanId(rs.getInt("loan_id"));
					l.setCustomerId(rs.getInt("customer_id"));
					l.setAccountId(rs.getObject("account_id", Integer.class));
					l.setLoanType(rs.getString("loan_type"));
					l.setAmount(rs.getBigDecimal("amount"));
					l.setInterestRate(rs.getBigDecimal("interest_rate"));
					l.setTenureMonths(rs.getInt("tenure_months"));
					l.setStatus(rs.getString("status"));
					l.setAppliedDate(rs.getTimestamp("applied_date"));
					l.setAccountNumber(rs.getString("account_number"));
					l.setOutstandingAmount(rs.getBigDecimal("outstanding_amount")); // ✅ new
					list.add(l);
				}
			}
		}
		return list;
	}

	// File: com/tss/dao/LoanDAO.java

	public List<Loan> findAll() throws SQLException {
		String sql = """
				SELECT
				    l.loan_id, l.customer_id, l.account_id, l.loan_type,
				    l.amount, l.interest_rate, l.tenure_months, l.status, l.applied_date,
				    a.account_number
				FROM loans l
				LEFT JOIN accounts a ON l.account_id = a.account_id
				ORDER BY l.loan_id DESC
				""";

		List<Loan> list = new ArrayList<>();
		try (Connection conn = DBConnection.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {

			while (rs.next()) {
				Loan l = new Loan();
				l.setLoanId(rs.getInt("loan_id"));
				l.setCustomerId(rs.getInt("customer_id"));
				l.setAccountId(rs.getObject("account_id", Integer.class)); // handles NULL
				l.setLoanType(rs.getString("loan_type"));
				l.setAmount(rs.getBigDecimal("amount"));
				l.setInterestRate(rs.getBigDecimal("interest_rate"));
				l.setTenureMonths(rs.getInt("tenure_months"));
				l.setStatus(rs.getString("status"));
				l.setAppliedDate(rs.getTimestamp("applied_date"));
				l.setAccountNumber(rs.getString("account_number")); // ← Set account number
				list.add(l);
			}
		}
		return list;
	}

	private Loan mapRow(ResultSet rs) throws SQLException {
		Loan l = new Loan();
		l.setLoanId(rs.getInt("loan_id"));
		l.setCustomerId(rs.getInt("customer_id"));
		try {
			l.setAccountId(rs.getInt("account_id"));
		} catch (SQLException ignored) {
		}
		l.setLoanType(rs.getString("loan_type"));
		l.setAmount(rs.getBigDecimal("amount"));
		l.setInterestRate(rs.getBigDecimal("interest_rate"));
		l.setTenureMonths(rs.getInt("tenure_months"));
		l.setStatus(rs.getString("status"));
		l.setAppliedDate(rs.getTimestamp("applied_date"));
		return l;
	}

	// Compute remaining balance = original amount - sum(repayments)
	public BigDecimal getOutstandingAmount(int loanId) throws SQLException {
		String sql = """
				    SELECT (l.amount - COALESCE((
				        SELECT SUM(r.amount_paid) FROM loan_repayments r WHERE r.loan_id = l.loan_id
				    ), 0)) AS outstanding
				    FROM loans l
				    WHERE l.loan_id = ?
				""";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, loanId);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					BigDecimal out = rs.getBigDecimal("outstanding");
					return out == null ? BigDecimal.ZERO : out;
				}
			}
		}
		return BigDecimal.ZERO;
	}

}
