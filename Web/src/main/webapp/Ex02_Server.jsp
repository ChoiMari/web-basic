<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<% 
    // 자바 코드 (서버쪽 토드 사용 가능 영역)
    String str = "hello world";
    //내용은 클라이언트가 해석하지 못함
    //WAS(톰캣)이 이 페이지에 요청이 들어오면 그때 이 페이지를 컴파일함
    //(확장자 Ex02_Server.jsp.class) 실행
    // 클라이언트의 웹 브라우저가 해석 가능하도록 html, css, javascript, text변환
%>
서버값 : <%= str %>
</body>
</html>