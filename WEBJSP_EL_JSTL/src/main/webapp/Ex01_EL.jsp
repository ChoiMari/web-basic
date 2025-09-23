<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   /* 
        <EL>
        Expression Language(표현 언어)의 약자 (EL)
        JSP 2.0에서 새롭게 추가된 스크립트 언어
        기존의 Script tag의 표현식(정보: 스크립트 릿) 
        tag에서 업그레이드된 버전 -> 구문 : ( ${ 정보 } )
        EL은 아파치 톰캣이 지원 - 아파치 톰캣에 내장된 라이브러리를 사용하는 것
        
        [ EL의 주요 특징 ]
        1) JSP 속성영역 (request,  response, session, application) 
           저장된 속성 객체의 property를 출력한다 
        2) 리터럴 데이터, 다양한 연산결과 출력이 가능하다 
        3) JSTL과 연동이 가능하다  (EL 출력을 담당하는  
                script > 변수 , 제어문 ,논리 제어 방법이 없어요)
        (JSTL은 아파치톰캣 제공 X -> 별도로 다운 받아서 사용함, jar로 2개다운받음
                메이븐,그레이들 등으로도 의존성 추가로도 가능함
        https://mvnrepository.com/artifact/jakarta.servlet.jsp.jstl/jakarta.servlet.jsp.jstl-api/3.0.0
        https://mvnrepository.com/artifact/org.glassfish.web/jakarta.servlet.jsp.jstl/3.0.0
        )
        
        EL(출력 표현식) : 출력 담당 표현식, 서버쪽의 데이터를 출력할 수 있음
            JSP 페이지에서 사용되는 출력 전용 스크립트 언어 (화면...) 
        POINT) **********[서버]에서 해석되는 스크립트언어*************
        만들고 사용하는 이유 
        : 스파케티 코드가 싫음 % + UI(정적) > 유지보수 어려움 > 코드의 가독성(해석)
        
        문제) EL & JSTL 만들어서 html 과 잘 놀고 ... JSP 사용가능 
        
        <사용법>
        EL : tomcat 서버가 내장하고 있는 자원 (별도의 참조 필요 없다)
        JSTL : 다운로드 해서 (빌드 path....)  WEB-INF > lib > 복사 붙여넣기 > jar 파일
        
        
        EL은 객체를 가지고 있다
        1. param       -> requset.getParameter와 같음
        2. paramValues -> requset.getParameterValues와 같음(배열로 리턴받는거.. 파라미터 이름이 동일한게 여러개인 경우 사용)
        3. requestScope  -> request.setAttribute로 저장한걸 쓰는 방법 ${}안에 requestScope.으로 접근해서 사용함
        4. sessionScope  -> session.setAttribute로 저장한걸 쓰는 방법 ${}안에 sessionScope.으로 접근해서 사용함
        5. applicationScope -> application.setAttribute로 저장한걸 쓰는 방법 ${}안에 applicationScope.으로 접근해서 사용함 
    */
%>    
<%
    //*************자바코드영역**********
    request.setCharacterEncoding("UTF-8");

     String id = request.getParameter("userid");
    
    //다른 전달(forward)
    request.setAttribute("name", "hong");
    request.setAttribute("hobby", "java");
    
    session.setAttribute("userid", "king");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h3>기존 JSP 출력</h3>
<b><%=id%></b><br>
<b><%= request.getAttribute("name") %></b><br>
<b><%= request.getAttribute("hobby") %></b><br>
<h3>EL 출력</h3>
기존코드 <%= 1+5%><br>

EL: ${100+200+300}<br>
EL: ${1==1}<br>
EL: ${false}<br>
EL: ${!false}<br>
EL: ${empty x}<br>

</body>
</html>