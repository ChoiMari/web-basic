<%@page import="kr.or.bit.service.BoardService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">
/*
out.print(board.getSubject() + "<br>");
out.print(board.getWriter() + "<br>");
out.print(board.getEmail() + "<br>");
out.print(board.getHomepage() + "<br>");
out.print(board.getContent() + "<br>");
out.print(board.getPwd() + "<br>");
out.print(board.getFilename() + "<br>");
*/	

//out.print(board.getSubject() + "<br>");
//out.print(board.getWriter() + "<br>");
//단 jsp:useBean 성립  jsp:setProperty 자동화 ... 전제 ...
//name="subject" 이름이  Board DTO 객체 memberfield명과  동일

//DB 컬럼명 == DTO memberfield == input name 속성명과 같다 (자동화...)

//write.jsp(클라이언트 화면) >> 처리 writeok.jsp >> DAO객체 생성, 처리 ... (x)
//write.jsp(클라이언트 화면) >> 처리 writeok.jsp >> service 만 노출 >> 업무 ...
//
</script>
<jsp:forward page="/WEB-INF/views/board/redirect.do"></jsp:forward>








