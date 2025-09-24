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


@WebServlet("/MemoList")
public class MemoList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public MemoList() {
        super();
    }

    //get이나 post나 같은 로직일 때 사용함
	private void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("목록보기");
		//요청에 따른 판단이 필요없다(프론트컨트롤러 필요한데...)
		
		//목록보기
		MemoDao memoDao = new MemoDao();
		try {
			//데이터 받기
			List<Memo> memoList = memoDao.getMemoList(); //-> 원래 이 작업 서비스가...
			//데이터 저장
			request.setAttribute("memoList", memoList);
			
			//뷰지정 - webapp기준으로 경로 지정함
			RequestDispatcher dis = request.getRequestDispatcher("/memolist.jsp");
			
			//포워드
			dis.forward(request, response);
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

}
