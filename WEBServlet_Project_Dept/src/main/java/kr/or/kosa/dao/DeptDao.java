package kr.or.kosa.dao;

import kr.or.kosa.dto.Dept;
import kr.or.kosa.utils.ConnectionPoolHelper;
import java.sql.*;
import java.util.*;

public class DeptDao {
	public List<Dept> findAll() throws SQLException {
		String sql = "SELECT deptno, dname, loc FROM dept ORDER BY deptno";
		try (Connection conn = ConnectionPoolHelper.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {
			List<Dept> list = new ArrayList<>();
			while (rs.next())
				list.add(new Dept(rs.getInt(1), rs.getString(2), rs.getString(3)));
			return list;
		}
	}

	public Dept findById(int deptno) throws SQLException {
		String sql = "SELECT deptno, dname, loc FROM dept WHERE deptno=?";
		try (Connection conn = ConnectionPoolHelper.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, deptno);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next())
					return new Dept(rs.getInt(1), rs.getString(2), rs.getString(3));
				return null;
			}
		}
	}

	public int insert(Dept d) throws SQLException {
		String sql = "INSERT INTO dept(deptno, dname, loc) VALUES(?,?,?)";
		try (Connection conn = ConnectionPoolHelper.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, d.getDeptno());
			ps.setString(2, d.getDname());
			ps.setString(3, d.getLoc());
			return ps.executeUpdate();
		}
	}

	public int update(Dept d) throws SQLException {
		String sql = "UPDATE dept SET dname=?, loc=? WHERE deptno=?";
		try (Connection conn = ConnectionPoolHelper.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, d.getDname());
			ps.setString(2, d.getLoc());
			ps.setInt(3, d.getDeptno());
			return ps.executeUpdate();
		}
	}

	public int delete(int deptno) throws SQLException {
		String sql = "DELETE FROM dept WHERE deptno=?";
		try (Connection conn = ConnectionPoolHelper.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, deptno);
			return ps.executeUpdate();
		}
	}
}