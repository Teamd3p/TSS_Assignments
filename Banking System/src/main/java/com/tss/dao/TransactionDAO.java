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
import com.tss.model.Transaction;

public class TransactionDAO {
    public int create(Transaction t) throws SQLException {
        String sql = "INSERT INTO transactions (account_id, type, amount, status, reference_account) VALUES (?,?,?,?,?)";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, t.getAccountId());
            ps.setString(2, t.getType());
            ps.setBigDecimal(3, t.getAmount() == null ? BigDecimal.ZERO : t.getAmount());
            ps.setString(4, t.getStatus());
            ps.setString(5, t.getReferenceAccount());
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }

    public int create(Connection conn, Transaction t) throws SQLException {
        String sql = "INSERT INTO transactions (account_id, type, amount, status, reference_account) VALUES (?,?,?,?,?)";
        try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, t.getAccountId());
            ps.setString(2, t.getType());
            ps.setBigDecimal(3, t.getAmount() == null ? BigDecimal.ZERO : t.getAmount());
            ps.setString(4, t.getStatus());
            ps.setString(5, t.getReferenceAccount());
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }

    public List<Transaction> findByAccountId(int accountId, int limit) throws SQLException {
        String sql = "SELECT * FROM transactions WHERE account_id = ? ORDER BY transaction_id DESC LIMIT ?";
        List<Transaction> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, accountId);
            ps.setInt(2, limit);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRow(rs));
                }
            }
        }
        return list;
    }

    public List<Transaction> findAll() throws SQLException {
        String sql = "SELECT * FROM transactions ORDER BY transaction_id DESC";
        List<Transaction> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        }
        return list;
    }

    private Transaction mapRow(ResultSet rs) throws SQLException {
        Transaction t = new Transaction();
        t.setTransactionId(rs.getInt("transaction_id"));
        t.setAccountId(rs.getInt("account_id"));
        t.setType(rs.getString("type"));
        t.setAmount(rs.getBigDecimal("amount"));
        t.setTransactionDate(rs.getTimestamp("transaction_date"));
        t.setStatus(rs.getString("status"));
        t.setReferenceAccount(rs.getString("reference_account"));
        return t;
    }
}

