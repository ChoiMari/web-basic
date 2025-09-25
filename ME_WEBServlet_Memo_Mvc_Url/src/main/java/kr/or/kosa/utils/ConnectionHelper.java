package kr.or.kosa.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

// 클래스 설계 많이 사용 -> 편하게 -> static
public class ConnectionHelper {
	public static Connection getConnection(DBType dbType) {
		Connection conn = null;
		try {
			Class.forName("oracle.jdbc.OracleDriver");
			switch(dbType) {
			case ORACLE:
				conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","KOSA","1004");
				break;
			case MARIADB:
				//MariaDB는 SID개념 없음, 대신 데이터베이스이름 사용함
				conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/testdb","root","1004");
				break;
			}
		}catch(Exception e) {
			System.err.println("connection Factory : " + e.getMessage());
		}
		return conn; // 연결 객체(Connection) 주소값 리턴
	} 
	
	//오버로딩 : 비슷한 기능이면 파라미터 타입, 개수만 다르게
	public static Connection getConnection(DBType dbType, String id, String pw) {
		Connection conn = null;
		try {
			switch(dbType) {
			case ORACLE:
				conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe",id,pw);
				break;
			case MARIADB:
				conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shopdb",id,pw);
				break;
			}
		}catch(Exception e) {
			System.err.println("connection Factory : " + e.getMessage());
		}
		return conn; // 연결 객체(Connection) 주소값 리턴
	} 
	
	public static void close(Connection conn) {
		if(conn != null) {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	public static void close(ResultSet rs) {
		if(rs != null) {
			try {
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	public static void close(Statement stmt) {
		if(stmt != null) {
			try {
				stmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	public static void close(PreparedStatement pstmt) {
		if(pstmt != null) {
			try {
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
}
