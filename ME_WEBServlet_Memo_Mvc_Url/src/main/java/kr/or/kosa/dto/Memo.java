package kr.or.kosa.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/*
 create table memo(
    id varchar2(20) not null,
    email varchar2(20) not null,
    content varchar2(100)
); 
 */
@NoArgsConstructor @AllArgsConstructor @Getter @Builder
@ToString @EqualsAndHashCode @Setter
public class Memo {
	private String id; 
	private String email;
	private String content;
}
