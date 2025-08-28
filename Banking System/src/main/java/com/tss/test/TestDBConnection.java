package com.tss.test;

import java.sql.Connection;
import java.sql.SQLException;

import com.tss.database.DBConnection;

public class TestDBConnection {
	public static void main(String[] args) {
		try {
			Connection conn = DBConnection.getConnection();
			System.out.println("✅ Connected to the database!");
			conn.close();
		} catch (SQLException e) {
			System.err.println("❌ DB Connection failed: " + e.getMessage());
			e.printStackTrace();
		}
	}
}