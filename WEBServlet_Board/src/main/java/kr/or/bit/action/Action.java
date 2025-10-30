package kr.or.bit.action;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * 모든 서비스는 Action 인터페이스를 구현하도록 하겠다.
 */
public interface Action {
	ActionForward excute(HttpServletRequest request, HttpServletResponse response);
}
