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
import com.tss.model.Account;

public class AccountDAO {
	public int create(Account a) throws SQLException {
		String sql = "INSERT INTO accounts (customer_id, account_number, account_type, balance, status) VALUES (?,?,?,?,?)";
		try (Connection conn = DBConnection.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
			ps.setInt(1, a.getCustomerId());
			ps.setString(2, a.getAccountNumber()); // Use generated accountNumber
			ps.setString(3, a.getAccountType());
			ps.setBigDecimal(4, a.getBalance() == null ? BigDecimal.ZERO : a.getBalance());
			ps.setString(5, a.getStatus());
			ps.executeUpdate();
			try (ResultSet rs = ps.getGeneratedKeys()) {
				if (rs.next()) {
					return rs.getInt(1);
				}
			}
			throw new SQLException("Failed to retrieve generated account ID");
		}
	}

	public void updateStatus(int accountId, String status) throws SQLException {
		String sql = "UPDATE accounts SET status=? WHERE account_id=?";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, status);
			ps.setInt(2, accountId);
			if (ps.executeUpdate() == 0)
				throw new SQLException("No account updated");
		}
	}

	public void updateBalance(int accountId, BigDecimal newBalance) throws SQLException {
		String sql = "UPDATE accounts SET balance=? WHERE account_id=?";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setBigDecimal(1, newBalance);
			ps.setInt(2, accountId);
			if (ps.executeUpdate() == 0)
				throw new SQLException("No account updated");
		}
	}

	public void updateBalance(Connection conn, int accountId, BigDecimal newBalance) throws SQLException {
		String sql = "UPDATE accounts SET balance=? WHERE account_id=?";
		try (PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setBigDecimal(1, newBalance);
			ps.setInt(2, accountId);
			if (ps.executeUpdate() == 0)
				throw new SQLException("No account updated");
		}
	}

	public void updateDetails(int accountId, String accountNumber, String accountType) throws SQLException {
		String sql = "UPDATE accounts SET account_number=?, account_type=? WHERE account_id=?";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, accountNumber);
			ps.setString(2, accountType);
			ps.setInt(3, accountId);
			if (ps.executeUpdate() == 0)
				throw new SQLException("No account updated");
		}
	}

	public Account findById(int id) throws SQLException {
		String sql = "SELECT * FROM accounts WHERE account_id = ?";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, id);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					return mapRow(rs);
				}
				throw new SQLException("Account not found");
			}
		}
	}

	public Account findByIdForUpdate(Connection conn, int id) throws SQLException {
		String sql = "SELECT * FROM accounts WHERE account_id = ? FOR UPDATE";
		try (PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, id);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					return mapRow(rs);
				}
				throw new SQLException("Account not found");
			}
		}
	}

	public Account findByAccountNumber(String accountNumber) throws SQLException {
		String sql = "SELECT * FROM accounts WHERE account_number = ?";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, accountNumber);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					return mapRow(rs);
				}
				throw new SQLException("Account not found");
			}
		}
	}

	public Account findByAccountNumberForUpdate(Connection conn, String accountNumber) throws SQLException {
		String sql = "SELECT * FROM accounts WHERE account_number = ? FOR UPDATE";
		try (PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, accountNumber);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					return mapRow(rs);
				}
				throw new SQLException("Account not found");
			}
		}
	}

	public List<Account> findByCustomerId(int customerId) throws SQLException {
		String sql = "SELECT a.account_id, a.account_number, a.account_type, " + "a.balance, a.status, a.created_at, "
				+ "c.full_name AS customer_name " + "FROM accounts a "
				+ "JOIN customers c ON a.customer_id = c.customer_id " + "WHERE a.customer_id = ? "
				+ "ORDER BY a.account_id DESC";

		List<Account> list = new ArrayList<>();
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, customerId);
			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					Account a = new Account();
					a.setAccountId(rs.getInt("account_id"));
					a.setAccountNumber(rs.getString("account_number"));
					a.setAccountType(rs.getString("account_type"));
					a.setBalance(rs.getBigDecimal("balance"));
					a.setStatus(rs.getString("status"));
					a.setCreatedAt(rs.getTimestamp("created_at"));
					a.setCustomerName(rs.getString("customer_name"));
					list.add(a);
				}
			}
		}
		return list;
	}

	public List<Account> findAll() throws SQLException {
		String sql = "SELECT a.account_id, a.customer_id, a.account_number, a.account_type, "
				+ "a.balance, a.status, a.created_at, c.full_name AS customer_name " + "FROM accounts a "
				+ "JOIN customers c ON a.customer_id = c.customer_id " + "ORDER BY a.account_id DESC";

		List<Account> list = new ArrayList<>();
		try (Connection conn = DBConnection.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {
			while (rs.next()) {
				Account a = new Account();
				a.setAccountId(rs.getInt("account_id"));
				a.setCustomerId(rs.getInt("customer_id"));
				a.setAccountNumber(rs.getString("account_number"));
				a.setAccountType(rs.getString("account_type"));
				a.setBalance(rs.getBigDecimal("balance"));
				a.setStatus(rs.getString("status"));
				a.setCreatedAt(rs.getTimestamp("created_at"));
				a.setCustomerName(rs.getString("customer_name")); // ✅ FIX
				list.add(a);
			}
		}
		return list;
	}

	private Account mapRow(ResultSet rs) throws SQLException {
		Account a = new Account();
		a.setAccountId(rs.getInt("account_id"));
		a.setCustomerId(rs.getInt("customer_id"));
		a.setAccountNumber(rs.getString("account_number"));
		a.setAccountType(rs.getString("account_type"));
		a.setBalance(rs.getBigDecimal("balance"));
		a.setStatus(rs.getString("status"));
		a.setCreatedAt(rs.getTimestamp("created_at"));
		try {
			a.setCustomerName(rs.getString("customer_name")); // won’t exist in plain queries
		} catch (SQLException ignored) {
		}
		return a;
	}

}