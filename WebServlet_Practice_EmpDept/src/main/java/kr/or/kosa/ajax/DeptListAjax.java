package kr.or.kosa.ajax;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.kosa.dao.DeptDao;
import kr.or.kosa.dao.EmpDao;
import kr.or.kosa.model.Dept;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import com.google.gson.Gson;

@WebServlet("/DeptListAjax")
public class DeptListAjax extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
    	System.out.println("호출되나?");
        response.setContentType("application/json; charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            DeptDao dao = new DeptDao();
            List<Dept> deptList = dao.getAllDept(); // 부서 전체 조회
            System.out.println(deptList);
            // Gson으로 JSON 변환
            Gson gson = new Gson();
            String json = gson.toJson(deptList);

            out.print(json);
            out.flush();

        } catch(Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        } finally {
            out.close();
        }
    }
}
