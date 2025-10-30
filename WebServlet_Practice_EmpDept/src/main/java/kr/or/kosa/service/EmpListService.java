package kr.or.kosa.service;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import com.google.gson.Gson;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.kosa.action.Action;
import kr.or.kosa.action.ActionForward;
import kr.or.kosa.dao.EmpDao;
import kr.or.kosa.dto.EmpDto;
import kr.or.kosa.model.Emp;

public class EmpListService implements Action{

	@Override
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) {
		ActionForward forward = null;
		try {
            // 1. 파라미터 받기 (부서번호)
            String deptnoStr = request.getParameter("deptno");
            Integer deptno = deptnoStr != null ? Integer.parseInt(deptnoStr) : null;

            // 2. DAO 호출
            EmpDao empDao = new EmpDao();
            List<Emp> empList;

            if (deptno != null) {
                // 부서별 조회
                empList = empDao.getEmpListByDeptno(deptno); // DAO에서 구현 필요
            } else {
                // 전체 조회
                empList = empDao.getEmpAllList();
            }

            // 3. Entity -> DTO 변환
            List<EmpDto> empDtoList = new ArrayList<>();
            for (Emp emp : empList) empDtoList.add(EmpDto.builder()
                    .empno(emp.getEmpno())
                    .ename(emp.getEname())
                    .sal(emp.getSal())
                    .hiredate(emp.getHiredate())
                    .deptno(emp.getDeptno())
                    .mgr(emp.getMgr())
                    .build());

            // 4. JSON으로 변환
            String json = new Gson().toJson(empDtoList);

            // 5. 응답
            response.setContentType("application/json;charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.print(json);
            out.flush();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return forward; // forward는 필요 없음, AJAX는 직접 JSON 반환
	}

}
