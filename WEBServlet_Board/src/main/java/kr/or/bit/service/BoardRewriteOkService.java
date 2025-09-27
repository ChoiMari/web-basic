package kr.or.bit.service;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.bit.action.Action;
import kr.or.bit.action.ActionForward;
import kr.or.bit.dao.BoardDao;
import kr.or.bit.dto.Board;
/**
 * 답글 처리 서비스
 */
public class BoardRewriteOkService implements Action{

	@Override
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) {
		ActionForward forward = null;
		try {
			String idx = request.getParameter("idx");
			String subject = request.getParameter("subject");
			String writer = request.getParameter("writer");
			String email = request.getParameter("email");
			String homepage = request.getParameter("homepage");
			String content = request.getParameter("content");
			String pwd = request.getParameter("pwd");
			String filename = request.getParameter("filename");
			Board board = Board.builder().idx(Integer.parseInt(idx)).subject(subject).writer(writer).email(email).homepage(homepage)
					.content(content).pwd(pwd).filename(filename).build();
			int result = new BoardDao().reWriteOk(board);
			
			//list 이동시 현재 pagesize , cpage
			String cpage = request.getParameter("cp"); //current page
			String pagesize = request.getParameter("ps"); //pagesize
			//코드는 필요에 따라서  url ="board_list.jsp?cp=<%=cpage";
			String msg="";
		    String url="";
		    if(result > 0){
		    	msg ="rewrite insert success";
		    	url ="board_list.do";
		    }else{
		    	msg="rewrite insert fail";
		    	url="board_content.do?idx="+board.getIdx();
		    }
		    
		    request.setAttribute("board_msg",msg);
		    request.setAttribute("board_url", url);
		    
		    forward = new ActionForward();
		    forward.setRedirect(false);
		    forward.setPath("/WEB-INF/views/board/board_rewriteok.jsp");
		   
		} catch (Exception e) {
			e.printStackTrace();
		}
		return forward;
	}

}
