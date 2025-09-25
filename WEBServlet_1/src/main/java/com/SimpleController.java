package com;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Date;

/*
1. servlet 정의 : java 파일인데 
	웹에 사용할 수 있는 자바 파일 (request, response 객체활용)
	서블릿은 자바로 만든 웹용 파일(요청,응답 객체 쓸 수 있음)
	서블릿? 웹 용 자바 파일
1.1 java 파일에 extends HttpServlet 상속관계 (일반자바 웹 객체(request, response) 사용가능)
1.2 웹용 사용할수 있는 java 파일 : servlet 

Tip) 자바는 원래 웹 개발언어가 아니여서... 웹 ..... java .... request, response ... 상속 ... servlet 웹서비스
     servlet 자바코드 편하고 UI 만드는 작업 힘들어요 >> 그래서 탄생 >> jsp 
     
     servlet이 형이다 -> jsp는 동생 (UI 구성 편하고 + JAVA 코드 제어 힘들어 졌어요)
      

    HttpServletRequest request,   자동으로 request 생성되고 그 주소를 할당   //HttpServletRequest 인터페이스
    HttpServletResponse response  자동으로 response  생성되고 그 주소를 할당


	 1. 요청
	 JSP
	 http://192.168.4.150:8090/default.jsp (x) 이제 안 씀
	 
	 servlet
	 http://192.168.4.150:8090/SimpleController.java (x) 이 요청도 아님
	 
	 web.xml 
	 또는
	 @WebServlet 
	 어떤 요청 주소가 들어어면 SimpleController.java 컴파일하고 실행 ... 정의
	 http://192.168.4.150:8090/Simple
	 
	 web.xml 
	 어떤 요청이 오면 어떤 servlet 파일 컴파일 하고 실행 결정 ....url_pattern 정의
	 <servlet>
		<servlet-name>simplecontroller</servlet-name>
		<servlet-class>com.SimpleContoller</servlet-class>
  </servlet>
  <servlet-mapping>
		<servlet-name>simplecontroller</servlet-name>
		<url-pattern>/simple</url-pattern>
  </servlet-mapping>
  
  컴파일 하고 실행할 거야 ...
  
  주소 창에 : http://localhost:8090/simple 엔터
  web.xml 설정된 servlet-mapping  근거로 SimpleContoller.java 컴파일 하고 실행
  
  protected void doGet() 함수 아니면
  protected void doPost() 둘중에 하나가 자동 실행
  
  동기식 .... 둘중에 하나의 방식으로 요청 보내요 
  GET   >>  void doGet() 실행 (자동)
  POST  >>  void doPost() 실행(자동)
*/
@WebServlet("/SimpleController") // 클라이언트가 서버에 요청하는 주소값
public class SimpleController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public SimpleController() {
    	//SimpleController의 생성자
        super();
        System.out.println("SimpleController 생성자 함수 실행 : 초기화");
     
    }

    	//요청방식에 따라서 자동호출됨

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("클라이언트의 요청이 GET이면 자동실행 함수");
		//할일 : 
		/*
		 1.한글 처리
		 2.데이터 받기
		 3.비지니스 로직(요구사항)
		 4.데이터 담기
		 5.view 지정
		 6.view forward
		 */
		
		//1. 한글처리
		request.setCharacterEncoding("UTF-8");
		//2.데이터 받기
		String type = request.getParameter("type");
		//3.비지니스로직(요구사항)
		Object resultObj = null;
		if(type == null || type.equals("greeting")) {
			resultObj = "hello world";
		}else if(type.equals("date")) {
			resultObj = new Date();
		}else {
			resultObj = "invalid String type";
		}
		
		//4.데이터 담기(요청객체 또는 세션객체 또는 어플리케이션 객체 중 선택)
		request.setAttribute("result", resultObj);
		// requeset XX번지에 저장
		
		//5. view 정의
		//WEB-INF -> views -> board -> css, image, simpleview.jsp
		//				   -> admin -> css, js, image, jsp ...
		RequestDispatcher dis = request.getRequestDispatcher("/simpleview.jsp");//webapp가 루트
		//view 지정하는 코드
		//getRequestDispatcher() : 요청을 다른 리소스(서블릿, JSP 등)로 전달(forward)하거나 포함(include)하는 데 사용
		
		dis.forward(request, response);//현재 버퍼의 내용 비우고 /simpleview.jsp 경로의 내용으로 채우겠다는 의미
		//요청 주소는 바뀌지 않음
		//포워드 ? 현재 SimpleController가 가지는 buffer를 비우고
		// /simpleview.jsp경로의 파일의 내용으로 버퍼를 채워서 서비스 하겠다
		//-> 주소 변경없이 내용이 바뀜
		// 요청주소는 /simple 그대로 내용이 이제 
		// dis.forward(request, response);코드를 만나는 순간 /simpleview.jsp 경로의 파일로 서비스
		// request객체 공유 가능(포워드는 가능) 전달되는게 서버 메모리의 requeset XX번지에 저장된 값
		// 포워드 : 제어권을 넘겨줌
		//버퍼는 SimpleController로 쓰니까 요청주소는 안바뀌는데 
		// 버퍼는 SimpleController는 비우고 포워드시킨 페이지 내용으로만 써지고, 제어권까지 넘겨준다
		//jsp에 데이터를 넘겨주어야하는데 그럼 요청객체에 담아서 포워드 방식밖엔 없다..
		// 세션으로 보내기에는.. 다른곳에서도 사용이 가능하니까..
		// 해당 jsp에 보내려고 포워드를 사용
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	}

}
