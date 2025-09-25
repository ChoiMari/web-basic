<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    String id = request.getParameter("id");
    if(id.equals("hong")){
%>   
    <%=id %><img src="images/1.jpg"  style="width: 100px; height: auto;"/>
<% }%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
    <h3>EL & JSTL</h3>
    <!-- EL도 param객체를 가지고 있음 
    이건 request.getParameter()와 같음 
    String id = request.getParameter("id"); 이걸 EL을 사용하면 더 편하게 가능함
    -->
    ${param.id}<br/>
    <c:if test="${param.id == 'hong'}"></c:if>
    <!-- test안에 적는게 조건문 ""안이라서 ''사용함-->
    ${param.id}<img src="images/1.jpg"  style="width: 100px; height: auto;"/>
    <!-- http://localhost:8090/WEBJSP_EL_JSTL/Ex04_EL_JSTL.jsp?id=hong&age=25 -->
    <c:if test="${param.age > 20}" var="result">
        <!-- test조건문의 true/false결과를 변수에 담아서 쓸수도 있음
        if문에 var변수 선언시 결과가 담김 -->
        if문의 var변수는 result : ${result}<br>
        <!-- jstl태그의 변수는 EL로 읽을 수 있음 -->
    </c:if>
</body>
</html>