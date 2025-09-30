package kr.or.kosa.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.or.kosa.dao.MemberDao;
import kr.or.kosa.dto.MemberDTO;

@WebServlet("/member/*")
public class MemberController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doProcess(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doProcess(request, response);
    }

    protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String uri = request.getRequestURI();
        String path = uri.substring(uri.lastIndexOf("/"));

        if (path.equals("/login")) {
            // 로그인 처리
            String id = request.getParameter("id");
            String pw = request.getParameter("pw");

            MemberDao dao = new MemberDao();
            MemberDTO dto = dao.login(id, pw);

            if (dto != null) {
                // 로그인 성공 시 세션에 정보 저장
                HttpSession session = request.getSession();
                //현재 요청과 관련된 세션이 있으면 그 세션을 반환하고, 없으면 새로 생성해서 반환하라
                session.setAttribute("user", dto); //세션객체에 user객체 저장
                response.sendRedirect("/index.jsp");
            } else {
                // 로그인 실패
                response.getWriter().println("<script>alert('아이디 또는 비밀번호가 일치하지 않습니다.'); history.back();</script>");
            }
        } else if (path.equals("/logout")) {
            // 로그아웃 처리 - 세션을 소멸시킴
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate();
            }
            response.sendRedirect("/index.jsp");
        }
        // 회원가입, 정보수정 등의 로직 추가 가능
    }
}
