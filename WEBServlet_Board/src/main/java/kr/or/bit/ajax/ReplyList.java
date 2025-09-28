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
 * 댓글 목록 - 비동기
 */
@WebServlet("/ReplyList")
public class ReplyList extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public ReplyList() {
        super();
 
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");

        String idx_fk = request.getParameter("idx");

        try {
            List<Reply> replyList = BoardService.getInBoardService().replyList(idx_fk);
            Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm").create();
            String json = gson.toJson(replyList);

            response.getWriter().print(json);
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().print("{\"status\":\"fail\",\"msg\":\"서버 오류\"}");
        }
    }
	
    
//	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//
//		doGet(request, response);
//	}

}
