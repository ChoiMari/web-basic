package kr.or.kosa.dao;


import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.or.kosa.dto.EmpDeptDto;
import kr.or.kosa.dto.EmpDto;
import kr.or.kosa.utils.ConnectionPoolHelper;

public class EmpDao {
	// 전체 조회
	public List<EmpDto> getEmpAllList(){
		List<EmpDto> empList = new ArrayList<EmpDto>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = ConnectionPoolHelper.getConnection(); 
			String sql = "select empno, ename, job, nvl(mgr, 0) as mgr, hiredate, sal, nvl(comm, 0) as comm, deptno from emp";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				do {
					empList.add(EmpDto.builder()
					.empno(rs.getInt("empno"))
					.ename(rs.getString("ename"))
					.job(rs.getString("job"))
					.mgr(rs.getInt("mgr"))
					.hiredate(rs.getDate("hiredate").toLocalDate())
					.sal(rs.getInt("sal"))
					.comm(rs.getInt("comm"))
					.deptno(rs.getInt("deptno")).build());
				}while(rs.next());
			}else {
				System.out.println("조회된 결과가 없습니다.");
			}
		}catch(Exception e) {
			System.out.println("[select DB 예외] " + e.getMessage());
		}finally {
			ConnectionPoolHelper.close(rs);
			ConnectionPoolHelper.close(pstmt);
			ConnectionPoolHelper.close(conn);
		}
		return empList;
	}
	
	//조건조회
	public EmpDto getEmpByEmpno(Integer empno) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		EmpDto emp = null;
		try {
			conn = ConnectionPoolHelper.getConnection(); 
			String sql = "select empno, ename, job, nvl(mgr, 0) as mgr, hiredate, sal, nvl(comm, 0) as comm, deptno from emp"
					+ " where empno = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, empno);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				emp = EmpDto.builder()
						.empno(rs.getInt("empno"))
						.ename(rs.getString("ename"))
						.job(rs.getString("job"))
						.mgr(rs.getInt("mgr"))
						.hiredate(rs.getDate("hiredate").toLocalDate())
						.sal(rs.getInt("sal"))
						.comm(rs.getInt("comm"))
						.deptno(rs.getInt("deptno")).build();
			}else {
				System.out.println("조회된 결과가 없습니다.");
			}
			
		}catch(Exception e) {
			System.out.println("[select DB 예외] " + e.getMessage());
		}finally {
			ConnectionPoolHelper.close(rs);
			ConnectionPoolHelper.close(pstmt);
			ConnectionPoolHelper.close(conn);
		}
		
		return emp;
	}
	
	//삽입
	public int insertEmp(EmpDto dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int resultRow = 0;
		try {
			conn = ConnectionPoolHelper.getConnection(); 
			String sql = "insert into emp(empno, ename, job, mgr, hiredate, sal, comm, deptno) "
					+ "values(?, ?, ?, ?, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getEmpno());
			pstmt.setString(2, dto.getEname());
			pstmt.setString(3, dto.getJob());
			pstmt.setInt(4, dto.getMgr());
			pstmt.setDate(5, Date.valueOf(dto.getHiredate()));
			pstmt.setInt(6, dto.getSal());
			pstmt.setInt(7, dto.getComm());
			pstmt.setInt(8, dto.getDeptno());
			resultRow = pstmt.executeUpdate();
			
			if(resultRow > 0) {
				System.out.println("정상 수행 건수: " + resultRow);
			} else {
				System.out.println("수행되지 않았습니다.");
			}
		}catch(Exception e) {
			System.out.println("[insert DB 예외] " + e.getMessage());
		}finally {

			ConnectionPoolHelper.close(pstmt);
			ConnectionPoolHelper.close(conn);
		}
		return resultRow;
	}
	
	//수정
	public int updateEmp(EmpDto dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int resultRow = 0;
		try {
			conn = ConnectionPoolHelper.getConnection(); 
			String sql = "update emp set ename = ?, job = ?, sal = ?, hiredate = ? where empno = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getEname());
			pstmt.setString(2, dto.getJob());
			pstmt.setInt(3, dto.getSal());
			pstmt.setDate(4, Date.valueOf(dto.getHiredate()));
			pstmt.setInt(5, dto.getEmpno());
			resultRow = pstmt.executeUpdate();
		}catch(Exception e) {
			System.out.println("[update DB 예외] " + e.getMessage());
		}finally {
		
			ConnectionPoolHelper.close(pstmt);
			ConnectionPoolHelper.close(conn);
		}
		return resultRow;
	}
	
	//삭제
	public int deleteEmp(int empno) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int resultRow = 0;
		String sql = "delete from emp where empno = ?";
		
		try {
			conn = ConnectionPoolHelper.getConnection(); 
			pstmt = conn.prepareStatement(sql); // 쿼리 쉐어드 풀에 준비시킴
			pstmt.setInt(1, empno); // 파라미터 보냄
			resultRow = pstmt.executeUpdate(); // 쿼리 실행
			
			if(resultRow > 0) {
				System.out.println("정상 수행 건수 : " + resultRow);
			}else {
				System.out.println("수행되지 않았습니다.");
			}
			
		}catch(Exception e) {
			System.out.println("[delete DB 예외] " + e.getMessage());
		}finally {
		
			ConnectionPoolHelper.close(pstmt);
			ConnectionPoolHelper.close(conn);
		}
		return resultRow;
	}
	
    //검색
	public List<EmpDeptDto> searchEmpByEname(String keyword){ 
		// 이름으로 사원 검색하기(동명이인이 가능함)
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<EmpDeptDto> list = new ArrayList<>();
		
		try {
			conn = ConnectionPoolHelper.getConnection(); 
			
			//rs.getString("e.ename") 이렇게 쓰면 에러난다..
			// alias를 써야함!!!
			String sql = "select e.empno as empno, e.ename as ename, e.deptno as deptno, d.dname as dname "
					+ "from emp e join dept d "
					+ "on e.deptno = d.deptno "
					+ "where e.ename like ?"; //-> 분석 순서상 select문에 쓴 alias는 where조건쓸때는 없음
			pstmt = conn.prepareStatement(sql); // DB서버의 쉐어드 풀에 sql 준비시킴
			pstmt.setString(1, "%" + keyword + "%"); // 파라미터 보냄
			rs = pstmt.executeQuery(); // 쿼리 실행
			
			if(rs.next()) {
				do {
					list.add(EmpDeptDto.builder()
							.empno(rs.getInt("empno"))
							.ename(rs.getString("ename"))
							.deptno(rs.getInt("deptno"))
							.dname(rs.getString("dname"))
							.build());
				}while(rs.next());
			}else {
				System.out.println("조회된 결과가 없습니다.");
			}
		}catch(Exception e) {
			System.out.println("[select DB 예외] " + e.getMessage());
		}finally {
			ConnectionPoolHelper.close(rs);
			ConnectionPoolHelper.close(pstmt);
			ConnectionPoolHelper.close(conn);
		}
		
		return list;
	}
	
    //검색 - 리턴타입 Map사용해봄 
	//key : 컬럼이름, value : 데이터
	public Map<String, Object> searchEmpByEnameMap(String keyword){ 
		// 이름으로 사원 검색하기(동명이인이 가능함)
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Map<String, Object> empDept= new HashMap<>();
		
		try {
			conn = ConnectionPoolHelper.getConnection(); 
			
			//rs.getString("e.ename") 이렇게 쓰면 에러난다..
			// alias를 써야함!!!
			String sql = "select e.empno as empno, e.ename as ename, e.deptno as deptno, d.dname as dname "
					+ "from emp e join dept d "
					+ "on e.deptno = d.deptno "
					+ "where e.ename like ?"; //-> 분석 순서상 select문에 쓴 alias는 where조건쓸때는 없음
			pstmt = conn.prepareStatement(sql); // DB서버의 쉐어드 풀에 sql 준비시킴
			pstmt.setString(1, "%" + keyword + "%"); // 파라미터 보냄
			rs = pstmt.executeQuery(); // 쿼리 실행
			
			if(rs.next()) {
				do {
					empDept.put("empno", rs.getInt("empno"));
					empDept.put("ename", rs.getString("ename"));
					empDept.put("deptno", rs.getInt("deptno"));
					empDept.put("dname", rs.getString("dname"));
				}while(rs.next());
			}else {
				System.out.println("조회된 결과가 없습니다.");
			}
		}catch(Exception e) {
			System.out.println("[select DB 예외] " + e.getMessage());
		}finally {
			ConnectionPoolHelper.close(rs);
			ConnectionPoolHelper.close(pstmt);
			ConnectionPoolHelper.close(conn);
		}
		
		return empDept;
	}
}
