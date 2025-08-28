package com.tss.database;

public final class DBConfig {
	private DBConfig() {
	} // Prevent instantiation

	public static final String DRIVER = "com.mysql.cj.jdbc.Driver";
	public static final String URL = "jdbc:mysql://localhost:3306/banking_system1";
	public static final String USER = "root";
	public static final String PASS = "Temp@123456";
}