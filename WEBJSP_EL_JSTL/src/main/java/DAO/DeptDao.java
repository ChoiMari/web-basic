package DAO;

import java.util.ArrayList;
import java.util.List;

import DTO.Dept;

public class DeptDao {
	public List<Dept> getDeptList(){
		//DB작업했다고 가정함
		//4건정도 얻음(부서4개 정보)
		List<Dept> list = new ArrayList<Dept>();
		list.add(new Dept(10,"AA","AAA"));
		list.add(Dept.builder().deptno(10).dname("BB").loc("BBB").build());
		list.add(new Dept(30,"CC","CCC"));
		list.add(new Dept(40,"DD","DDD"));
		
		return list;
	}
}
