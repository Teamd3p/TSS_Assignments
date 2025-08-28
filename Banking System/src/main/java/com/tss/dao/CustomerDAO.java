package com.tss.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.tss.database.DBConnection;
import com.tss.model.Customer;

public class CustomerDAO {
	public int create(Customer c) throws SQLException {
		String sql = "INSERT INTO customers (user_id, full_name, email, phone, address, aadhar_no, pan_no) VALUES (?,?,?,?,?,?,?)";
		try (Connection conn = DBConnection.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
			ps.setInt(1, c.getUserId());
			ps.setString(2, c.getFullName());
			ps.setString(3, c.getEmail());
			ps.setString(4, c.getPhone());
			ps.setString(5, c.getAddress());
			ps.setString(6, c.getAadharNo());
			ps.setString(7, c.getPanNo());
			ps.executeUpdate();
			try (ResultSet rs = ps.getGeneratedKeys()) {
				if (rs.next()) {
					return rs.getInt(1);
				}
			}
		}
		return 0;
	}

	public void update(Customer c) throws SQLException {
		String sql = "UPDATE customers SET full_name=?, email=?, phone=?, address=?, aadhar_no=?, pan_no=? WHERE customer_id=?";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, c.getFullName());
			ps.setString(2, c.getEmail());
			ps.setString(3, c.getPhone());
			ps.setString(4, c.getAddress());
			ps.setString(5, c.getAadharNo());
			ps.setString(6, c.getPanNo());
			ps.setInt(7, c.getCustomerId());
			ps.executeUpdate();
		}
	}

	public void delete(int customerId) throws SQLException {
		String sql = "DELETE FROM customers WHERE customer_id = ?";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, customerId);
			ps.executeUpdate();
		}
	}

	public Customer findById(int id) throws SQLException {
		String sql = "SELECT * FROM customers WHERE customer_id = ?";
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

	public Customer findByUserId(int userId) throws SQLException {
		String sql = "SELECT * FROM customers WHERE user_id = ?";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, userId);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					return mapRow(rs);
				}
			}
		}
		return null;
	}

	public List<Customer> findAll() throws SQLException {
		String sql = "SELECT * FROM customers ORDER BY customer_id DESC";
		List<Customer> list = new ArrayList<>();
		try (Connection conn = DBConnection.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {
			while (rs.next()) {
				list.add(mapRow(rs));
			}
		}
		return list;
	}

	private Customer mapRow(ResultSet rs) throws SQLException {
		Customer c = new Customer();
		c.setCustomerId(rs.getInt("customer_id"));
		c.setUserId(rs.getInt("user_id"));
		c.setFullName(rs.getString("full_name"));
		c.setEmail(rs.getString("email"));
		c.setPhone(rs.getString("phone"));
		c.setAddress(rs.getString("address"));
		c.setAadharNo(rs.getString("aadhar_no"));
		c.setPanNo(rs.getString("pan_no"));
		c.setCreatedAt(rs.getTimestamp("created_at"));
		c.setStatus(rs.getString("status")); // Map the status column
		return c;
	}
}