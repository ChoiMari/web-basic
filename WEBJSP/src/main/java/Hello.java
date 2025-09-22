

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Servlet implementation class Hello
 */
@WebServlet("/Hello")
public class Hello extends HttpServlet { //HttpServlet 이게 뭘까?
	//서블릿은 웹에서 사용할 수 있는 자바파일(웹 용 자바 파일)
	//웹의 핵심은 
	//클라이언트가 요청(리퀘스트)을 보냄 서버로..
	//서버는 클라이언트의 정보를 가지고 올 수 있어야함
	// 리퀘스트 객체가 만들어짐 클라이언트 정보 읽을 수 있음
	// 서버는 클라이언트에 응답(리스판스) 보내야함
	// 응답객체 필요
	//일반 자바파일은 요청,응답객체가 없음
	// extends HttpServlet 함으로써 요청과 응답이 가능
	
	//처음 자바는 CS프로그램이 목적 ex)그림판, 계산기 같은거
	//스윙같은 응용프로그램.. 시대가 변함에 따라서 -> 웹기술이 필요함
	// 그래서 부랴부랴 요청,응답이 가능한 HttpServlet 자바파일을 만들면서 상속하게 한것
	// 단점.. UI를 화면에 렌더링하는 코드 작성법이.. 어렵다
	// 근본은 백엔드여서
	//-> JSP 탄생
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Hello() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
