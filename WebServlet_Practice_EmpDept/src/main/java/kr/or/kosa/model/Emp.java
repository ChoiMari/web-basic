package kr.or.kosa.model;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;
@AllArgsConstructor @NoArgsConstructor
@Builder @ToString @EqualsAndHashCode @Getter
public class Emp {
	private Integer empno;
	private String ename;
	private String job;
	private Integer mgr; //null데이터 있음
	private LocalDate hiredate;
	private Integer sal;
	private Integer comm; //null데이터 있음
	private Integer deptno;
}
