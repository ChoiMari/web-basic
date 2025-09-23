<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
        <h3>요청 처리하기</h3>
        <%= request.getContextPath() %><!-- /WEBServlet_1 -->
        <hr>
        <a href="<%=request.getContextPath()%>/simple">simple 요청하기(GET)</a>
        <br>
        <a href="<%=request.getContextPath()%>/simple?type=date">simple 날씨 요청하기(GET)</a>
        <br>
        <a href="<%=request.getContextPath()%>/simple?type=abcd">simple 비정상 요청하기(GET)</a>
        
        <h3>FrontBoardController 사용하기 (command 방식으로 ..)</h3>
        <a href="<%=request.getContextPath()%>/Board?cmd=boardlist">게시판 목록보기</a>
        <br>
        <a href="<%=request.getContextPath()%>/Board?cmd=boardwrite">게시판 글쓰기</a>
        <br>
        <a href="<%=request.getContextPath()%>/Board">cmd null error 페이지</a>
        <br>
        <a href="<%=request.getContextPath()%>/Board?cmd=login">보안 페이지 로그인</a>
        <hr>
</body>
</html>