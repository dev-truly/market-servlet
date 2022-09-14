package com.example.marketproject.config;

import java.sql.*;



public class Database {
	final String DBDriverName = "com.mysql.cj.jdbc.Driver";
	final String URL = "jdbc:mysql://localhost:3356/tj?characterEncoding=utf8";
	final String USER = "root";
	final String PASSWORD = "love1004";
	
	public Connection conn;
	public Statement stmt;

	public int lastInsertId;
	
	public Database() {
		try {
			Class.forName(DBDriverName);
			conn = DriverManager.getConnection(URL, USER, PASSWORD);
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			throw new RuntimeException(e);
		}
	}
	
	public int update(String query) throws SQLException {
		int result = stmt.executeUpdate(query, Statement.RETURN_GENERATED_KEYS);
		ResultSet rs = stmt.getGeneratedKeys();
		if (rs.next()) {
			lastInsertId = rs.getInt(1);
		}

		return result;
	}
	
	public ResultSet select(String query) throws SQLException {
		//System.out.println(query);
		ResultSet rs = stmt.executeQuery(query);
		return rs;
	}
	
	public ResultSet selectAll(String query) throws SQLException {
		//System.out.println(query);
		ResultSet rs = stmt.executeQuery(query);
		return rs;
	}
	
	@Override
	protected void finalize() throws Throwable {
		if (stmt != null) stmt.close();
		if (conn != null) conn.close();
	} 
}
