package kr.or.kosa.action;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public interface Action {
	ActionForward excute(HttpServletRequest request, HttpServletResponse response);
}
