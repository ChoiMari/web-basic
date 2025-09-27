package kr.or.kosa.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.kosa.action.Action;
import kr.or.kosa.action.ActionForward;
import kr.or.kosa.service.MemoAddService;
import kr.or.kosa.service.MemoIdCheckService;
import kr.or.kosa.service.MemoListService;

import java.io.IOException;

@WebServlet("*.memo") // action="list.memo"
public class FrontMemoController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public FrontMemoController() {
        super();
    
    }
    
    
	private void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//한글처리 - 필터로 처리함 request.setCharacterEncoding("UTF-8");
		
		//데이터 받고 판단 - commend, url방식
		// 커멘드방식 예시(파라미터로 판단) list.do?cmd=list 또는 write.do?cmd=write
		
		// 주로 url 방식을 사용 : 파싱
		String requestUri = request.getRequestURI();
		String contextPath = request.getContextPath();
		String urlCommand = requestUri.substring(contextPath.length());
		
		System.out.println("urlCommand = " + urlCommand);
		
		Action action = null;
		ActionForward forward = null;
		
		//기준 - 화면을 줄건지, 처리를 할건지
		// 처리에는 이동이 필요(리다이렉트)
		//switch써도 됨
		if(urlCommand.equals("/MemoAdd.memo")) { 
			// 글쓰기(UI + 로직)
			action = new MemoAddService(); //다형성
			forward = action.execute(request, response);
		}else if(urlCommand.equals("/MemoList.memo")) {
			//목록보기(UI + 로직)
			action = new MemoListService(); //다형성
			forward = action.execute(request, response);
		}else if(urlCommand.equals("/MemoId.memo")) {
			//(UI + 로직)
			//비동기를 동일한 서비스? 별도의 서비스?
			//-> 비동기는 별도의 서비스를 권장함
			//비동기는 데이터만 전달하면 되기 때문에...
			// 페이지를 만들어 주는 건 아니라서..
			//ajax패키지 안에다 별도의 servlet을 만들어서 처리
			action = new MemoIdCheckService(); //다형성
			forward = action.execute(request, response);
		}else if(urlCommand.equals("/MemoView.memo")) {
			//만약 로직 처리가 필요 없다면?
			//UI만 필요하면?
			forward = new ActionForward();
			forward.setRedirect(false);//리다이렉트 안하겠다
			forward.setPath("/WEB-INF/views/memoview.jsp"); // 뷰만 지정
			
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
