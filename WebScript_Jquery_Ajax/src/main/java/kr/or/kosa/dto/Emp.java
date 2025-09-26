package kr.or.kosa.dto;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class Emp {
	private Integer empno;
	private String ename;
	private String job;
	private Integer mgr;
	//private LocalDate hiredate;
	private Integer sal;
	private Integer comm; 
	private Integer deptno;
}
