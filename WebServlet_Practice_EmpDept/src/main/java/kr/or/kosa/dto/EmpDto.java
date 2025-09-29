package kr.or.kosa.dto;

import java.time.LocalDate;

import kr.or.kosa.model.Emp;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;
@AllArgsConstructor @NoArgsConstructor
@Builder @ToString @EqualsAndHashCode @Getter
public class EmpDto {
	private Integer empno;
	private String ename;
	//private String job;
	private Integer sal;
	private LocalDate hiredate;
	private Integer deptno;
	private Integer mgr; //null데이터 있음
	//private Integer comm; //null데이터 있음
	
	public Emp toEntity() {
	    return Emp.builder()
	            .empno(this.empno)
	            .ename(this.ename)
	            .sal(this.sal)
	            .hiredate(this.hiredate)
	            .deptno(this.deptno)
	            .mgr(this.mgr)
	            .build();
	}
	
	public static EmpDto fromEntity(Emp emp) {
	    if(emp == null) return null;
	    return EmpDto.builder()
	            .empno(emp.getEmpno())
	            .ename(emp.getEname())
	            //.job(emp.getJob()) // 제거
	            .mgr(emp.getMgr())
	            .hiredate(emp.getHiredate())
	            .sal(emp.getSal())
	            //.comm(emp.getComm()) // 제거
	            .deptno(emp.getDeptno())
	            .build();
	}

}
