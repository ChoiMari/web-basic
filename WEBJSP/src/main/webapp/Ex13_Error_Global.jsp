<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String data = request.getParameter("name");
    String data2 = data.toLowerCase(); //null 데이터는 소문자로 변환 안됨 -> 예외 발생
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
전달 받은 내용 : <%= data2 %>
</body>
</html>