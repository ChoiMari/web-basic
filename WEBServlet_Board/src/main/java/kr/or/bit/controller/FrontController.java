package kr.or.bit.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.bit.dto.Board;
import kr.or.bit.dto.Reply;
import kr.or.bit.service.BoardService;
import kr.or.bit.utils.ThePager;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.naming.NamingException;


@WebServlet("*.do")
public class FrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private BoardService boardSvc;
	
    public FrontController() {
        super();
    }

	public void init(ServletConfig config) throws ServletException {
		boardSvc = BoardService.getInBoardService();
	}

	private void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//한글처리 -> 필터에서 함
		//데이터 받기 -> URL방식 사용
		String requestUri = request.getRequestURI();
		String contextPath = request.getContextPath();
		String urlCommand = requestUri.substring(contextPath.length());
		
		System.out.println(urlCommand); //-> 디버깅용

		String viewPage= ""; //-> 보여줄 뷰 페이지 설정
		
		//요청주소에 따른 화면 제어
		if(urlCommand.equals("/board_write.do")) {
			//게시판 글쓰기 페이지
			//webapp이하 경로부터 작성하면 됨
			viewPage = "/WEB-INF/views/board/board_write.jsp";
			
		}else if(urlCommand.equals("/board_writeok.do")) {
			//게시판 글쓰기 처리
			String subject = request.getParameter("subject");
			String writer = request.getParameter("writer");
			String email = request.getParameter("email");
			String homepage = request.getParameter("homepage");
			String content = request.getParameter("content");
			String pwd = request.getParameter("pwd");
			String filename = request.getParameter("filename");
			
			try {
				Board board = Board.builder().subject(subject).writer(writer).email(email).homepage(homepage)
						.content(content).pwd(pwd).filename(filename).build();

				int result = boardSvc.writeOk(board);

				// write.jsp 화면 >> writeok.jsp 처리 >> service >> dao > DB 작업 >
				// return dao > return service > writeok.jsp 결과처리 >> 이동 (공통) >> redirect.jsp

				String msg = "";
				String url = "";
				if (result > 0) {
					msg = "insert success";
					url = "board_list.do";
				} else {
					msg = "insert fail";
					url = "board_write.do";
				}

				request.setAttribute("board_msg", msg);
				request.setAttribute("board_url", url);
			} catch (Exception e) {
				e.printStackTrace();
			}
			viewPage = "/WEB-INF/views/board/board_writeok.jsp"; //뷰 지정
		}else if(urlCommand.equals("/board_list.do")) {
			//전체목록보기 페이지
			
			//게시물 총 건수
			int totalboardcount;
			try {
				totalboardcount = boardSvc.totalBoardCount();
				//상세보기 >> 다시  LIST 넘어올때  >> 현재 페이지 설정
				String ps = request.getParameter("ps"); //pagesize
				String cp = request.getParameter("cp"); //current page
				
				//List 페이지 처음 호출 ...
				if(ps == null || ps.trim().equals("")){
					//default 값 설정
					ps = "5"; //5개씩 
				}
			
				if(cp == null || cp.trim().equals("")){
					//default 값 설정
					cp = "1"; // 1번째 페이지 보겠다 
				}
				
				int pagesize = Integer.parseInt(ps);
				int cpage = Integer.parseInt(cp);
				int pagecount=0;
				
				//23건  % 5
				if(totalboardcount % pagesize == 0){
					pagecount = totalboardcount / pagesize; //  20 << 100/5
				}else{
					pagecount = (totalboardcount / pagesize) + 1; 
				}
				
				//102건 : pagesize=5 >> pagecount=21페이지
				
				//전체 목록 가져오기
				List<Board> list = boardSvc.list(cpage, pagesize);//list >> 1 , 20
				
				//데이터 응답객체에 저장
				//저장할 데이터가 많을땐 어떻게 하는가..(뭐가 잘했다고 평가받는지?)
				//DTO를 만들까? Map? 하나하나 setAttribute("key",value)로 보내는가??
				//-> 여쭈어보자
				request.setAttribute("list", list);
				request.setAttribute("totalboardcount", totalboardcount);
				request.setAttribute("pagesize", pagesize);
				request.setAttribute("cpage", cpage);
				request.setAttribute("pagecount", pagecount);
				
				int pagersize=3; //[1][2][3]
				ThePager pager = new ThePager(totalboardcount,cpage,pagesize,pagersize,"board_list.do");
				String linkString = pager.toString();
				request.setAttribute("linkString", linkString);
			} catch (Exception e) {
				e.printStackTrace();
			} 
			viewPage = "/WEB-INF/views/board/board_list.jsp";//보여줄 뷰 지정
		}else if(urlCommand.equals("/board_content.do")) {
			//글 상세보기
			try {
				String idx= request.getParameter("idx"); //글번호 받기
				
				//글 번호를 가지고 오지  않았을 경우 예외처리
				if(idx == null || idx.trim().equals("")){
					response.sendRedirect("board_list.jsp");
					return; //더 이상 아래 코드가 실행되지 않고 클라이언트에게 바로 코드 전달
				}
				
				idx=idx.trim();
				//http://192.168.0.12:8090/WebServlet_5_Board_Model1_Sample/board/board_content.jsp?idx=19&cp=1&ps=5
				//board_content.jsp?idx=19&cp=1&ps=5  //다시 목록으로 갔을때  ... cp , ps 가지고 ...
				//why: 목록으로 이동시 현재 page 유지하고 싶어요
				String cpage = request.getParameter("cp"); //current page
				String pagesize = request.getParameter("ps"); //pagesize
				
				//List 페이지 처음 호출 ...
				if(cpage == null || cpage.trim().equals("")){
					//default 값 설정
					cpage = "1"; 
				}
			
				if(pagesize == null || pagesize.trim().equals("")){
					//default 값 설정
					pagesize = "5"; 
				}
				
				//상세보기 내용
				
				//옵션
				//조회수 증가
				boolean isread = boardSvc.addReadNum(idx);
				if(isread)System.out.println("조회증가 : " + isread);
				
				//데이터 조회 (1건 (row))
				Board board = boardSvc.content(Integer.parseInt(idx));
				String content = board.getContent();
				if(content != null){
					content = content.replace("\n", "<br>");
				}
				
				//덧글 목록 보여주기
  				List<Reply> replylist = boardSvc.replyList(idx); //참조하는 글번호
				
				//필요 데이터 해시맵에 저장해서 한꺼번에 요청객체에 저장
				Map<String, Object> contentMap = new HashMap<String, Object>();
				contentMap.put("idx", idx);
				contentMap.put("cpage", cpage);
				contentMap.put("pagesize", pagesize);
				contentMap.put("isread", isread);
				contentMap.put("board", board);
				contentMap.put("content", content);
				contentMap.put("replylist", replylist);
				
				request.setAttribute("content", contentMap);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			viewPage = "/WEB-INF/views/board/board_content.jsp";//보여줄 뷰 지정
		}else if(urlCommand.equals("/board_edit.do")) {
			// 게시글수정

			try {
				String idx = request.getParameter("idx");
				if(idx == null || idx.trim().equals("")){
					response.sendRedirect("board_list.jsp"); //cpage=1 , ps=5
					return;
				}
				Board board = boardSvc.board_EditContent(idx);
				
				request.setAttribute("idx", idx);
				request.setAttribute("board", board);
			} catch (NamingException e) {
				e.printStackTrace();
			}
			viewPage = "/WEB-INF/views/board/board_edit.jsp";//보여줄 뷰 지정
		}else if(urlCommand.equals("/board_editok.do")) {
			// 게시글 수정 처리
			  //1. board_edit.jsp > 입력값 받기 > board dto 객체에 담기
			  
			  //방법 1) request.getParameter("subject") > new Board > setter > request > return Board
			  //가장 일반적인 방법 		  
					  
			  //방법 2) usebean 액션태그 (property )통해서 setter  주입
			  

			  //방법 3) request 객체를 통으로 넘기는 방법 (이 방법) >> 실습코드 ...
			try {
				String idx = request.getParameter("idx");
				  int result = boardSvc.board_Edit(request);
				  
					String msg="";
					String url="";
					
					if(result > 0){
						msg="edit success";
						url="board_list.do";
					}else{
						msg="edit fail";
						url="board_edit.do?idx="+idx;
					}
					
					request.setAttribute("board_msg",msg);
					request.setAttribute("board_url",url);
			} catch (Exception e) {
				e.printStackTrace();
			}
			viewPage = "/WEB-INF/views/board/board_editok.jsp";//보여줄 뷰 지정
		}else if(urlCommand.equals("/board_delete.do")) {
			// 게시글 삭제
			String idx = request.getParameter("idx");
			request.setAttribute("idx", idx);
			viewPage = "/WEB-INF/views/board/board_delete.jsp";//보여줄 뷰 지정
		}else if(urlCommand.equals("/board_deleteok.do")) {
			// 게시글 삭제 처리
			try {
				String idx = request.getParameter("idx");
				String pwd = request.getParameter("pwd");
				
				BoardService service = BoardService.getInBoardService();
				int result = boardSvc.board_Delete(idx, pwd);
				
				String msg="";
				String url="";
				if(result > 0){
					msg="delete success";
					url="board_list.do";
				}else{
					msg="delete fail";
					url="board_list.do";
				}
				
				request.setAttribute("board_msg",msg);
				request.setAttribute("board_url",url);
			} catch (Exception e) {
				e.printStackTrace();
			}
			viewPage = "/WEB-INF/views/board/board_deleteok.jsp";//보여줄 뷰 지정
		}else if(urlCommand.equals("/board_rewrite.do")) {
			// 답글
			String idx = request.getParameter("idx");
			String cpage = request.getParameter("cp");
			String pagesize = request.getParameter("ps");
			String subject = request.getParameter("subject"); // 답글의 제목으로 사용
			
			if(idx == null || subject == null || idx.trim().equals("") || subject.trim().equals("")){
				response.sendRedirect("board_list.do");
				return;
			}
			if(cpage == null || pagesize == null){
				cpage ="1";
				pagesize = "5";
			}
			
			request.setAttribute("idx", idx);
			request.setAttribute("cpage", cpage);
			request.setAttribute("pagesize", pagesize);
			request.setAttribute("subject", subject);
			
			viewPage = "/WEB-INF/views/board/board_rewrite.jsp";//보여줄 뷰 지정
			
		}else if(urlCommand.equals("/WEB-INF/views/board/redirect.do")) {
			//리다이렉트 요청 처리
			String msg = (String)request.getAttribute("board_msg");
			String url = (String)request.getAttribute("board_url");
			  
			request.setAttribute("msg", msg);
			request.setAttribute("url", url);
			viewPage = "/WEB-INF/views/board/redirect.jsp";//보여줄 뷰 지정
			
		}else if(urlCommand.equals("/board_rewriteok.do")) {
			String subject = request.getParameter("subject");
			String writer = request.getParameter("writer");
			String email = request.getParameter("email");
			String homepage = request.getParameter("homepage");
			String content = request.getParameter("content");
			String pwd = request.getParameter("pwd");
			String filename = request.getParameter("filename");
			Board board = Board.builder().subject(subject).writer(writer).email(email).homepage(homepage)
					.content(content).pwd(pwd).filename(filename).build();
			
			try {
				int result = boardSvc.rewriteok(board);
				
				//list 이동시 현재 pagesize , cpage
				String cpage = request.getParameter("cp"); //current page
				String pagesize = request.getParameter("ps"); //pagesize
				//코드는 필요에 따라서  url ="board_list.jsp?cp=<%=cpage";
				String msg="";
			    String url="";
			    if(result > 0){
			    	msg ="rewrite insert success";
			    	url ="board_list.do";
			    }else{
			    	msg="rewrite insert fail";
			    	url="board_content.do?idx="+board.getIdx();
			    }
			    
			    request.setAttribute("board_msg",msg);
			    request.setAttribute("board_url", url);
			} catch (Exception e) {
				e.printStackTrace();
			}
			viewPage = "/WEB-INF/views/board/board_rewriteok.jsp";
		}else if(urlCommand.equals("/board_replyok.do")) {
			
			//데이터 받기
			String writer = request.getParameter("reply_writer");
			String content = request.getParameter("reply_content");
			String pwd = request.getParameter("reply_pwd");
			String idx_fk = request.getParameter("idx");
			String userid = "empty";
			try {
				int result = boardSvc.replyWrite(Integer.parseInt(idx_fk), writer, userid, content, pwd);
				
				//처리하는 코드
			 	String msg="";
			    String url="";
			    
			    if(result > 0){
			    	msg ="댓글 입력 성공";
			    	url ="board_content.do?idx="+idx_fk;
			    }else{
			    	msg="댓글 입력 실패";
			    	url="board_content.do?idx="+idx_fk;
			    }
			    
			    request.setAttribute("board_msg",msg);
			    request.setAttribute("board_url", url);
			} catch (Exception e) {
				e.printStackTrace();
			}
			viewPage = "/WEB-INF/views/board/board_replyok.jsp";
		}else if(urlCommand.equals("/boardreply_deleteOk.do")) {
			try {
				String idx_fk = request.getParameter("idx");//댓글의 원본 게시글 번호
				String no = request.getParameter("no");//댓글의 순번(PK)
				String pwd = request.getParameter("delPwd");//댓글의 암호
				//System.out.println(idx_fk + "/" + no + "/" + pwd + "/");
				
				int result = boardSvc.replyDelete(no, pwd);
				
				//처리하는 코드
				 	String msg="";
				    String url="";
				    
				    if(result > 0){
				    	msg ="댓글 삭제 성공";
				    	url ="board_content.do?idx="+idx_fk;
				    }else{
				    	msg="댓글 삭제 실패";
				    	url="board_content.do?idx="+idx_fk;
				    }
				    request.setAttribute("idx_fk",idx_fk);
				    request.setAttribute("no",no);
				    request.setAttribute("pwd",pwd);
				    request.setAttribute("board_url", url);
				    
				    viewPage = "/WEB-INF/views/board/boardreply_deleteOk.jsp";
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		}
		
		//뷰지정
		RequestDispatcher dis = request.getRequestDispatcher(viewPage);
		//포워드
		dis.forward(request, response);
		//뷰페이지 화면 출력
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

}
