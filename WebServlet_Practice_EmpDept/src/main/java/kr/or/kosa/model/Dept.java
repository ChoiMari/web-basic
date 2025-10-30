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
public class Dept {
	private Integer deptno;
	private String dname;
	private String loc;
}
