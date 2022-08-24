package com.example.marketproject.config;

import java.sql.*;



public class Database {
	final String DBDriverName = "com.mysql.cj.jdbc.Driver";
	final String URL = "jdbc:mysql://localhost:3356/tj?characterEncoding=utf8&serverTimezone=UTC&useSSL=false";
	final String USER = "root";
	final String PASSWORD = "love1004";
	
	public Connection conn;
	public Statement stmt;
	
	public Database() {
		try {
			Class.forName(DBDriverName);
			conn = DriverManager.getConnection(URL, USER, PASSWORD);
			stmt = conn.createStatement();
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			throw new RuntimeException(e);
		}
	}
	
	public int update(String query) throws SQLException {
		//System.out.println(query);
		return stmt.executeUpdate(query);
	}
	
	public ResultSet select(String query) throws SQLException {
		//System.out.println(query);
		return stmt.executeQuery(query);
	}
	
	public ResultSet selectAll(String query) throws SQLException {
		//System.out.println(query);
		return stmt.executeQuery(query);
	}
	
	@Override
	protected void finalize() throws Throwable {
		if (stmt != null) stmt.close();
		if (conn != null) conn.close();
	} 
}
