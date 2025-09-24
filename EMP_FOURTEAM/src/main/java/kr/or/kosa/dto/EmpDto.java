package kr.or.kosa.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

@NoArgsConstructor @AllArgsConstructor @Builder
@Getter @ToString @EqualsAndHashCode
public class EmpDto {
	private Integer empno;
	private String ename;
	private String job;
	
	/**
	 * PRESIDENT은 null 있음 -> 0으로 바꾸고 0이면 없음이나 빈문자열로 UI에 출력하기
	 */
	private Integer mgr;
	
	private LocalDateTime hiredate;
	private Integer sal;
	
	/**
	 * null값 있음 -> 가져올때 0으로 바꿔서 가져오기
	 */
	private Integer comm; 
	private Integer deptno;

}
