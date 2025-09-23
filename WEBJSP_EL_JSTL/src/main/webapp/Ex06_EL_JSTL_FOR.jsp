<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
    <c:forEach var="i" begin="0" end="10">
        <c:set var="sum" value="${sum+=i}" />
        <!-- 이 변수 sum의 스코프?현재페이지 전체인가? -->
        ${i}<br>
    </c:forEach>
    sum : ${sum}<br>
    
    <ul>
        <c:forEach var="i" begin="1" end="9">
            <li>3*${i} = ${3*i}</li>
        </c:forEach>
    </ul>
    
    <h3>forEach Choose</h3>
    <c:forEach var="i" begin="2" end="9">
        <c:forEach var="j" begin="0" end="9">
            <c:choose>
                <c:when test="${j == 0}">
                    ${i}단
                </c:when>
                <c:otherwise>
                    ${i}*${j} = ${i*j}&nbsp;&nbsp;
                </c:otherwise>
            </c:choose>
        </c:forEach>
        <br>
    </c:forEach>
    <%
        //자바가 제공하는 자원
        int[] arr = new int[]{10,20,30,40,50};
        for(int i : arr){
        	   out.print("출력값 <b><i>" + i + "</i></b><br>");   
        }
        request.setAttribute("iarr", arr); //-> 요청객체든, 세션객체든, 애플리케이션 객체든
        //객체에 담아야 EL로 접근 가능함
    %>
    <c:forEach var="arr" items="${iarr}"><!-- 향상된 for문과 비슷 items가 배열 -->
        배열값 : ${arr}<br>
    </c:forEach>
    
    <h3>가능은 하지만 권장사항은 아닌 방식</h3>
    <c:set var="array" value="<%=arr %>"/>
    <!-- 이걸 제거해서 스파게티 안하려고 EL쓰는건데..이렇게 쓰면 의미가 없다.. -->
</body>
</html>