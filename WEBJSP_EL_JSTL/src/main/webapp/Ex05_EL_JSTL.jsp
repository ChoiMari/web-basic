<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
/*
    EL & JSTL은 WAS가 해석(서버쪽 스크립트이기 때문)
    <c:set var="변수명" value ="변수에 저장되는값">
    <c:if test="조건"> -> 이건 else if가 없어서 활용도 낮음
    <c:choose> if보다 활용도가 좋다 else if처리 가능(스위치랑 비슷)
    <c:forEach> 자바스크립트의 forEach와 비슷
    <c:forTokens> 자바의 split과 비슷
    <c:out> -> XSS공격 막으려면 이걸로 써서 출력해야함(EL말고 - 이건 xss못막음)
    <c:catch> 예외처리 
*/

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
    <h3>JSTL & EL</h3>
    EL은 파라미터를 받을 수 있음
    파람객체.으로 접근
    ${param.id}-${param.pwd}<br>
    <!-- http://localhost:8090/WEBJSP_EL_JSTL/Ex05_EL_JSTL.jsp?id=123&pwd=123
    123-123으로 출력됨
     -->
     <c:set var="userid" value="${param.id}" />
     <c:set var="userpwd" value="${param.pwd}" />
     <h3>변수값 출력</h3>
     id : ${userid}<br>
     pwd : ${userpwd}<br>
     <hr>
     <c:if test="${!empty userpwd}">
        <h3>비밀번호는 빈값이 아니다</h3>
     <!-- userpwd가 빈값이면? 그거의 부정! -> userpwd가 빈값이 아니면 실행-->
        <c:if test="${userpwd == '1004' }">
            <h3>환영합니다 1004</h3>
        </c:if>
     </c:if>
</body>
</html>