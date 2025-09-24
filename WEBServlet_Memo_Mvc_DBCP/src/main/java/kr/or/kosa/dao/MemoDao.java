package kr.or.kosa.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import kr.or.kosa.dto.Memo;
import kr.or.kosa.utils.ConnectionHelper;
import kr.or.kosa.utils.ConnectionPoolHelper;
import kr.or.kosa.utils.DBType;

// 커넥션 풀 적용


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
			
		conn = ConnectionPoolHelper.getConnection();//->pool로 전환
			//conn = ConnectionHelper.getConnection(DBType.ORACLE);
			
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
			//conn = ConnectionHelper.getConnection(DBType.ORACLE);
			conn = ConnectionPoolHelper.getConnection();//->pool로 전환
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery(); // 쿼리 실행
			
			//결과가 없을 수도 있으니까 확인
			if(rs.next()) {
				memo = Memo.builder()
						.id(rs.getString("id"))
						.email(rs.getString("email"))
						.content(rs.getString("content"))
						.build();
			}else {
				System.out.println("조회된 결과가 없습니다.");
			}	
		}catch(Exception e) {
			System.out.println("DB예외 - select(조건조회) : " + e.getMessage());
		}finally {
//			ConnectionHelper.close(rs);
//			ConnectionHelper.close(pstmt);
//			ConnectionHelper.close(rs);
			
			ConnectionPoolHelper.close(rs);
			ConnectionPoolHelper.close(pstmt);
			ConnectionPoolHelper.close(conn);
		}
		
		return memo; // 조회된 결과가 없으면 null이 리턴되기 때문에
		//호출 부에서 null검사필요
	}
	
	//수정
	public int updateMemo(Memo memo) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "update memo set email=? , content=? where id=?";
		int resultRow = 0;
		try {
			//conn = ConnectionHelper.getConnection(DBType.ORACLE);
			conn = ConnectionPoolHelper.getConnection();//->pool로 전환
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memo.getEmail());
			pstmt.setString(2, memo.getContent());
			pstmt.setString(3, memo.getId());
			
			resultRow = pstmt.executeUpdate();
			//executeUpdate() : insert, update, delete
		}catch(Exception e) {
			System.out.println("예외발생 : " + e.getMessage());
		}finally {
//			ConnectionHelper.close(rs);
//			ConnectionHelper.close(pstmt);
//			ConnectionHelper.close(conn);
			ConnectionPoolHelper.close(rs);
			ConnectionPoolHelper.close(pstmt);
			ConnectionPoolHelper.close(conn);
		}
		return resultRow; // 업데이트된 행이 없으면 0리턴
	}
	
	//삽입
	public int insertMemo(Memo memo) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "insert into memo(id,email,content) values(?,?,?)";
		int resultRow = 0;
		try {
			//conn = ConnectionHelper.getConnection(DBType.ORACLE);
			conn = ConnectionPoolHelper.getConnection();//->pool로 전환
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memo.getId());
			pstmt.setString(2, memo.getEmail());
			pstmt.setString(3, memo.getContent());
			
			resultRow = pstmt.executeUpdate();
			//executeUpdate() : insert, update, delete
		}catch(Exception e) {
			System.out.println("예외발생 : " + e.getMessage());
		}finally {
//			ConnectionHelper.close(rs);
//			ConnectionHelper.close(pstmt);
//			ConnectionHelper.close(conn);
			ConnectionPoolHelper.close(rs);
			ConnectionPoolHelper.close(pstmt);
			ConnectionPoolHelper.close(conn);
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
			//conn = ConnectionHelper.getConnection(DBType.ORACLE);
			conn = ConnectionPoolHelper.getConnection();//->pool로 전환
			pstmt = conn.prepareStatement(sql); 
			resultRow = pstmt.executeUpdate(); // 쿼리 실행
		}catch(Exception e){
			System.out.println("DB delete 예외 발생 : " + e.getMessage());
		}finally {
//			ConnectionHelper.close(pstmt);
//			ConnectionHelper.close(conn);

//			ConnectionPoolHelper.close(pstmt);
//			ConnectionPoolHelper.close(conn);
			
	
			ConnectionPoolHelper.close(pstmt);
			ConnectionPoolHelper.close(conn);
		}
		return resultRow;
	}
	
	//필요에 따라서 검색(like 등) - 이메일로 검색
	public Memo seachByEmail(String email){ // 결과 1개나옴(이메일 유니크 - 고유데이터 전제)
		String sql = "select id, email, content from memo "
				+ "where email like ?"; //파라미터에 %%추가하면됨
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Memo memo = null;
		try {
			//conn = ConnectionHelper.getConnection(DBType.ORACLE);
			conn = ConnectionPoolHelper.getConnection();//->pool로 전환
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%" + email + "%");
			rs = pstmt.executeQuery();

			//조회되지 않은 결과가 있을 수 있으니 처리
			if(rs.next()) {
				memo = Memo.builder()
						.id(rs.getString("id"))
						.email(rs.getString("email"))
						.content(rs.getString("content"))
						.build();
			}else {
				System.out.println("조회된 결과가 없습니다.");
			}
			
		}catch(Exception e) {
			System.out.println("[DB-Like 예외발생] : " + e.getMessage());
		}finally {
//			ConnectionHelper.close(rs);
//			ConnectionHelper.close(pstmt);
//			ConnectionHelper.close(conn);
			ConnectionPoolHelper.close(rs);
			ConnectionPoolHelper.close(pstmt);
			ConnectionPoolHelper.close(conn);
		}
		
		return memo;
	}
	
	public List<Memo> seachMemosByEmail(String email){ // 결과 1개나옴(이메일 유니크 - 고유데이터 전제)
		String sql = "select id, email, content from memo "
				+ "where email like ?"; //파라미터에 %%추가하면됨
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<Memo> memoList = new ArrayList<Memo>();
		try {
			//conn = ConnectionHelper.getConnection(DBType.ORACLE);
			conn = ConnectionPoolHelper.getConnection();//->pool로 전환
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%" + email + "%");
			rs = pstmt.executeQuery();

			if(rs.next()) {
				do { // 최소 1번 실행 보장
					memoList.add(Memo.builder()
							.id(rs.getString("id"))
							.email(rs.getString("email"))
							.content(rs.getString("content"))
							.build());
				}while(rs.next());
			}else {
				System.out.println("조회된 결과가 없습니다.");
			}
			
			/*
			while(rs.next()) {
				memoList.add(Memo.builder()
						.id(rs.getString("id"))
						.email(rs.getString("email"))
						.content(rs.getString("content"))
						.build());
			}
			*/
			
		}catch(Exception e) {
			System.out.println("[DB-Like 예외발생] : " + e.getMessage());
		}finally {
//			ConnectionHelper.close(rs);
//			ConnectionHelper.close(pstmt);
//			ConnectionHelper.close(conn);
			ConnectionPoolHelper.close(rs);
			ConnectionPoolHelper.close(pstmt);
			ConnectionPoolHelper.close(conn);
		}
		
		return memoList;
	}
	
	public Memo idSeachByEmail(String email){ // 결과 1개나옴(이메일 유니크 - 고유데이터 전제)
		String sql = "select id from memo "
				+ "where email like ?"; //파라미터에 %%추가하면됨
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Memo memo = null;
		try {
			//conn = ConnectionHelper.getConnection(DBType.ORACLE);
			conn = ConnectionPoolHelper.getConnection();//->pool로 전환
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%" + email + "%");
			rs = pstmt.executeQuery();
			
			if(rs.next()) { // 조회 결과 없을 수 있으니 확인
				//결과 여러개 나오면 while문(rs.next()) + list에 담기
				memo = Memo.builder()
				.id(rs.getString("id"))
				.build();
			}else {
				System.out.println("조회된 결과가 없습니다.");
			}
			
		}catch(Exception e) {
			System.out.println("[DB-Like 예외발생] : " + e.getMessage());
		}finally {
//			ConnectionHelper.close(rs);
//			ConnectionHelper.close(pstmt);
//			ConnectionHelper.close(conn);
			
			ConnectionPoolHelper.close(rs);
			ConnectionPoolHelper.close(pstmt);
			ConnectionPoolHelper.close(conn);
		}
		
		return memo;
	}
	
	//id유무 조회
	public boolean isCheckById(String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "select id from memo where id = ?";
		boolean result = false;
		
		try {
			//conn = ConnectionHelper.getConnection(DBType.ORACLE);
			conn = ConnectionPoolHelper.getConnection();//->pool로 전환
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				//id필요하면 
				//String resultId = rs.getString("id");
				//System.out.println("찾은 id : " + resultId);
				
				//실행되면 있는 것
				result = true; // return true; 해도됨
			}else {
				System.out.println("아이디 없음");
			}
			
		}catch(Exception e) {
			System.out.println("[DB예외 - checkById] : " + e.getMessage());
		}finally {
//			ConnectionHelper.close(rs);
//			ConnectionHelper.close(pstmt);
//			ConnectionHelper.close(conn);
			ConnectionPoolHelper.close(rs);
			ConnectionPoolHelper.close(pstmt);
			ConnectionPoolHelper.close(conn);
		}
		return result;
	}
}
