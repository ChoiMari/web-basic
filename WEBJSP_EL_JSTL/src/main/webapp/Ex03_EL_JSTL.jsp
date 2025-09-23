<%@page import="java.util.HashMap"%>
<%@page import="DTO.Emp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    Emp emp = new Emp(2000, "kosauser");

    //사용 - request객체에 담을건지 session객체에 담을건지 결정해야함
    // 현재페이지에만 필요하면 리퀘스트객체에 담고(예외, 인크루드, 포워드는 접근 가능)
    // webapp 전체 페이지에서 사용할거면 session객체에 담아서 쓰면 된다.
    
    request.setAttribute("e", emp);
    HashMap<String, String> hp = new HashMap<>();
    hp.put("data", "1004");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
    <h3>기존방식</h3>
    <%= emp %>
    <%= emp.getEmpno() %>
    <%= emp.getEname() %>
    
    <h3>EL방식</h3>
    EL은 문제가 있음. 자바 객체에 직접 접근은 불가.
    <!-- ${emp}불가 --> <br> 
    그래서 담아 놓고 사용함
    <h4>해결</h4>
    1. 객체 접근으로 사용함 : requeset객체 또는 session객체에 담아서 사용함
    ${requestScope.e}<br>
    ${e.empno} ${e.ename}<br>
    <!-- 속성명(key)으로 접근하면 멤버필드 바로 접근 가능
    getEmpno()호출함 -->
    EL : ${requestScope.e.empno}<br>
    
    <h3>JSTL(core)변수, 제어문(자바코드 없이 가능) : 코드는 서버에서 실행</h3>
    <c:set var="m" value="<%= emp %>" /> <!-- 변수이름 m이고 값이 emp(EMP객체의 주소값) 이 저장-->
    EL을 통해서 출력 : ${m} <br> <!-- toString()재정의해서 그게 호출됨(주소값 출력아니라) -->
    <!-- ${m.getEmpno()} 이건 권장하지 않음 m.empno를 권장함, 자동으로 호출해주는데 쓸떼없이 왜 부르냐(나오긴하지만, 권장하지 않는다고)-->
    EL : ${m.empno}<br>
    EL : ${m.ename}<br>
    
    <hr>
    <h3>JSTL 변수 만들고 scope</h3>
    <c:set var="job" value="농구선수" scope="request"/>
    <!--변수 job의 스코프를 request로 설정함(리퀘스트객체의 스코프와 같음) -->
    당신의 직업은 : ${job}
    include, forward를 사용한다면 다른 페이지에도 사용 가능함
    <hr>
    JAVA API를 활용한 객체는 EL 직접 접근 불가<br>
    *** 권장 방법 : JAVA객체를 EL로 사용하고 싶다면<br>
    request객체나 session객체에 담아서 사용하면 쓸 수 있다.
    <hr>
    <c:set var="vhp" value="<%=hp %>" />
    hp객체 : ${vhp}<br>
    hp객체 : ${vhp.data}<br>
</body>
</html>