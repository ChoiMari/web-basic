<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//이 페이지는 회원전용
	//로그인 하지 않으면 올 수 없는 페이지
	String memberid = (String)session.getAttribute("memberid");
	boolean loginState = (memberid == null) ? false : true;
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		if(loginState == true){
			out.print(memberid + " 님 로그인 상태 입니다<br>");
			out.print("당신은 이 페이지를 볼 수 있습니다<br>");
			//로그아웃
			out.print("<a href='Ex18_Session_logout.jsp'>로그아웃</a>");
		}else{
			out.print("<script>location.href='Ex18_Session_Login.jsp'</script>");
		}
	
	%>
</body>
</html>