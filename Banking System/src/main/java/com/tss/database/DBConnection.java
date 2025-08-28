package com.tss.database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public final class DBConnection {
	private DBConnection() {
	} // Prevent instantiation

	static {
		try {
			Class.forName(DBConfig.DRIVER);
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("JDBC Driver not found: " + DBConfig.DRIVER, e);
		}
	}

	public static Connection getConnection() throws SQLException {
		return DriverManager.getConnection(DBConfig.URL, DBConfig.USER, DBConfig.PASS);
	}
}