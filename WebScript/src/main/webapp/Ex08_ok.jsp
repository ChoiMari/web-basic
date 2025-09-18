<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    //자바 코드 적을 수 있음
    String id = request.getParameter("txtuserid");
    String pw = request.getParameter("txtpwd");
    
    //필요에 따라서 검증 등의 작업(사실 jsp에서 이런 작업은 X)
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
    서버확인<br>
    당신이 입력한 ID : <%= id %> <br>
    당신이 입력한 PW : <%= pw %> <br>
</body>
</html>