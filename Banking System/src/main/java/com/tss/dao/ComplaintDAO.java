package com.tss.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.tss.database.DBConnection;
import com.tss.model.Complaint;

public class ComplaintDAO {
    public int create(Complaint c) throws SQLException {
        String sql = "INSERT INTO complaints (customer_id, subject, message, status) VALUES (?,?,?,?)";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, c.getCustomerId());
            ps.setString(2, c.getSubject());
            ps.setString(3, c.getMessage());
            ps.setString(4, c.getStatus());
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }

    public void updateStatus(int complaintId, String status) throws SQLException {
        String sql = "UPDATE complaints SET status=? WHERE complaint_id=?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, complaintId);
            ps.executeUpdate();
        }
    }

    public Complaint findById(int id) throws SQLException {
        String sql = "SELECT * FROM complaints WHERE complaint_id=?";
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

    public List<Complaint> findByCustomerId(int customerId) throws SQLException {
        String sql = "SELECT * FROM complaints WHERE customer_id=? ORDER BY complaint_id DESC";
        List<Complaint> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, customerId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRow(rs));
                }
            }
        }
        return list;
    }

    public List<Complaint> findAll() throws SQLException {
        String sql = "SELECT * FROM complaints ORDER BY complaint_id DESC";
        List<Complaint> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        }
        return list;
    }

    private Complaint mapRow(ResultSet rs) throws SQLException {
        Complaint c = new Complaint();
        c.setComplaintId(rs.getInt("complaint_id"));
        c.setCustomerId(rs.getInt("customer_id"));
        c.setSubject(rs.getString("subject"));
        c.setMessage(rs.getString("message"));
        c.setStatus(rs.getString("status"));
        c.setCreatedAt(rs.getTimestamp("created_at"));
        return c;
    }
}

