<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    //EL은 자바코드는 아니고 출력 스크립트언어
    //EL은 <%=을 대체 -> ${}로 사용
    
    Date today = new Date();
    request.setAttribute("day", today);
    session.setAttribute("day2", today);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
    <h3>EL 화면출력(서버쪽 자원 접근 출력)</h3>
    EL : ${requestScope.day}<br> <!-- 요청객체에 접근해서 읽어옴(키값으로) -->
    EL : ${day}<br>  <!-- EL은 객체가 없어도 읽어올 수 있음 -->
    <!-- 하지만 권장하지 않음.. 어떤 객체에서 읽은건지 알수없어서(가독성떨어짐)
    그래서 생략은 가능하지만 앞에 객체를 명시하자 
    EL은 서버쪽 코드-->
    EL : ${day2}<br>
    EL : ${sessionScope.day2}<br>  
</body>
</html>