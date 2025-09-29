package kr.or.kosa.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.kosa.action.Action;
import kr.or.kosa.action.ActionForward;
import kr.or.kosa.service.EmpCreateService;
import kr.or.kosa.service.EmpListService;

import java.io.IOException;

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
				if(urlCommand.equals("/index.do")) { //메인화면
					//UI만 필요해서 뷰만 지정함
					forward = new ActionForward();
					forward.setRedirect(false); // 리다이렉트 안하겠다
					forward.setPath("/index.jsp");	
				}else if(urlCommand.equals("/employeeInput.do")) {
					forward = new ActionForward();
					forward.setRedirect(false);
					forward.setPath("WEB-INF/views/empcreate.jsp");
					
				}else if(urlCommand.equals("/empcreate.do")) {
					action = new EmpCreateService();
					forward = action.excute(request, response); //다형성
				}else if(urlCommand.equals("/emplist.do")) {
					action = new EmpListService();
					forward = action.excute(request, response); //다형성
				}else if(urlCommand.equals("/departmentEmployeeList.do")) {
					forward = new ActionForward();
					forward.setRedirect(false); // 리다이렉트 안하겠다
					forward.setPath("WEB-INF/views/EmpDeptList.jsp");	
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
