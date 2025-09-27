package kr.or.bit.service;

import java.util.List;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.bit.action.Action;
import kr.or.bit.action.ActionForward;
import kr.or.bit.dao.BoardDao;
import kr.or.bit.dto.Board;
import kr.or.bit.utils.ThePager;

/**
 * 게시글 전체 목록 보기 제공해주는 서비스
 */
public class BoardListAllService implements Action{

	@Override
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) {
		ActionForward forward = null;
		
		try {
			BoardDao dao = new BoardDao();
			int totalboardcount = dao.totalBoardCount(); 
			
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
			List<Board> list = dao.list(cpage, pagesize);
			
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
			forward = new ActionForward();
			forward.setRedirect(false);
			forward.setPath("/WEB-INF/views/board/board_list.jsp");
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return forward;
	}

}
