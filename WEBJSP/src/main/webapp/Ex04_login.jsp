<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//1.한글처리 2.데이터 받기 3.로직처리(비지니스) -> DB(CRUD)

//내장 객체(WAS 톰켓)
//1.request(클라이언트의 정보를 담고 있는 객체) - 요청 페이지 당 1개(웹서버의 메모리에 생성됨)
//2.response(웹서버가 가지는 객체, 응답객체)
//3.session객체 - 클라이언트마다 고유하게 생성되는 고유객체
//    -> 접속자 100명이면 100개 만듬(만료시간 설정)
//4.application객체 : 전역자원, 모든 접속자(세션)이 공유하는 객체
//5.out객체 : 출력객체 out.print

//위 5개의 객체는 jsp에서는 new없이 사용이 가능하다(미리 자동 생성되어있기 때문에)
    request.setCharacterEncoding("UTF-8");
    String id = request.getParameter("id");
    /*
        model1 방식에서 MVC를 흉내낼 수 있다.
        JSP 요청.. 
        model -> DTO, DAO사용
        MemberDao memberDao = new MemberDao();
        MemberDto memberDto = new MemberDto();
        
        memberDto.setId(id);
        int result = memberDao.insertData(dto);
        클라이언트에게 가입 성공 메시지 전달
    */
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
    1. 입력값 <%= id %><br>
    2. 접속한 클라이언트의 IP <%= request.getRemoteAddr() %><br>
    3. 포트 : <%= request.getServerPort() %><br>
    4. 경로 : <%= request.getContextPath() %><br>
    <!-- 
        웹에서 바라보는 경로는 가상 디렉토리라고 부름
        실 경로는 C:\\Web\\webapp\\a.jsp 경로를 가상 디렉토리로 바라봄
        서비스 되어 나갈 땐 192.168.0.12/Web/a.jsp라는 가상 경로
        실 경로가 필요할 땐 request.getContextPath() -> 실경로
        요청객체.getContextPath()
     -->
</body>
</html>