package kr.or.bit.dto;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter @ToString @EqualsAndHashCode 
@NoArgsConstructor @AllArgsConstructor @Builder
public class Reply {
	private int no;
	private String writer;
	private String userid;
	private String pwd;
	private String content;
	private Date writedate;
	private int idx_fk;
		
}
