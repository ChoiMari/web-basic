package kr.or.bit.service;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.bit.action.Action;
import kr.or.bit.action.ActionForward;
import kr.or.bit.dao.BoardDao;

public class BoardReplyOkService implements Action{

	@Override
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) {
		ActionForward forward = null;
		try {
			// 데이터 받기
			String writer = request.getParameter("reply_writer");
			String content = request.getParameter("reply_content");
			String pwd = request.getParameter("reply_pwd");
			String idx_fk = request.getParameter("idx");
			String userid = "empty";
			int result = new BoardDao().replywrite(Integer.parseInt(idx_fk), writer, userid, content, pwd);

			// 처리하는 코드
			String msg = "";
			String url = "";

			if (result > 0) {
				msg = "댓글 입력 성공";
				url = "board_content.do?idx=" + idx_fk;
			} else {
				msg = "댓글 입력 실패";
				url = "board_content.do?idx=" + idx_fk;
			}

			request.setAttribute("board_msg", msg);
			request.setAttribute("board_url", url);
			
			forward = new ActionForward();
			forward.setRedirect(false);
			forward.setPath("/WEB-INF/views/board/board_replyok.jsp");
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return forward;
	}

}
