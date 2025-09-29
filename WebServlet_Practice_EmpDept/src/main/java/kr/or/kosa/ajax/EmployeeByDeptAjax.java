package kr.or.kosa.ajax;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.kosa.dao.DeptDao;
import kr.or.kosa.dao.EmpDao;
import kr.or.kosa.model.Dept;
import kr.or.kosa.model.Emp;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.google.gson.Gson;

@WebServlet("/EmployeeByDeptAjax")
public class EmployeeByDeptAjax extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json; charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            String deptnoStr = request.getParameter("deptno");
            int deptno = Integer.parseInt(deptnoStr);

            EmpDao dao = new EmpDao();
            List<Emp> empList = dao.getEmpListByDeptno(deptno); // deptno별 사원 조회

            // 부서명 포함하려면 EmpDto 또는 Map으로 변환 필요
            List<Map<String,Object>> result = new ArrayList<>();
            for(Emp e : empList) {
                Map<String,Object> map = new HashMap<>();
                map.put("empno", e.getEmpno());
                map.put("ename", e.getEname());
                map.put("sal", e.getSal());
                map.put("hiredate", e.getHiredate().toString());
                map.put("deptno", e.getDeptno());

                // 부서명 가져오기
                DeptDao deptDao = new DeptDao();
                Dept dept = deptDao.getDeptByDeptno(e.getDeptno());
                map.put("dname", dept != null ? dept.getDname() : "");

                result.add(map);
            }

            Gson gson = new Gson();
            out.print(gson.toJson(result));
            out.flush();

        } catch(Exception ex) {
            ex.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        } finally {
            out.close();
        }
    }
}
