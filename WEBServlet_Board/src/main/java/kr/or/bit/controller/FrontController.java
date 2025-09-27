package kr.or.bit.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.bit.action.Action;
import kr.or.bit.action.ActionForward;
import kr.or.bit.dto.Board;
import kr.or.bit.dto.Reply;
import kr.or.bit.service.BoardContentDetailService;
import kr.or.bit.service.BoardDeleteOkService;
import kr.or.bit.service.BoardDeleteService;
import kr.or.bit.service.BoardEditContentService;
import kr.or.bit.service.BoardEditOkService;
import kr.or.bit.service.BoardService;
import kr.or.bit.service.BoardListAllService;
import kr.or.bit.service.BoardReplyDeleteOkService;
import kr.or.bit.service.BoardReplyOkService;
import kr.or.bit.service.BoardRewriteOkService;
import kr.or.bit.service.BoardRewriteService;
import kr.or.bit.service.BoardWriteOkService;
import kr.or.bit.service.RedirectService;
import kr.or.bit.utils.ThePager;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.naming.NamingException;


@WebServlet("*.do")
public class FrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    public FrontController() {
        super();
    }

	private void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//한글처리 -> 필터에서 함
		//데이터 받기 -> URL방식 사용
		String requestUri = request.getRequestURI();
		String contextPath = request.getContextPath();
		String urlCommand = requestUri.substring(contextPath.length());
		
		System.out.println(urlCommand); //-> 디버깅용

		Action action = null;
		ActionForward forward = null;
		
		//요청주소에 따른 화면 제어 - url방식
		if(urlCommand.equals("/board_write.do")) {
			//UI만 필요해서 뷰만 지정함
			forward = new ActionForward();
			forward.setRedirect(false); // 리다이렉트 안하겠다
			forward.setPath("/WEB-INF/views/board/board_write.jsp");
			
		}else if(urlCommand.equals("/board_writeok.do")) {
			action = new BoardWriteOkService();
			forward = action.excute(request, response); //다형성

		} else if(urlCommand.equals("/board_list.do")) { // 전체목록보기페이지
			action = new BoardListAllService();
			forward = action.excute(request, response);
			
		} else if(urlCommand.equals("/board_content.do")) {//글 상세보기
			action = new BoardContentDetailService();
			forward = action.excute(request, response);
		}
		else if(urlCommand.equals("/board_edit.do")) {
			// 게시글수정
			action = new BoardEditContentService();
			forward = action.excute(request, response);
		} else if(urlCommand.equals("/board_editok.do")) {
			action = new BoardEditOkService();
			forward = action.excute(request, response);
		} else if(urlCommand.equals("/board_delete.do")) {
			action = new BoardDeleteService();
			forward = action.excute(request, response);
		} else if(urlCommand.equals("/board_deleteok.do")) {
			action = new BoardDeleteOkService();
			forward = action.excute(request, response);
		}else if(urlCommand.equals("/board_rewrite.do")) {
			action = new BoardRewriteService();
			forward = action.excute(request, response);	
		}else if(urlCommand.equals("/WEB-INF/views/board/redirect.do")) {
			//리다이렉트 요청 처리
			action = new RedirectService();
			forward = action.excute(request, response);
			
		}else if(urlCommand.equals("/board_rewriteok.do")) {
			action = new BoardRewriteOkService();
			forward = action.excute(request, response);
		}else if(urlCommand.equals("/board_replyok.do")) {
			action = new BoardReplyOkService();
			forward = action.excute(request, response);
		}else if(urlCommand.equals("/boardreply_deleteOk.do")) {
			action = new BoardReplyDeleteOkService();
			forward = action.excute(request, response);
		}
		
		if(forward != null) {
			if(forward.isRedirect()) {
				//true면 location.href ="페이지"
				//보통 이렇게 안쓴다..
				response.sendRedirect(forward.getPath());
			} else {
				//forward의 의미
				//-> 데이터 처리하겠다
				RequestDispatcher dis = request.getRequestDispatcher(forward.getPath());
				dis.forward(request, response);
			}
		}
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

}
