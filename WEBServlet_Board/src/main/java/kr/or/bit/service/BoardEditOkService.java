package kr.or.bit.service;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.bit.action.Action;
import kr.or.bit.action.ActionForward;
import kr.or.bit.dao.BoardDao;

public class BoardEditOkService implements Action{

	@Override
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) {
		ActionForward forward = null;
		try {
			// 게시글 수정 처리
			  //1. board_edit.jsp > 입력값 받기 > board dto 객체에 담기
			  
			  //방법 1) request.getParameter("subject") > new Board > setter > request > return Board
			  //가장 일반적인 방법 		  
					  
			  //방법 2) usebean 액션태그 (property )통해서 setter  주입
			  

			  //방법 3) request 객체를 통으로 넘기는 방법 (이 방법) >> 실습코드 ...
			String idx = request.getParameter("idx");
			int result = new BoardDao().boardEdit(request);
			  
				String msg="";
				String url="";
				
				if(result > 0){
					msg="edit success";
					url="board_list.do";
				}else{
					msg="edit fail : 비밀번호 틀렸다!";
					url="board_edit.do?idx="+idx;
				}
				
				request.setAttribute("board_msg",msg);
				request.setAttribute("board_url",url);
				forward = new ActionForward();
				forward.setRedirect(false);
				forward.setPath("/WEB-INF/views/board/board_editok.jsp");
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return forward;
	}

}
