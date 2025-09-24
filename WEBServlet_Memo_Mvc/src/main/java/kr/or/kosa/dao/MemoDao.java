package kr.or.kosa.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import kr.or.kosa.dto.Memo;
import kr.or.kosa.utils.ConnectionHelper;
import kr.or.kosa.utils.DBType;

/*
DB연결
CRUD 함수 생성 > memo
1. 전체조회  : select id , email , content from memo
2. 조건조회  : select id , email , content from memo where id=? //제약 id >pk
3. 삽입     : insert into memo(id,email,content) values(?,?,?)
4. 수정     : update memo set email=? , content=? where id=?
5. 삭제     : delete from memo where id=?
알파... LIKE 검색  where email like '%naver%'

자바로 함수를 생성 .... 처리 ... 거의 똑같아요
ArrayList
HashMap
제너릭 ...
*/


/*
create table memo(
   id varchar2(20) not null,
   email varchar2(20) not null,
   content varchar2(100)
); 
*/
public class MemoDao {
	//전체 조회
	public List<Memo> getMemoList() throws SQLException{
		//throws SQLException 호출하는 곳에 강제로 예외처리(try-catch) 의무 씌움
		List<Memo> list = new ArrayList<Memo>(); // 결과값 담을 list
		String sql = "select id, email, content from memo"; // 실행할 쿼리문
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
			conn = ConnectionHelper.getConnection(DBType.ORACLE);
			//-> 나중에 pool로 전환
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();//실행하고 결과 담음
			while(rs.next()) {
				Memo memo = new Memo();
				memo.setId(rs.getString("id"));
				memo.setEmail(rs.getString("email"));
				memo.setContent(rs.getString("content"));
				list.add(memo);
			}
		
		return list;
	}
	
	//조건조회
	public Memo getMemoListById(String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select id, email, content from memo where id = ?";
		Memo memo = null;
		try {
			conn = ConnectionHelper.getConnection(DBType.ORACLE);
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery(); // 쿼리 실행
			
			memo = Memo.builder()
			.id(rs.getString("id"))
			.email(rs.getString("email"))
			.content(rs.getString("content"))
			.build();
			
		}catch(Exception e) {
			System.out.println("DB예외 - select(조건조회) : " + e.getMessage());
		}finally {
			ConnectionHelper.close(rs);
			ConnectionHelper.close(pstmt);
			ConnectionHelper.close(rs);
		}
		
		return memo;
	}
	
	//삽입
	public int updateMemo(Memo memo) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "update memo set email=? , content=? where id=?";
		int resultRow = 0;
		try {
			conn = ConnectionHelper.getConnection(DBType.ORACLE);
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memo.getEmail());
			pstmt.setString(2, memo.getContent());
			pstmt.setString(3, memo.getId());
			
			resultRow = pstmt.executeUpdate();
			//executeUpdate() : insert, update, delete
		}catch(Exception e) {
			System.out.println("예외발생 : " + e.getMessage());
		}finally {
			ConnectionHelper.close(rs);
			ConnectionHelper.close(pstmt);
			ConnectionHelper.close(conn);
		}
		return resultRow;
	}
	
	//수정
	public int insertMemo(Memo memo) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "insert into memo(id,email,content) values(?,?,?)";
		int resultRow = 0;
		try {
			conn = ConnectionHelper.getConnection(DBType.ORACLE);
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memo.getId());
			pstmt.setString(2, memo.getEmail());
			pstmt.setString(3, memo.getContent());
			
			resultRow = pstmt.executeUpdate();
			//executeUpdate() : insert, update, delete
		}catch(Exception e) {
			System.out.println("예외발생 : " + e.getMessage());
		}finally {
			ConnectionHelper.close(rs);
			ConnectionHelper.close(pstmt);
			ConnectionHelper.close(conn);
		}
		return resultRow;
	
	}
	
	//삭제
	public int deleteMemo(String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int resultRow = 0;
		String sql = "delete from memo where id = ?";
		
		try{
			conn = ConnectionHelper.getConnection(DBType.ORACLE);
			pstmt = conn.prepareStatement(sql); 
			resultRow = pstmt.executeUpdate(); // 쿼리 실행
		}catch(Exception e){
			System.out.println("DB delete 예외 발생 : " + e.getMessage());
		}finally {
			ConnectionHelper.close(pstmt);
			ConnectionHelper.close(conn);
		}
		return resultRow;
	}
	
	//필요에 따라서 검색(like 등) - 이메일로 검색
	public Memo idSeachByEmail(String email){ // 결과 1개나옴(이메일 유니크 - 고유데이터 전제)
		return null;
	}
	
	//id유무 조회
	public boolean isCheckById(String id) {
		return false;
	}
}
