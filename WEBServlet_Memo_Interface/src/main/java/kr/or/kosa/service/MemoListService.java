package kr.or.kosa.service;

import java.sql.SQLException;
import java.util.List;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.kosa.action.Action;
import kr.or.kosa.action.ActionForward;
import kr.or.kosa.dao.MemoDao;
import kr.or.kosa.dto.Memo;

public class MemoListService implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) {
		
		ActionForward forward = null;
		MemoDao dao = new MemoDao();
		
		try {
			List<Memo> memoList = dao.getMemoList();
			request.setAttribute("memoList", memoList);
			
			forward = new ActionForward();
			forward.setRedirect(false);
			forward.setPath("/WEB-INF/views/memolist.jsp");//뷰 지정
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return forward;
	}

}
