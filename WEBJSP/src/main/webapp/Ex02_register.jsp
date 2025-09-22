<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
//jsp 페이지는 request객체, response 객체를 내장하고 있어서 그냥 사용이 가능하다.
//응답, 요청 객체는 웹서버의 메모리에 만들어짐
//페이지는 요청을 읽어냄
//요청 1개마다 요청객체가 서버에서 만들어짐. 요청객체는 클라이언트의 정보를 가지고 있다

/*
서버의 역할
1. 한글처리(한글 깨짐 방지)
2. 데이터 받기
3. 로직 수행
4. 결과 응답

클라이언트로 부터 전송된 데이터를 받으려면 
1.1 톰캣에 내장객체가 존재한다(대표적 : 리쿼스트객체, 이미new가 되어있다. 자동생성됨)
    요청 페이지마다 리쿼스트 객체가 자동 생성
1.2 HttpServletRequest request = new Http... 이게 자동 생성
-> jsp는 이 리퀘스트 객체를 그냥 쓰면 된다. 자동 생성되므로 new가 필요없음
1.3 클라이언트 서버에 클라이언트가 회원가입, 게시판에 글 등의 요청을 보내면
서버는 요청 페이지 당 한개의 request를 자동 생성함
1.4 request객체는 사용자 입력 데이터, 클라이언트의 ip주소, 클라이언트의 브라우저 정보 등
1.5 request객체에서 필요한 정보만 파싱해서 쓰면 된다.
*/

    //한글 처리
    request.setCharacterEncoding("UTF-8");

    //요청 파라미터 받음
    String uid = request.getParameter("userid");
    String pwd = request.getParameter("pwd");
    
    String[] hobbys = request.getParameterValues("hobby"); 
    // 요청 파라미터 이름이 같은걸 배열로 받음
    
    
   //로직처리 - DB연결, DTO객체, ... 등등

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
    서버에서 클라이언트로 응답<br>
    ID : <%= uid %><br>
    PW : <%= pwd %><br>
    <% for(String str : hobbys){
    	%>  
        <b> HOBBY : <%=str%></b><br>
    <% } %>
</body>
</html>