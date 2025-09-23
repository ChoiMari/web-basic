<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- 
    페이지를 2개 만든다.
    화면 + 로직처리 이게 단짝
    회원가입한다고 치면 클라이언트에게 화면을 달라고 처리해달라고
	jsp로 만들면 보통 login.jsp(로그인 화면)
        <form action="loginok.jsp"태그 loginok.jsp페이지는 로직처리페이지
        loginok.jsp -> 한글처리, 데이터 받고 DB처리
    
    	순수한 JSP 사이트 제작
		Model1 방식 개발(->실무에서 사용 안함) (JSP 요청받고 처리 ...) 
        >> 동생에게 게시판 만들어 줄때 ...나 간단하게 사용하는 방식..
		
		
		UI + 처리 (2개 설계)
		login.jsp -> loginok.jsp
		
		action="Ex20_Session_ok.jsp"
 -->
	<form action="Ex18_Session_ok.jsp"  method="post">
		<input type="text" name="uid"><br>
		<input type="password" name="pwd"><br>
		
		<input type="submit" value="로그인">
		<input type="reset"  value="취소">
	</form>
	<hr>
	<h3>회원 전용 페이지</h3>
	<a href="Ex18_Session_Member.jsp">회원접속</a>
</body>
</html>