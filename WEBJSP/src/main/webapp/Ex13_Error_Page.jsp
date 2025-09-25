<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page errorPage="/error/commonError.jsp %><!-- 페이지 지정  -->
<!-- 
예외 상황이 발생하더라도 특정 페이지가 보여지도록(다른 화면 보여주기)
처리방법 2가지
1. 해당 페이지에서 설정하기  
    page errorPage로 설정 -> 이 방법은 잘 안씀
2. 전역적인 방법(여기서는 web.xml에서 설정) - 웹사이트 전체에서 설정
    -> 보통 이 방법을 사용함
 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
    <%
        int data = 0/0;
    %>
</body>
</html>