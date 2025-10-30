package kr.or.kosa.action;
//톰캣 버전에 따라 import가 다름
//톰캣 10.X 이상은 jakarta
// 그 이하는 javax
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * 앞으로 생성되는 모든 서비스는 Action 인터페이스를 구현하도록 하겠다
 */
public interface Action {
	ActionForward execute(HttpServletRequest request, HttpServletResponse response);
}
