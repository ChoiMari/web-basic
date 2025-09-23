package com.board;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Servlet implementation class FrontBoardController
 */
@WebServlet(description = "게시판 Front 역할을 하는 servlet이다", urlPatterns = { "/Board" })
public class FrontBoardController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public FrontBoardController() {
        super();
        // TODO Auto-generated constructor stub
    }
    
	private void doProcess(HttpServletRequest request, HttpServletResponse response
			, String method) throws ServletException, IOException {
		//doGet과 doPost의 논리가 동일하다면 이거 1개로 처리
		System.out.println("클라이언트의 요청 방식 : " + method);
		
		//1.한글처리
		request.setCharacterEncoding("UTF-8"); //-> 나중엔 필터로 처리
		//2.데이터 받기
		//2.1 데이터를 받는 방식은 2가지
		//-> command방식, url방식
		//-> url을 더 선호
		//커맨드 방식 : data.do?cmd=write 파라미터로 요구사항 판단. 글쓰기
		//url방식 : list.do같은 url 주소 전체를 파싱해서 의미를 부여함

		//cmd방식으로 해봄
		String cmd = request.getParameter("cmd");
		//cmd에 null이 들어오면 error.jsp
		//cmd=boardlist일 경우 list.jsp
		//cmd=boardwrite일 경우 write.jsp 
		// 이 규칙은 개발자가 정의함
		String viewPage = null;
		// 비지니스 수행(요구사항) : 암호화 , 관리자 페이지, DB연결 등
		if(cmd == null) {
			viewPage = "/error/error.jsp";
			
		}else if(cmd.equals("boardlist")) {
			/*
			 Model이 만들어져 있다면
			 DTO Board
			 DAO BoardDao에 CRUD 메서드가 있음
			 
			  BoardDao dao = new BoardDao();
			  list<Board> list = boardDao.getAllBoardList();
			  
			  먼저 데이터 담음
			  request.setAttribute("list")
			  -> view로 포워드 시킴
			  
			 */
			
			// 했다고 치고
			viewPage = "/board/boardlist.jsp";
		}else if(cmd.equals("boardwrite")) {
			viewPage = "/board/boardwrite.jsp";
		}else if(cmd.equals("boarddelete")) {
			//viewPage = "/board/boarddelete.jsp";
		}else if(cmd.equals("login")) {
			viewPage = "/WEB-INF/views/login/login.jsp";
			//내부에서는/WEB-INF 보안 디렉토리에 접근 가능함
			//-> 보안 폴더에 들어간건 클라이언트가 직접 접근 X
		}else{
			viewPage = "/error/error.jsp";
		}
		//4. 결과 저장(데이터 담기)		`	````````````````````````````````````
		// 전체 페이지에서 필요하면 세션객체에 담음(셋어트리뷰트로)
		//현재페이지에서만 쓸거면 요청객체에담고 -> 포워드 시킴(그럼 jsp에 전달가능)
		//request.setAttribute("list", list); 담았다고 침
		
		//5.view지정
		RequestDispatcher dis = request.getRequestDispatcher(viewPage);
		
		dis.forward(request, response);//포워드 시킴
		//포워드 시켜야 jsp에서 요청객체에서 접근 가능하기 때문에
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response, "GET");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response, "POST");
	}

}
