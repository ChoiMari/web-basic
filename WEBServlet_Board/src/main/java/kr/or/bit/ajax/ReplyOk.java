package kr.or.bit.ajax;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.bit.dao.BoardDao;
import kr.or.bit.dto.Reply;
import kr.or.bit.service.BoardService;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.naming.NamingException;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

/**
 * 댓글 달기 - 비동기 처리
 */
@WebServlet("/ReplyOk")
public class ReplyOk extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ReplyOk() {
        super();
      
    }

//	private void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		
//		response.setContentType("application/json;charset=UTF-8"); //한글 처리 + JSON 데이터로 클라이언트에게 보냄
//		//PrintWriter out = response.getWriter();//서블릿 응답용 문자 출력 스트림을 반환
//		//서블릿에서 클라이언트(브라우저)로 데이터를 직접 출력할 때 쓰는 코드
//		//PrintWriter 객체를 통해 HTML, JSON, 문자열 등을 브라우저로 전송할 수 있음
//		//출력 후 반드시 flush()하기 -> 데이터가 버퍼에 남아있으면 브라우저에 전달 안 될 수 있음
//		//close() 호출 -> 리소스 반환
//		// Gson같은 JSON변환 라이브러리쓰면 PrintWriter객체 필요없음
//		// JSON으로 변환해서 바로 응답 스트림에 쓸수있음
//
//        request.setCharacterEncoding("UTF-8");
//        response.setContentType("application/json;charset=UTF-8");
//
//        String writer = request.getParameter("reply_writer");
//        String content = request.getParameter("reply_content");
//        String pwd = request.getParameter("reply_pwd");
//        String idx_fk = request.getParameter("idx");
//
//        try {
//            // 댓글 저장
//            int result = BoardService.getInBoardService()
//                    .replyWrite(Integer.parseInt(idx_fk), writer, "empty", content, pwd);
//
//            // 댓글 목록 조회
//            List<Reply> replyList = BoardService.getInBoardService().replyList(idx_fk);
//
//            // Gson으로 JSON 변환
//            Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm").create();
//            //Gson 자체는 LocalDateTime 같은 날짜 타입을 바로 JSON으로 변환 못해서 에러 이슈있음
//            //그래서 GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm").create() 이렇게 날짜 포맷을 명시적으로 지정
//            
//            String json = gson.toJson(replyList);
//
//            response.getWriter().print(json);
//
//        } catch (Exception e) {
//            e.printStackTrace();
//		}
//		
//	}

//	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		doProcess(request, response);
//	}


    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	
    	// 한글처리는 필터에서 처리 가능
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");

        String writer = request.getParameter("reply_writer");
        String content = request.getParameter("reply_content");
        String pwd = request.getParameter("reply_pwd");
        String idx_fk = request.getParameter("idx");

        try {
            // 댓글 저장
            BoardService.getInBoardService().replyWrite(
                    Integer.parseInt(idx_fk), writer, "empty", content, pwd);

            // 저장 후 전체 댓글 조회
            List<Reply> replyList = BoardService.getInBoardService().replyList(idx_fk);

            // Gson으로 JSON 변환, LocalDateTime 처리
            Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm").create();
            String json = gson.toJson(replyList);

            response.getWriter().print(json);
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().print("{\"status\":\"fail\",\"msg\":\"서버 오류\"}");
        }
    }


}
