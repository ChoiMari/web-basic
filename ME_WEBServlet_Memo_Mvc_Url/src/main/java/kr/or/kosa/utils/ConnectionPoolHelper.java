package kr.or.kosa.utils;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class ConnectionPoolHelper {
	private static DataSource ds;
	static {
		try {
			Context context = new InitialContext();
			DataSource ds = (DataSource)context.lookup("java:comp/env/jdbc/oracle"); 
			//연결 정보 준것
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} 
	}
	
	public static Connection getConnection() throws SQLException{
		//호출부에서 예외 처리하게 함
		
		return ds.getConnection(); //연결객체 1개 빌려줘
	}
	
	public static void close(Connection conn) {
		if(conn != null) {
			try {
				conn.close(); // 반환하기
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	public static void close(ResultSet rs) {
		   if(rs != null) {
			   try {
				   rs.close();
				} catch (Exception e) {
					// TODO: handle exception
				}
		   }
	   }
	   public static void close(Statement stmt) {
		   if(stmt != null) {
			   try {
				   stmt.close();
				} catch (Exception e) {
					// TODO: handle exception
				}
		   }
	   }
	   
	   public static void close(PreparedStatement pstmt) {
		   if(pstmt != null) {
			   try {
				   pstmt.close();
				} catch (Exception e) {
					// TODO: handle exception
				}
		   }
	   }
}
