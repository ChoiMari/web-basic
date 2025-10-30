package kr.or.bit.service;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.bit.action.Action;
import kr.or.bit.action.ActionForward;
/**
 * 게시글 삭제 서비스
 */
public class BoardDeleteService implements Action{

	@Override
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) {
		ActionForward forward = null;
		try {
			// 게시글 삭제
			String idx = request.getParameter("idx");
			request.setAttribute("idx", idx);
			forward = new ActionForward();
			forward.setRedirect(false);
			forward.setPath("/WEB-INF/views/board/board_delete.jsp");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return forward;
	}

}
