package kr.or.kosa.service;

import java.time.LocalDate;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.kosa.action.Action;
import kr.or.kosa.action.ActionForward;
import kr.or.kosa.dao.EmpDao;
import kr.or.kosa.dto.EmpDto;
import kr.or.kosa.model.Emp;

public class EmpCreateService implements Action{

	@Override
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) {
		ActionForward forward = null;
		
		try {
			String empno = request.getParameter("empno");
			String ename = request.getParameter("ename");
			String sal = request.getParameter("sal");
			String hiredate = request.getParameter("hiredate");
			String deptno = request.getParameter("deptno");
			String mgrStr = request.getParameter("mgr");
			
    		Emp emp = EmpDto.builder()
    				.empno(Integer.parseInt(empno))
    				.ename(ename)
    				.mgr(Integer.parseInt(mgrStr))
    				.hiredate(LocalDate.parse(hiredate)) 
    				.sal(Integer.parseInt(sal))
    				.deptno(Integer.parseInt(deptno))
    				.build().toEntity();
    		
    		EmpDao dao = new EmpDao();
    		dao.insertEmp(emp);
    		
    		// 상세 조회: 방금 넣은 empno로 DB에서 다시 조회
    		Emp empDetail = dao.getEmpByEmpno(Integer.parseInt(empno));
    		request.setAttribute("empDetail", empDetail);
    		
			forward = new ActionForward();
			forward.setRedirect(false);
			forward.setPath("WEB-INF/views/empdetail.jsp");
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return forward;
	}

}
