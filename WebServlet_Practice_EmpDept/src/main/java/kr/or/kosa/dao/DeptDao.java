package kr.or.kosa.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import kr.or.kosa.model.Dept;
import kr.or.kosa.utils.ConnectionPoolHelper;

public class DeptDao {
	// 전체 부서 조회
    public List<Dept> getAllDept() {
        List<Dept> deptList = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = ConnectionPoolHelper.getConnection();
            String sql = "SELECT deptno, dname, loc FROM dept ORDER BY deptno";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while(rs.next()) {
                Dept dept = Dept.builder()
                        .deptno(rs.getInt("deptno"))
                        .dname(rs.getString("dname"))
                        .loc(rs.getString("loc"))
                        .build();
                deptList.add(dept);
            }

        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            ConnectionPoolHelper.close(rs);
            ConnectionPoolHelper.close(pstmt);
            ConnectionPoolHelper.close(conn);
        }

        return deptList;
    }
 // DeptDao.java
    public Dept getDeptByDeptno(int deptno) {
        Dept dept = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = ConnectionPoolHelper.getConnection();
            String sql = "SELECT deptno, dname, loc FROM dept WHERE deptno = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, deptno);
            rs = pstmt.executeQuery();

            if(rs.next()) {
                dept = Dept.builder()
                           .deptno(rs.getInt("deptno"))
                           .dname(rs.getString("dname"))
                           .loc(rs.getString("loc"))
                           .build();
            }

        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            ConnectionPoolHelper.close(rs);
            ConnectionPoolHelper.close(pstmt);
            ConnectionPoolHelper.close(conn);
        }

        return dept;
    }
    
    
    
}
