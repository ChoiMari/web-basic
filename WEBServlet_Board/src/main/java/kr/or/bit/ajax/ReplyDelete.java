package kr.or.bit.ajax;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.bit.dto.Reply;
import kr.or.bit.service.BoardService;

import java.io.IOException;
import java.util.List;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

/**
 * 댓글 삭제 - 비동기 처리
 */
@WebServlet("/ReplyDelete")
public class ReplyDelete extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReplyDelete() {
        super();

    }


//	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		
//	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");

        String no = request.getParameter("no");
        String pwd = request.getParameter("delPwd");
        String idx_fk = request.getParameter("idx");

        try {
            int result = BoardService.getInBoardService().replyDelete(no, pwd);
            String status = result > 0 ? "success" : "fail";

            // 삭제 후 댓글 목록 다시 조회
            List<Reply> replyList = BoardService.getInBoardService().replyList(idx_fk);
            Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm").create();
            String json = gson.toJson(replyList);

            response.getWriter().print(json);
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().print("{\"status\":\"fail\",\"msg\":\"서버 오류\"}");
        }
    }

}
