package kr.or.bit.action;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class ActionForward {
	private boolean isRedirect = false;
	private String path = null;
}
