package com.tss.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.tss.database.DBConnection;
import com.tss.model.ActivityLog;

public class ActivityLogDAO {
	/**
	 * Creates a new activity log entry and returns the generated log_id.
	 * 
	 * @param log The ActivityLog object to insert
	 * @return The generated log_id, or 0 if the operation fails
	 * @throws SQLException If a database error occurs
	 */
	public int create(ActivityLog log) throws SQLException {
		if (log == null || log.getUserId() <= 0 || log.getAction() == null || log.getAction().trim().isEmpty()) {
			throw new IllegalArgumentException("Invalid log data: userId and action are required.");
		}

		String sql = "INSERT INTO activity_logs (user_id, action) VALUES (?, ?)";
		try (Connection conn = DBConnection.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
			ps.setInt(1, log.getUserId());
			ps.setString(2, log.getAction());
			int affectedRows = ps.executeUpdate();
			if (affectedRows == 0) {
				throw new SQLException("Failed to create activity log, no rows affected.");
			}
			try (ResultSet rs = ps.getGeneratedKeys()) {
				if (rs.next()) {
					return rs.getInt(1);
				}
			}
		}
		return 0; // Should not reach here due to exception, but kept for consistency
	}

	/**
	 * Retrieves a limited number of recent activity logs.
	 * 
	 * @param limit The maximum number of logs to retrieve (must be positive)
	 * @return List of ActivityLog objects
	 * @throws SQLException             If a database error occurs
	 * @throws IllegalArgumentException If limit is invalid
	 */
	public List<ActivityLog> findAll(int limit) throws SQLException {
		if (limit <= 0) {
			throw new IllegalArgumentException("Limit must be a positive integer.");
		}

		String sql = "SELECT * FROM activity_logs ORDER BY log_id DESC LIMIT ?";
		List<ActivityLog> list = new ArrayList<>();
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, limit);
			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					list.add(mapRow(rs));
				}
			}
		}
		return list;
	}

	/**
	 * Maps a ResultSet row to an ActivityLog object.
	 * 
	 * @param rs The ResultSet containing the row data
	 * @return The mapped ActivityLog object
	 * @throws SQLException If a column is missing or data cannot be retrieved
	 */
	private ActivityLog mapRow(ResultSet rs) throws SQLException {
		ActivityLog l = new ActivityLog();
		l.setLogId(rs.getInt("log_id"));
		l.setUserId(rs.getInt("user_id"));
		l.setAction(rs.getString("action"));
		// Handle null log_date (default is CURRENT_TIMESTAMP, but allow for null)
		Timestamp logDate = rs.getTimestamp("log_date");
		l.setLogDate(logDate != null ? logDate : new Timestamp(System.currentTimeMillis()));
		return l;
	}
}