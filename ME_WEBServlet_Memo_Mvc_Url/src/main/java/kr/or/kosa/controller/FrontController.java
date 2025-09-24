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

//원칙 - 프론트컨트롤러 하나 만들고
//프론트 컨트롤러가 잡음 뭐할거니? ->요청의 흐름제어만 함
//다른 처리는 서비스 계층에서 처리함
//실제 개발에서는 프론트컨트롤러가 의존하는 계층
//-> DAO에 의존 MemberDao
@WebServlet("*.do") // list.do, write.do //모든것.do 요청 다 받음
public class FrontController extends HttpServlet {
	
	//FrontController 역할 : 요청 주소에 따라서 UI를 다르게 보내줌
	//url 방식 예제
	
	private static final long serialVersionUID = 1L;
       

    public FrontController() {
        super();
    }

	private void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1. 한글처리
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
			  request.setAttribute("memoDetail", memoDetail);
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
		}else if(urlCommand.equals("memoInsert.do")) {
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
			
		}else if(urlCommand.equals("memodelete.do")) {
			
			String id = request.getParameter("id");
    		memoDao.deleteMemo(id);
    		
    		List<Memo> memoList=null;;
			try {
				memoList = memoDao.getMemoList();
				request.setAttribute("memoList", memoList);
	    		viewPage = "/WEB-INF/views/memo/memo_list.jsp";
			} catch (SQLException e) {
				e.printStackTrace();
			}
    	
		}else if(urlCommand.equals("memoupdate.do")) {
			//수정하기 화면 (기존 데이터 출력) > select 
			String id = request.getParameter("id");
    		Memo memoDetail = memoDao.getMemoListById(id);
 
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
		
		//뷰지정
		RequestDispatcher dis = request.getRequestDispatcher(viewPage);
		//포워드
		dis.forward(request, response);
		//뷰페이지 화면 출력
	}
    
    
    
    
   
    
//	private void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		/*
//		 1.한글처리
//		 2. 데이터 받기
//		 -> 모든 요청을 받고 처리 하겠다
//		 	2.1 요청에 대한 판단은 무엇으로 ????
//		 	-> 2.1.1. command 방식 : 예시) list.do?cmd=list, write.do?cmd=insert
//		 	-> 2.1.2. url방식(이게 훨씬 편함) : 뒤의 주소값을 뽑아서 비교하는 방식
//		 */
//		
//		//데이터 받기
//		// 클라이언트의 요청을 판단하는 방식 - 사용자가 글 목록해달라는건지, 글쓰기를 해달라는건지? - 요청 주소로 판단할 수 있다
//		//url방식  - 마지막 주소의 문자열을 추출함
//		
//		// 예시)
//		// localhost:8090/WEB/list.do 여기에서
//		// list.do만 추출(파싱) 이걸로 요청 주소에 따라 각각의 로직을 수행하도록 함
//		// 흐름 제어
//		
//		
//		String requestUri = request.getRequestURI();
//		//-> 요청 주소에 의미가 있다
//		
//		String contextPath = request.getContextPath(); // 이름을 분리
//		String urlCommand = requestUri.substring(contextPath.length());
//		//이것만 얻으면 작업 분리가 가능하다.
//		
//		// 입력 방식이 타당한지 물어봄 커멘드인지 url인지?????
//	
//		System.out.println(urlCommand);
//		
//		//3. 요청하기
//		String viewPage = ""; // 빈문자열로 초기화
//		//url커멘드가 옴 
//		//url커멘드??????
//		
//		//DB작업
//		MemoDao memoDao = new MemoDao();
//		
//		//요구 분석(클라이언트가 요구하는 것) 
//		//-> UI 보여줘 또는 데이터 처리해줘
//		// 클라이언트가 봐서는 안되는 파일은 WEB-INF안에 넣음
//		if(urlCommand.equals("/memo.do")) { // @WebServlet("*.do")
//			// 요청 주소가/memo.do라면 실행함
//			//viewPage = "/WEB-INF/views/memo/memo_insert.do";
//			//memo_insert.do //-> do?이게 뭐지???
//			
//			//화면 보여줘
//			viewPage = "/WEB-INF/views/memo/memo_insert.jsp";
//			// 뷰만 지정함
//			
//		}else if(urlCommand.equals("/memoDetail.do")) { // 상세보기
//			//마지막 주소를 잘라서 요청주소가 이거라면
//			// 이런 뷰를 보여주겠다.
//			
//			//상세보기라서 글 번호가 필요함
//			String id = request.getParameter("id"); // 파라미터값 가져옴
//			Memo memoDetail = memoDao.getMemoListById(id);
//			//1건의 데이터를 받음 - 그래서 Memo객체
//			//여러개면 List<Memo>로 받았을 것..
//			
//			 request.setAttribute("memoDetail", memoDetail);
//			 viewPage = "/WEB-INF/views/memo/memo_detail.jsp";
//			
//		}else if(urlCommand.equals("/memolist.do")) { //목록보기
//			//데이터 조회
//			List<Memo> memoList;
//			try {
//				memoList = memoDao.getMemoList();
//				request.setAttribute("memoList", memoList);
//				
//				//뷰지정
//				viewPage = "/WEB-INF/views/memo/memo_list.jsp";
//			} catch (Exception e) {
//				e.printStackTrace(); 
//			}
//		}else if(urlCommand.equals("/memoInsert.do")) {
//			//이건 처리단
//			// 1. 한글처리
//			request.setCharacterEncoding("UTF-8");
//			//2. 데이터 받기 - 상세보기로 빠진 형태
//			String id = request.getParameter("id");
//			String email = request.getParameter("email");
//			String content = request.getParameter("content");
//			
//			Memo memo = new Memo(id, email, content);
//			memoDao.insertMemo(memo);
//			request.setAttribute("memodetail", memo);
//			
//			//3. 메모객체 생성
//			//4. 뷰 지정 -> 포워드 시킴
//			viewPage = "/WEB-INF/views/memo/memo_detail.jsp";
//			
//		}else if(urlCommand.equals("/memoDetail.do")) {
//			viewPage = "/WEB-INF/views/memo/memo_detail.jsp";
//			
//		}else if(urlCommand.equals("/memoupdate.do")) {
//			//수정하기 화면(기존 데이터 출력)
//			
//		}else if(urlCommand.equals("/memoupdateok.do")) {
//	
//			//수정하기 완료 화면
//			
//		}
//		
//		else if(urlCommand.equals("/memodelete.do")) { // 삭제
//			String id = request.getParameter("id"); //글번호 받아서
//			memoDao.deleteMemo(id);
//			List<Memo> memoList = null;
//			try {
//				memoList = memoDao.getMemoList();
//				//목록보기로 이동시켜야함
//			} catch (Exception e) {
//				// TODO: handle exception
//			}
//		}
//		
//		
//	} 
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

}
