package kr.or.kosa.action;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class ActionForward {
	private boolean isRedirect = false;
	private String path = null;
}
