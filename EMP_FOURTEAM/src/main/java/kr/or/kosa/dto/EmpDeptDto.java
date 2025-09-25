package kr.or.kosa.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

@NoArgsConstructor @AllArgsConstructor @Builder
@Getter @ToString @EqualsAndHashCode
public class EmpDeptDto {
	private Integer empno;
	private String ename;
	private Integer deptno;
	private String dname;
}
