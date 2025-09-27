package kr.or.kosa.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.kosa.dto.EmpDto;
import kr.or.kosa.service.EmpService;
import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;


@WebServlet("*.do") //list.do , write.do
public class FrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	private EmpService empSvc; // 주입받으면 좋겠다...
	
    public FrontController() {
        super();
        empSvc = new EmpService();
    } 

	private void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1. 한글처리
		request.setCharacterEncoding("UTF-8");
		//2. 데이터 받기
		//3. 모든 요청을 받고 처리 하겠다
		//3.1 요청에 대한 판단
		//3.1.1 command 방식 list.do?cmd=list , write.do?cmd-insert
		
		//url 방식 (뒷 주속값을 추룰해서 비교)
		//마지막 주소 문자열 : localhost:8090/WEB/list.do
		//>>>>   /list.do   /insert.do     추출 .... 
		
		
		//데이터 받기
		//URL 방식
		String requestUri = request.getRequestURI();
		String contextPath = request.getContextPath();
		String urlCommand = requestUri.substring(contextPath.length());
		
		System.out.println(urlCommand);
		
		//3. 요청하기
		String viewPage= "";
		
		//MemoDao memoDao = new MemoDao();
		
		//요구분석 (UI 보여줘 , 데이터 처리해줘!!!!)
		if(urlCommand.equals("/emp.do")) { // 사원 등록
			// 요청주소 파싱한게 /emp.do이면 실행
			
			//화면 - webapp부터 시작하는 경로
			viewPage = "/WEB-INF/views/emp/emp_insert.jsp"; //사원 등록 페이지로 이동
		
		}else if(urlCommand.equals("/empdetail.do")) {
			//사원 정보 상세보기
			Integer empno = null; 
			//요청 파라미터에서 뽑아냄..(empno) 
			//-> 뷰에서 name을 empno로 해야함
			  String empnoParam = request.getParameter("empno");
			  
			  //변환 필요 - (파라미터는 문자열..)예외처리 필요함..
			  // 파라미터 url에서 변환 안되는 데이터로 주었을 경우를 생각..
			 // Integer로 써야 null값으로 처리 가능함...
			  try {
				  empno = Integer.parseInt(empnoParam);
			} catch (Exception e) {
				//예외 화면 보여주어야함.. //-> 요청하는 페이지를 찾을 수 없습니다.
				System.out.println("[요청파라미터 변환 예외] : url로 잘못된 값이 들어왔다..");
			}
			  //서비스 계층에서 호출
			  EmpDto dto = empSvc.readEmpByEmpno(empno);
			 
			  request.setAttribute("empdetail", dto); //요청 객체에 넣음
			  // 뷰에서 ${requestScope.empdetail.empno}라고 써야함
			  
			  //이동할 뷰 페이지 경로 - 이 이름으로 뷰 만들어야함
			  viewPage="/WEB-INF/views/emp/emp_detail.jsp";
			  
		}else if(urlCommand.equals("/emplist.do")) {
			//사원 전체 목록 보기 요청 주소
			List<EmpDto> empList;
			
			try {
				List<EmpDto> empsList = empSvc.readEmpAllList();
				
				request.setAttribute("empList", empsList);
				// 뷰에서 ${requestScope.empList[0].empno}라고 써야함
				//-> 가져오는 데이터가 여러건이므로, <c:forEach>로 1건씩 출력하기
				
				//이동할 뷰 페이지 경로 - 이 이름으로 뷰 만들어야함
				viewPage="/WEB-INF/views/emp/emp_list.jsp";
			
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(urlCommand.equals("/empinsert.do")) {
			//TODO : view에서 메서드 POST 방식으로 보내기
			// 새로운 사원 등록하고 -> 상세보기로 이동
			
			// 변환 필요함..
			String empno = request.getParameter("empno");
    		String ename = request.getParameter("ename");
    		String job = request.getParameter("job");
    		String hiredate = request.getParameter("hiredate");
    		String sal = request.getParameter("sal");
    		String deptno = request.getParameter("deptno");
    		String mgrStr = request.getParameter("mgr");
    		String commStr = request.getParameter("comm");
    		
//    		Integer mgr = null;
//    		Integer comm = null;
//    		
//    		if(mgrStr != null && mgrStr.trim().isEmpty()) {
//    			mgr = Integer.parseInt(mgrStr);
//    		}
//    		if(commStr != null && commStr.trim().isEmpty()) {
//    			comm = Integer.parseInt(commStr);
//    		}
    		
    		//TODO : 유효성 검사 & 예외처리...    	
    		EmpDto empDto = EmpDto.builder()
    				.empno(Integer.parseInt(empno))
    				.ename(ename)
    				.job(job)
    				.mgr(Integer.parseInt(mgrStr))
    				.hiredate(LocalDate.parse(hiredate)) 
    				.sal(Integer.parseInt(sal))
    				.comm(Integer.parseInt(commStr))
    				.deptno(Integer.parseInt(deptno))
    				.build();
    		
    		empSvc.createEmp(empDto);
    		
    		request.setAttribute("empdetail", empDto);
    		
    		//이동할 페이지
    		viewPage = "/WEB-INF/views/emp/emp_detail.jsp";
			
		}else if(urlCommand.equals("/empdelete.do")) {
			
			Integer empno = null; 
			//요청 파라미터에서 뽑아냄..(empno) 
			//-> 뷰에서 name을 empno로 해야함
			String empnoParam = request.getParameter("empno");
			  
			  //변환 필요 - (파라미터는 문자열..)예외처리 필요함..
			  // 파라미터 url에서 변환 안되는 데이터로 주었을 경우를 생각..
			 // Integer로 써야 null값으로 처리 가능함...
			  try {
				  empno = Integer.parseInt(empnoParam);
			} catch (Exception e) {
				//예외 화면 보여주어야함.. //-> 요청하는 페이지를 찾을 수 없습니다.
				System.out.println("[요청파라미터 변환 예외] : url로 잘못된 값이 들어왔다..");
			}
			  //서비스 계층에서 호출
			 empSvc.deleteEmpByEmpno(empno);
    		
    		//목록 보기로 이동함
			List<EmpDto> empsList = empSvc.readEmpAllList();
			request.setAttribute("empList", empsList);
	    	viewPage = "/WEB-INF/views/emp/emp_list.jsp";
    	
		}else if(urlCommand.equals("/empupdate.do")) {
			//수정하기 화면 (기존 데이터 출력) > select (상세보기)
			String empno = request.getParameter("empno");
			EmpDto empDetail = empSvc.readEmpByEmpno(Integer.parseInt(empno));
    		
    		request.setAttribute("empupdate", empDetail);
			
    		viewPage = "/WEB-INF/views/emp/emp_update.jsp";
    		
		}else if (urlCommand.equals("/empupdateok.do")) {
			// 사원정보 수정 요청 시 실행
			//TODO : POST방식으로 받아서 처리
			// 변환 필요함..
			
			//"update emp set ename = ?, job = ?, sal = ?, hiredate = ? where empno = ?";
    		String ename = request.getParameter("ename");
    		String job = request.getParameter("job");
    		String sal = request.getParameter("sal");
    		String hiredate = request.getParameter("hiredate");
    		String empno = request.getParameter("empno");
    		//TODO : 예외처리...    	
    		EmpDto empDto = EmpDto.builder()
    				.empno(Integer.parseInt(empno))
    				.job(job)
    				.ename(ename)
    				.hiredate(LocalDate.parse(hiredate)) 
    				.sal(Integer.parseInt(sal))
    				.build();
    		
    		empSvc.updateEmp(empDto);
    		EmpDto empDetail= empSvc.readEmpByEmpno(Integer.parseInt(empno));
    		
    		request.setAttribute("empdetail", empDetail);	
    		viewPage = "/WEB-INF/views/emp/emp_detail.jsp";
    	}
		
		// 5. 뷰지정
    	RequestDispatcher dis = request.getRequestDispatcher(viewPage);
    	
    	// 6. 뷰 forward
    	dis.forward(request, response);
    	
    	// 7. 뷰페이지 화면 출력..
		
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess( request,  response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess( request,  response);
	}

}
