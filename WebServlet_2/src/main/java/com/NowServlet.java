package com;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;

import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebInitParam;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet(
		description = "서블릿 테스트 중입니다 홍길동", 
		urlPatterns = { //여러가지 요청을 가질 수 있다
				"/NowServlet", 
				"/Now.do", 
				"/Now.action", 
				"/Now.kglim"
		}, 
		initParams = { 
				@WebInitParam(name = "id", value = "kosa", description = "id 초기값 활용하기"), 
				@WebInitParam(name = "jdbcDriver", value = "oracle.jdbc.OracleDriver", description = "오라클 드라이버 클래스 제공")
		})
public class NowServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public NowServlet() {
        super();
        System.out.println("생성자 > 객체 생성시 한번 호출");
        
    }

	
	public void init(ServletConfig config) throws ServletException {
		
		//초기화 시키는 역할을 하는 메서드 (자동 호출되는 메서드)
		//호출 시점 : NowServlet 클래스에 대한 [최초 요청시 한번 실행]
		//재실행 : 서버의 재시작 , 개발자의 코드 수정
		
		//it.co.kr 서버 오픈 > WAS (서블릿 : NowServlet.java 파일 있음)
		//홍길동 첫 접속자(서버의 **최소**요청) -> it.co.kr/Now.do 서버 요청 
		//NowServlet 컴파일 >> class >> 실행 -> **생성자 호출 
		//-> init 자동호출** -> doGET or doPOST -> 자동호출
		
		//김유신 두번째 접속자  -> it.co.kr/Now.do 서버 요청 
		// class >> 실행 -> doGET or doPOST -> 자동호출
		
		//유관순 두번째 접속자  -> it.co.kr/Now.do 서버 요청 
		// class >> 실행 -> doGET or doPOST -> 자동호출
		
		//DB연결 초기화 
		String drivername = config.getInitParameter("jdbcDriver");
		System.out.println("최초 요청시 한번 실행 : " + drivername);
	}

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("doGET");
		//servlet -> UI -> JSP(개발) UI작업
		//JSP 없던 시절의 코드 ....
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.print("<html>");
			out.print("<head><title>Hello</title></head>");
				out.print("<body>");
					out.print("현재 날짜 : " + new Date() + "<br>");
				out.print("</body>");
		out.print("</html>");
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("doPOST");
	}

}
