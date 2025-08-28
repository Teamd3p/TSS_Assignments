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
import com.tss.model.LoanRepayment;

public class LoanRepaymentDAO {
    public int create(LoanRepayment r) throws SQLException {
        String sql = "INSERT INTO loan_repayments (loan_id, amount_paid) VALUES (?,?)";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, r.getLoanId());
            ps.setBigDecimal(2, r.getAmountPaid() == null ? BigDecimal.ZERO : r.getAmountPaid());
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }

    public List<LoanRepayment> findByLoanId(int loanId) throws SQLException {
        String sql = "SELECT * FROM loan_repayments WHERE loan_id=? ORDER BY repayment_id DESC";
        List<LoanRepayment> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, loanId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRow(rs));
                }
            }
        }
        return list;
    }

    private LoanRepayment mapRow(ResultSet rs) throws SQLException {
        LoanRepayment r = new LoanRepayment();
        r.setRepaymentId(rs.getInt("repayment_id"));
        r.setLoanId(rs.getInt("loan_id"));
        r.setAmountPaid(rs.getBigDecimal("amount_paid"));
        r.setRepaymentDate(rs.getTimestamp("repayment_date"));
        return r;
    }
}

