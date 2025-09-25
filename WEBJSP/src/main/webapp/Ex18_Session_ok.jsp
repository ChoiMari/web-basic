<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//처리 
	//login 에 대한 처리
	
	//1.한글처리
	request.setCharacterEncoding("UTF-8");
	
	
	//2.데이터 받기
	String uid = request.getParameter("uid");
	String pwd = request.getParameter("pwd");
	
	//3.업무처리(요구사항)
	//DB 연결 (CRUD)
	//암호화 ...
	//회원인지 아닌지 검증
	// select count(*) from member where uid=? and pwd=?
	// select id, pwd from member where id=?  
	// 했다 치고
	
	boolean success = false;
	if(uid.equals(pwd)){ //uid == pwd 같다면 회원으로 판단
		//로그인 성공
		//사용자가 원하는 페이지 보여주기 
		//memeber.jsp (회원 : 인증된 사용자 )
		//session 객체 > scope > WAS(webapp 폴더 안에 모든 페이지 접근)
		session.setAttribute("memberid",uid); //***********************************
		//session.getAttribute("memberid") >> null 아니냐 또는 admin  판단
		//다른 페이지에서는 session 객체 사용 ...
		success = true;
	}
%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		if(success == true){
			//로그인성공
			out.print("<h3>로그인 성공</h3><br>");
			String user = (String)session.getAttribute("memberid");
			out.print(user + "님 로그인 되었습니다<br>");
			out.print("<a href='Ex18_Session_Member.jsp'>회원전용페이지</a>");
			
		}else{
	%>
		<!-- 로그인 실패 -->
		<script type="text/javascript">
			alert("다시 로그인해");
			location.href="Ex18_Session_Login.jsp"; //F5 페이지 새로운 요청
			//window.history(-1) //-> 뒤로가기(이전페이지로 이동)
		</script>
	<%		
		}
	%>
</body>
</html>