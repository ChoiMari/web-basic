package kr.or.kosa.dto;

import kr.or.kosa.model.Dept;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

@AllArgsConstructor @NoArgsConstructor
@Builder @ToString @EqualsAndHashCode @Getter
public class DeptDto {
	private Integer deptno;
	private String dname;
	private String loc;
	
    public static DeptDto fromEntity(Dept dept) {
        if (dept == null) return null;
        return DeptDto.builder()
                .deptno(dept.getDeptno())
                .dname(dept.getDname())
                .loc(dept.getLoc())
                .build();
    }
	
	public Dept toEntity() {
        return Dept.builder()
                .deptno(this.deptno)
                .dname(this.dname)
                .loc(this.loc)
                .build();
    }
}
