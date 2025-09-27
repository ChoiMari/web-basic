package kr.or.bit.service;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.bit.action.Action;
import kr.or.bit.action.ActionForward;

public class RedirectService implements Action{

	@Override
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) {
		ActionForward forward = null;
		try {
			//리다이렉트 요청 처리
			String msg = (String)request.getAttribute("board_msg");
			String url = (String)request.getAttribute("board_url");
			  
			request.setAttribute("msg", msg);
			request.setAttribute("url", url);
			
			forward = new ActionForward();
			forward.setRedirect(false);
			forward.setPath("/WEB-INF/views/board/redirect.jsp");

		} catch (Exception e) {
			e.printStackTrace();
		}
		return forward;
	}

}
