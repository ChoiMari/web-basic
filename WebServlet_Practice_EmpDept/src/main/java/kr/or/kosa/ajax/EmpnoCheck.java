package kr.or.kosa.ajax;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.kosa.dao.EmpDao;

import java.io.IOException;
import java.io.PrintWriter;


@WebServlet("/EmpnoCheck")
public class EmpnoCheck extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public EmpnoCheck() {
        super();
    }

	private void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 // 요청 데이터 (사원번호)
        String empnoStr = request.getParameter("empno");
        response.setContentType("application/json; charset=UTF-8"); // JSON 반환
        PrintWriter out = response.getWriter();

        if(empnoStr == null || empnoStr.isEmpty()) {
            out.print("{\"result\":false, \"message\":\"사원번호가 없습니다.\"}");
            return;
        }

        try {
            int empno = Integer.parseInt(empnoStr);
            EmpDao dao = new EmpDao();
            boolean exists = dao.checkEmpnoExists(empno); // DB 체크

            if(exists) {
                out.print("{\"result\":false, \"message\":\"이미 존재하는 사원번호입니다.\"}");
            } else {
                out.print("{\"result\":true, \"message\":\"사용 가능한 사원번호입니다.\"}");
            }

        } catch(NumberFormatException e) {
            out.print("{\"result\":false, \"message\":\"유효하지 않은 사원번호입니다.\"}");
        } catch(Exception e) {
            out.print("{\"result\":false, \"message\":\"서버 오류 발생: " + e.getMessage() + "\"}");
        } finally {
            out.flush();
            out.close();
        }
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

}
