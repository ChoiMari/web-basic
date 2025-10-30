package kr.or.bit.service;

import javax.naming.NamingException;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.bit.action.Action;
import kr.or.bit.action.ActionForward;
import kr.or.bit.dao.BoardDao;
import kr.or.bit.dto.Board;

/**
 * 글쓰기 요청 서비스
 */
public class BoardWriteOkService implements Action{

	@Override
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) {
		ActionForward forward = null;

		try {
			//게시판 글쓰기 처리
			String subject = request.getParameter("subject");
			String writer = request.getParameter("writer");
			String email = request.getParameter("email");
			String homepage = request.getParameter("homepage");
			String content = request.getParameter("content");
			String pwd = request.getParameter("pwd");
			String filename = request.getParameter("filename");

			Board board = Board.builder().subject(subject).writer(writer).email(email).homepage(homepage)
					.content(content).pwd(pwd).filename(filename).build();
			BoardDao dao = new BoardDao();
			int result = dao.writeok(board);
			String msg = "";
			String url = "";
			if (result > 0) {
				msg = "insert success";
				url = "board_list.do";
			} else {
				msg = "insert fail";
				url = "board_write.do";
			}

			request.setAttribute("board_msg", msg);
			request.setAttribute("board_url", url);
			
			forward = new ActionForward();
			forward.setRedirect(false);
			forward.setPath("/WEB-INF/views/board/board_writeok.jsp");
		} catch (NamingException e) {
			e.printStackTrace();
		}
		
		
		return forward;
	}

}
