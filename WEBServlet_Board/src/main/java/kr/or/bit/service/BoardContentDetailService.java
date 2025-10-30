package kr.or.bit.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.bit.action.Action;
import kr.or.bit.action.ActionForward;
import kr.or.bit.dao.BoardDao;
import kr.or.bit.dto.Board;
import kr.or.bit.dto.Reply;
/**
 * 글 상세보기 서비스
 */
public class BoardContentDetailService implements Action{

	@Override
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) {
		ActionForward forward = null;
		try {
			String idx= request.getParameter("idx"); //글번호 받기
			//글 번호를 가지고 오지  않았을 경우 예외처리
			if(idx == null || idx.trim().equals("")){
				response.sendRedirect("board_list.jsp");
				return forward; //더 이상 아래 코드가 실행되지 않고 클라이언트에게 바로 코드 전달
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
			boolean isread = new BoardDao().getReadNum(idx);
			
			if(isread)System.out.println("조회증가 : " + isread);
			
			//데이터 조회 (1건 (row))
			Board board = new BoardDao().getContent(Integer.parseInt(idx));
			String content = board.getContent();
			if(content != null){
				content = content.replace("\n", "<br>");
			}
			
			//덧글 목록 보여주기
			List<Reply> replylist =	new BoardDao().replylist(idx);
			
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
			
			forward = new ActionForward();
			forward.setRedirect(false);
			forward.setPath("/WEB-INF/views/board/board_content.jsp");
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return forward;
	}

}
