package kr.or.bit.service;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.bit.action.Action;
import kr.or.bit.action.ActionForward;
import kr.or.bit.dao.BoardDao;
/**
 * 게시글 삭제 처리 서비스
 */
public class BoardDeleteOkService implements Action{

	@Override
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) {
		ActionForward forward = null;
		try {
			String idx = request.getParameter("idx");
			String pwd = request.getParameter("pwd");
			
			int result = new BoardDao().deleteOk(idx, pwd);
			
			String msg="";
			String url="";
			if(result > 0){
				msg="delete success";
				url="board_list.do";
			}else{
				msg="delete fail";
				url="board_list.do";
			}
			
			request.setAttribute("board_msg",msg);
			request.setAttribute("board_url",url);	
			
			forward = new ActionForward();
			forward.setRedirect(false);
			forward.setPath("/WEB-INF/views/board/board_deleteok.jsp");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return forward;
	}

}
