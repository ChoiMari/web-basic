package kr.or.kosa.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.kosa.dao.MemoDao;
import kr.or.kosa.dto.Memo;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;


@WebServlet("*.do") //list.do , write.do
public class FrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public FrontController() {
        super();
    } 

	private void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1. 한그처리
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
		
		MemoDao memoDao = new MemoDao();
		
		//요구분석 (UI 보여주 , 데이터 처리해주)
		if(urlCommand.equals("/memo.do")) {
			//화면 ...
			viewPage = "/WEB-INF/views/memo/memo_insert.jsp";
		
		}else if(urlCommand.equals("/memodetail.do")) {
			
			  String id = request.getParameter("id");
			  Memo memoDetail = memoDao.getMemoListById(id);
			  request.setAttribute("memodetail", memoDetail);
			  viewPage="/WEB-INF/views/memo/memo_detail.jsp";
			  
		}else if(urlCommand.equals("/memolist.do"))
		{
			List<Memo> memoList;
			
			try {
				  memoList = memoDao.getMemoList();
				  request.setAttribute("memoList", memoList);
				  viewPage="/WEB-INF/views/memo/memo_list.jsp";
			
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(urlCommand.equals("/memoinsert.do")) {
			//코드 채우기
			//데이터 받기 , memo 객체 생성 (뷰지정하고 forward)
			//상세보기 ..
			String id = request.getParameter("id");
    		String email = request.getParameter("email");
    		String content = request.getParameter("content");
    		
    		Memo memo = new Memo(id, email, content);
    		memoDao.insertMemo(memo);
    		
    		request.setAttribute("memodetail", memo);
    		viewPage = "/WEB-INF/views/memo/memo_detail.jsp";
			
		}else if(urlCommand.equals("/memodelete.do")) {
			
			String id = request.getParameter("id");
    		memoDao.deleteMemo(id);
    		
    		//목록 보기로 이동함
    		List<Memo> memoList=null;;
			try {
				memoList = memoDao.getMemoList();
				request.setAttribute("memoList", memoList);
	    		viewPage = "/WEB-INF/views/memo/memo_list.jsp";
			} catch (SQLException e) {
				e.printStackTrace();
			}
    	
		}else if(urlCommand.equals("/memoupdate.do")) {

			// memoupdate.do?id=후후22
			//수정하기 화면 (기존 데이터 출력) > select 
			String id = request.getParameter("id");
    		Memo memoDetail = memoDao.getMemoListById(id);
    		
    		//확인해봄
    		System.out.println("메모디테일??" + memoDetail.toString());
    		
    		request.setAttribute("memoupdate", memoDetail);
    		viewPage = "/WEB-INF/views/memo/memo_update.jsp";
    		
		}else if (urlCommand.equals("/memoupdateok.do")) {
    		// 변경된 내용 수정 > update ....
    		String id = request.getParameter("id");
    		String email = request.getParameter("email");
    		String content = request.getParameter("content");
    		
    		Memo memo = new Memo(id, email, content);
    		memoDao.updateMemo(memo);
    	
    		request.setAttribute("memodetail", memo);	
    		viewPage = "/WEB-INF/views/memo/memo_detail.jsp";
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
