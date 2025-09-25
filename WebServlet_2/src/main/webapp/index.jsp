<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- http://192.168.0.29:8090/WebServlet_2/index.jsp 
request.getContextPath()  >> http://192.168.0.29:8090/WebServlet_2

pageContext.request.contextPath  >> http://192.168.0.29:8090/WebServlet_2
-->
	<h3>index page</h3>
	<a href="${pageContext.request.contextPath}/NowServlet">요청하기</a>
	<br>
	<a href="${pageContext.request.contextPath}/Now.do">요청하기</a>
	<br>
		<br>
	<a href="${pageContext.request.contextPath}/Now.action">요청하기</a>

</body>
</html>