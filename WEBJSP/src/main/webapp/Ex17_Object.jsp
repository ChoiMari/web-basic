<%@page import="kr.or.kosa.Emp"%>
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
       Emp emp = (Emp)session.getAttribute("empobj");
    // 오브젝트 타입으로 리턴되기 때문에(제네릭불가) 명시적으로 다운캐스팅 필요함
    %>
</body>
emp 정보 출력 : <%= emp.toString() %>
</html>