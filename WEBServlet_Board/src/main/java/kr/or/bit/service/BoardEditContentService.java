package kr.or.bit.service;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.bit.action.Action;
import kr.or.bit.action.ActionForward;
import kr.or.bit.dao.BoardDao;
import kr.or.bit.dto.Board;

/**
 * 게시글 수정 서비스
 */
public class BoardEditContentService implements Action{

	@Override
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) {
		ActionForward forward = null;
		try {
			String idx = request.getParameter("idx");
			if(idx == null || idx.trim().equals("")){
				response.sendRedirect("board_list.jsp"); //cpage=1 , ps=5
				return forward;
			}
			Board board = new BoardDao().getEditContent(idx);
			
			request.setAttribute("idx", idx);
			request.setAttribute("board", board);
			
			forward = new ActionForward();
			forward.setRedirect(false);
			forward.setPath("/WEB-INF/views/board/board_edit.jsp");
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return forward;
	}

}
