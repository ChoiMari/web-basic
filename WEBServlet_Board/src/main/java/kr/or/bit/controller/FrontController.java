package kr.or.bit.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.bit.dto.Board;
import kr.or.bit.service.BoardService;
import kr.or.bit.utils.ThePager;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.NamingException;

// 게시판 : MVC2 패턴으로 바꾸기

@WebServlet("*.do")
public class FrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private BoardService boardSvc;
	
    public FrontController() {
        super();
        boardSvc = BoardService.getInBoardService();
    }
    
	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 데이터 받기  - URL 방식
		String requestUri = request.getRequestURI();
		String contextPath = request.getContextPath();
		String urlCommand = requestUri.substring(contextPath.length());

		System.out.println(urlCommand);

		// 3. 요청하기
		String viewPage = "";
		
		//요구분석 (UI 보여주 , 데이터 처리해줘)
		if (urlCommand.equals("/board.do")) {
			// uri 요청주소 board.do와 같으면
			// 보여줄 화면 ...(webapp부터 시작하는 경로)
			viewPage = "/board/board_write.jsp";
			// 게시판 글쓰기 페이지 보여줌

		} else if (urlCommand.equals("/boardcontent.do")) {

			String idx = request.getParameter("idx"); // 글번호 받기

			// 글 번호를 가지고 오지 않았을 경우 예외처리
			if (idx == null || idx.trim().equals("")) {
				response.sendRedirect("board_list.jsp");
				return; // 더 이상 아래 코드가 실행되지 않고 클라이언트에게 바로 코드 전달
			}

			idx = idx.trim();
			// http://192.168.0.12:8090/WebServlet_5_Board_Model1_Sample/board/board_content.jsp?idx=19&cp=1&ps=5
			// board_content.jsp?idx=19&cp=1&ps=5 //다시 목록으로 갔을때 ... cp , ps 가지고 ...
			// why: 목록으로 이동시 현재 page 유지하고 싶어요
			String cpage = request.getParameter("cp"); // current page
			String pagesize = request.getParameter("ps"); // pagesize

			// List 페이지 처음 호출 ...
			if (cpage == null || cpage.trim().equals("")) {
				// default 값 설정
				cpage = "1";
			}

			if (pagesize == null || pagesize.trim().equals("")) {
				// default 값 설정
				pagesize = "5";
			}

			// 옵션
			// 조회수 증가
			boolean isread;
			try {
				isread = boardSvc.addReadNum(idx);
				if (isread)
					System.out.println("조회증가 : " + isread);
			} catch (NamingException e) {
				e.printStackTrace();
			}

			// 데이터 조회 (1건 (row))
			try {
				Board board = boardSvc.content(Integer.parseInt(idx));
			} catch (NumberFormatException e) {
				e.printStackTrace();
			} catch (NamingException e) {
				e.printStackTrace();
			}

			request.setAttribute(urlCommand, viewPage);

			viewPage = "/board/board_content.jsp";

			// -----------------------------
		} else if (urlCommand.equals("/boardlist.do")) {
			// 게시판 보기

			// 게시물 총 건수
			int totalboardcount;
			try {
				totalboardcount = boardSvc.totalBoardCount();
				// 상세보기 >> 다시 LIST 넘어올때 >> 현재 페이지 설정
				String ps = request.getParameter("ps"); // pagesize
				String cp = request.getParameter("cp"); // current page

				// List 페이지 처음 호출 ...
				if (ps == null || ps.trim().equals("")) {
					// default 값 설정
					ps = "5"; // 5개씩
				}

				if (cp == null || cp.trim().equals("")) {
					// default 값 설정
					cp = "1"; // 1번째 페이지 보겠다
				}

				int pagesize = Integer.parseInt(ps);
				int cpage = Integer.parseInt(cp);
				int pagecount = 0;
				
				// 23건 % 5
				if (totalboardcount % pagesize == 0) {
					pagecount = totalboardcount / pagesize; // 20 << 100/5
				} else {
					pagecount = (totalboardcount / pagesize) + 1;
				}

				// 102건 : pagesize=5 >> pagecount=21페이지

				// 전체 목록 가져오기
				List<Board> list = boardSvc.list(cpage, pagesize);
				
				request.setAttribute("list", list);
				request.setAttribute("pagesize", pagesize);
				request.setAttribute("cpage", cpage);
				request.setAttribute("pagecount", pagecount);
				request.setAttribute("totalboardcount", totalboardcount);
				
				int pagersize=3; //[1][2][3]
				ThePager pager = new ThePager(totalboardcount,cpage,pagesize,pagersize,"board_list.jsp");

				String linkString = pager.toString();
				request.setAttribute("linkString", linkString);
				
			} catch (Exception e) {
				e.printStackTrace();
			}

			viewPage = "/board/board_list.jsp";

		} else if (urlCommand.equals("/memodelete.do")) {

			String id = request.getParameter("id");
			// memoDao.deleteMemo(id);

			// 목록 보기로 이동함
			// List<Memo> memoList=null;;
//					try {
//						//memoList = memoDao.getMemoList();
//						//request.setAttribute("memoList", memoList);
//			    		viewPage = "/WEB-INF/views/memo/memo_list.jsp";
//					} catch (SQLException e) {
//						e.printStackTrace();
//					}

		} else if (urlCommand.equals("/memoupdate.do")) {

			// memoupdate.do?id=후후22
			// 수정하기 화면 (기존 데이터 출력) > select
			String id = request.getParameter("id");
			// Memo memoDetail = memoDao.getMemoListById(id);

			// 확인해봄
			// System.out.println("메모디테일??" + memoDetail.toString());

			// request.setAttribute("memoupdate", memoDetail);
			viewPage = "/WEB-INF/views/memo/memo_update.jsp";

		} else if (urlCommand.equals("/memoupdateok.do")) {
			// 변경된 내용 수정 > update ....
			String id = request.getParameter("id");
			String email = request.getParameter("email");
			String content = request.getParameter("content");

			// Memo memo = new Memo(id, email, content);
			// memoDao.updateMemo(memo);

			// request.setAttribute("memodetail", memo);
			viewPage = "/WEB-INF/views/memo/memo_detail.jsp";
		}

		// 5. 뷰지정
		RequestDispatcher dis = request.getRequestDispatcher(viewPage);

		// 6. 뷰 forward
		dis.forward(request, response);

		// 7. 뷰페이지 화면 출력..

	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

}
