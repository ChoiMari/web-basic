<%@page import="kr.or.kosa.Emp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!--  
        Tomcat제공(WAS) : 기본적인 내장 객체(자동으로 생성되어서 new없이 사용할 수 있는 객체)를 가지고 있음
        1. request  (요청: 클라이언트 정보)
        2. response (응답: 특정 페이지 이동 , 정보 출력 , 쿠키 쓰기)
        3. application(전역객체: web.xml 자원 접근 read , 전역변수)
        4. session(고유객체(접속한 사용자에게 부여되는): 고유한 변수)
        5. out (출력)
        ....

​

    *session객체 (활용도 ^^)
    세션 객체의 스코프(사용범위, 생존기간)? 객체에는 멤버필드(프로퍼티스)가 있음, 메서드랑
    세션 객체에 필요에 따라서 변수를 만들 수 있음(session.setAtt..로 만들 수 있다)
    그 변수를 가져와서 쓰려면 session.getAtt..사용
    세션 객체는 모든 페이지(Webapp  폴더 안에 있는 모든 페이지)에서 공유 가능하다.
    (세션 객체 웹 브라우저당 1개 생성됨)
    리퀘스트 객체는 인크루드하거나 포워드하면 공유함
    세션객체 - 서버에 메모리 사용하는 것
    세션 활용? 접속한 사용자의 id
    
    [내부에 session변수 생성]
    scope : a.jsp(session.setAtt.."member" 변수 생성)
            b.jsp(session.getAtt.. "member" 사용가능) 
        session 변수는 (**현재 Webapp  폴더 안에 있는 모든 페이지에서 사용 가능**)
        Life-cycle : 1. session변수는 session객체와 동일 
                     2. session 소멸 : 서버 리부팅 , Tomcat 재실행, 
                     로그아웃 session.invaildate()

    *application 객체(전역자원) - 접속한 모든 세션(사용자)가 사용가능한 객체
    [내부에 application변수 생성 : 전역변수 >>모든 session (접속한 모든 사용자) 공유
    scope :   (현재 Webapp  폴더 안에 있는 모든 페이지에서 사용 가능) 
        application 객체는 java의 static과 비슷
    Life-cycle : 소멸 (서버 리부팅), Tomcat 재실행  

     

    *request 객체 - 안에도 변수 생성가능
    페이지당 1개씩 생성되어서 그 페이지 내부나 인크루드,포워드된 페이지에서 사용가능
    [내부에 변수를 생성함] : request.setAttribute("type","A"); *****~~~~~
    scope: 요청 페이지(login.jsp >> 요청당 request 생성(요청당 1개) 
    리퀘스트객체의 scope는? 그 page안에서만
    예외적으로는 인크루드나 포워드 한 경우만 리퀘스트 객체 공유 가능
    login.jsp >> ok.jsp(include or forward) request 객체는 ok.jsp 공유된다

-->      
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
    <%
         Emp emp = new Emp();
         emp.setEmpno(2000);
         emp.setEname("홍길동");
         
         //POINT 내장 객체라서 new없이 사용가능(자동으로 생성되어 있기 때문에)
        //emp 객체변수 scope (page 한정)
        //요점 : emp객체를 다른 페이지에서도 사용 ...
        session.setAttribute("empobj",emp ); //session.setAttribute("키",값)
        //-> 이 세션 객체는 Webapp 안에 있는 모든 페이지에서empobj 사용 가능
        
        //정보를 모든 페이지가 접근 아니고 include , forward 페이지서만 접근하고 싶어요
        request.setAttribute("who", "king");
        //request객체는 현재 페이지에만 접근가능. 단 포워드나 인크루드한 경우엔 사용가능
        //forward 했어요 (a.jsp) > a.jsp (request.getAttribute("who"))
    
    
        /*
            클라이언트 서버 요청(a.jsp) ->  서버 요청당 한 개의 -> request 메모리_1 , (접속당) session 메모리 (같은)
            클라이언트 서버 요청(b.jsp) ->  서버 요청당 한 개의 -> request 메모리_2 , (접속당) session 메모리 (같은)
            클라이언트 서버 요청(c.jsp) ->  서버 요청당 한 개의 -> request 메모리_3 , (접속당) session 메모리 (같은)
            클라이언트 서버 요청(d.jsp) ->  서버 요청당 한 개의 -> request 메모리_4 , (접속당) session 메모리 (같은)
            
            개발자 고민 a.jsp > 생성된 > request 메모리_1 > 다른 페이지 공유하고 싶다?
            		해결 : include , forward로 만든다 -> aaa.jsp
            개발자 고민 a.jsp > 에서 만든 자원 > 모든 페이지 사용하게 하고 싶어 
                    해결 : session객체 사용 
            
            접속자 1명이 각각의 페이지를 요청할 땐
            리퀘스트객체는는 각각페이지당 1개씩 생성되고
            세션 객체는 딱 1개 생성(이건 브라우저당 1개생성)
        */
    
    %>
    
    <%= emp.getEmpno()%><hr>
    <%= request.getAttribute("who")%><hr>
    <a href="Ex17_Object.jsp">Ex17</a>
        <!-- 
        request 객체 유효범위 : 요청한 페이지에서 단) include, forward 그 페이지도 사용가능
        session 객체는 유효범위 webApp 안에 있는 모든 페이지 
          -->
</body>
</html>
