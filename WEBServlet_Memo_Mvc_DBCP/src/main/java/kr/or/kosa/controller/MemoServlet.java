package kr.or.kosa.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.kosa.dao.MemoDao;
import kr.or.kosa.dto.Memo;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/MemoServlet")
public class MemoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public MemoServlet() {
        super();

    }
    
	private void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		/*
		 1.한글처리
		 2.데이터 받기
		 3.비지니스 로직(요구사항 판단) - 프론트 컨트롤러 만들었을 때 필요
		      -> 글쓰기인지, 목록 보기인지... 지금은 서블릿 자체가 글쓰기로 구현하고 있어서 판단이 필요없다...
		 4.DB연결
		 5.DAO객체 생성
		 6.DAO메서드 실행 -> 결과 처리 
		 */
		System.out.println("MemoServlet 실행되었나?? ");
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8"); //마인타임?
		//클라이언트에게 던지는 파일형식
		PrintWriter out = response.getWriter();
		//클라이언트에 받은 값을 씀
		String id = request.getParameter("id");
		String email = request.getParameter("email");
		String content = request.getParameter("memo"); // name속성을 memo로 설정해두었음
		
		try {
			MemoDao memoDao = new MemoDao();
			int row = memoDao.insertMemo(new Memo(id,email,content));
			
			if(row > 0) { //성공
				out.print("<script>");
					out.print("alert('등록 성공');");
					//목록보기로 이동함
					out.print("location.href='MemoList';"); // 리다이렉트와 같음
				out.print("</script>");
			}
		}catch(Exception e) {
			//insert시 문제 생기면 여기로 
			//(null 또는 제약조건 문제)
			out.print("<script>");
				out.print("alert('등록 실패');");
				//목록보기로 이동함
				out.print("location.href='memo.html;'"); // 리다이렉트와 같음
			out.print("</script>");
			
			System.out.println("[예외 발생]");
			e.getMessage();
		}
	}


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

}
