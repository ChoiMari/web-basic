<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//자바 코드(서버(백엔드)쪽 코드) : 서버에서 컴파일 실행되는
//jsp는 ui담당
/*
M(java : pojo 포조 : DTO, DAO, SERVICE)
V(View : 화면을 구성(MPA : 멀티 페이지 어플리케이션(페이지 여러개,jsp) <-> SPA : 싱글페이지 어플리케이션(비동기로 계속 갈아낌, 페이지는 1개, react,vue)))
    -> 지금은 개인 PC, 인터넷 사양이 좋아져서 SPA를 많이씀(클라이언트, 브라우저에서 처리)
C(controller : 서블릿, 요청과 응답을 담당 : servlet 웹용 자바파일)

지금은 수업이라서 
JSP 혼자서 데이터 받고 DB연결 하고 화면 출력(페이지 하나 가지고..)
원래는 이렇게 안씀
*/

    String userid = request.getParameter("userid");
    String userpw = request.getParameter("userpw");
    // 필요에 따라서 JDBC로 DB연결 
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
    <h3>당신이 입력한 데이터</h3>
    ID : <%= userid %><br />
    PW : <%= userpw %>
</body>
</html>