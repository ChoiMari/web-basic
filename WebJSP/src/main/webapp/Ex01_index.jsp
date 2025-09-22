<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//jsp는 신규개발 X, 유지보수 측면에서 배운다.
//jsp -> Web에서 화면을 제어하는 파일, UI도 만들 수 있고, 등등.. 모든작업이 가능하다
//java 코드를 쓰는 영역    
//jsp 파일에서는 우리가 원하는 모든 작업 가능 (DB연결 > 실행 > 결과 > 화면 출력 등 모두 할 수 있음) 
//  > jsp (웹에서 필요한 모든 작업 가능)
//jsp 장점: 빠르고 , 쉬워요 ... 모든 개발자 쉽게 웹을 .... jsp와 비슷한게 ASP, PHP 같은 계열.
// ASP가 버전업된게 ASPX
//    단점: 분업화 힘들어요 , 유지보수 ( 모든 코드가 한곳에 ) 
//      >> 관심사가 분리 되어 있지 않아요 

Date date = new Date();
/*  
    JSP는 늦게 만들어 졌다.. 서블릿이 먼저 개발됨.
    서블릿? 
    JSP 페이지 : UI(html+css+javascript) + JAVA코드(<% 스크립트릿 안에 구현)
    >> 디자인코드 + 서버의 로직코드 구현 : 문제점> 협업, 유지보수 하기 어려워요 
    
    servlet(형) > 웹 전용 java 파일 > jsp(동생)
    >>java 웹 기반 기술이 아니예요 > 계산기 , 그림판 , 원도우 프로그램(awt , swing) 
        > 웹 전향(객체:request,response)
    >>java 페이지 Web을 서비스 하자 > login.java > loginok.java (웹객체 상속 ...) 
        > 웹에서 사용하는 자바(servlet)
    >>단점 : 배우기 어렵다 , **디자인 작업 (힘들어요 )**, 협업(x)
    
            [ 서블릿에서 디자인 코드 ] -- 어렵다.. UI작업이 힘듬
            response.setContentType("text/html;charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.print("<html>");
                out.print("<head><title>HELLO</title></head>");
                out.print("<body>");
                    out.print("현재 날짜 : " + new Date() + "<br>");
                    out.print("<script>alert('경고')</script>");
                out.print("</body>");
            out.print("</html>");   
            
    서블릿의 UI작업이 힘들어서 나온게 JSP
    
    >> JSP 탄생 >> jsp의 장점은 UI 작업이 편하다 >> web page >> html base >> 디자인 good 
            >> jsp의 단점 java코드가 불편.. <%...안에 자바코드를 작성해야 <%안에 작성한건 컴파일
    >> 혼재 (JAVA + UI) >> 힘들어.... 스파게티코드.. 막 섞여있다.. 디자인 + 서버코드.. 유지보수 힘들어..
            jsp가 자바의 코드 쓰기가 힘들어..
    
    정리) 
    -> 서로의 장점을 살리자 (현대적인 프로그래밍은 잘하는 것을 키워 주자 , 업무의 효율 )
        >> MVC 패턴 도입
    >> JSP(UI) + JAVA(순수한 자바 코드) + servlet(웹 요청,응답 조정의 역할)
    jsp는 ui만 담당, java는 자바코드 - 백엔드, servlet - (앞단에서 클라이언트 요청을 받아서)통제, 제어
    분업 하자
    Model (DTO , DAO)  >> 순수한 JAVA(POJO : 어떤 것도 의존하지 않는 순수한 java파일)
    View  (UI)         >> JSP
    Controller(중앙통제) >> Servlet 
    
    MVC 패턴으로 현재까지 개발 되고 있어요 
        >> 추가적으로 MSA등등 나오고 있어요(MSA : 마이크로서비스아키텍처)
    >> model1은 (JSP가 모든 요청과 응답을 처리하는 방식. 이건 Servlet이 없음 ) + Model(POJO)은 있다 
        >> 동생에게 게시판 하나 만들어 주고 싶어요 이렇게 간단한 개발엔 편하다.(회사에서는 X)
    >> model2가 MVC. (Servlet 통한 요청과 응답을 처리 ) + MVC 
        >> 지금 수업시간에서 하는건 model2 기반의 MVC 
            model2 기반의 MVC패턴으로 프로젝트 해 보았어 >> 기업환경
    
    서버? 웹서버, WAS
    		웹서버 : 대표적 엔진엑스(앞단에서 로드벨런싱을 함), 아파치만 붙으면 웹서버
            클라이언트에 요청을 받고 응답을 할 수 있음.
    html 서비스 
    웹서버 있으면 되요 (아파치)
    ex) 아파치 설치 >> 특정 폴더안에(ex webapp안에) >> index.html, login.html , login.css 
           >> 요청>> http://www.it.co.kr/login.html
    >> 아파치 웹서버 >> 요청을 받아서 >> login.html 존재 확인 
          >> 클라이언트에게 전달 >> 받느 클라이언트 웹브라우져 해서 화면 출력(크롬, 파이어폭스 등이 받아서 해석해서 렌더링)
    
    jsp or servlet 사용 (서버로 기술)
    ex) 톰켓(아파치 톰켓 설치) >> 이건 웹서버(아파치) + WAS(톰캣) >> 요청 
            >> http://www.it.co.kr/login.jsp >> 실행 파일 (없어요)(jsp자체는 실행파일이 아니다..) >>
        jsp 컴파일 함 >> class 파일 생성 
            >> class 파일 실행-> 메모리에 올림(HTML 정적 데이터 + 서버코드 실행>동적데이터>서버코드 실행해서 만든 결과 Text)
        >>결과된 결과(클라이언트 웹 브라우져가 해서 가능한 파일로 만들어서) 
            >> 전달(응답 : response)
    
    WAS > jsp요청(메모리에 있나봄.. 없으면 컴파일) > compile(login.jsp.java) > 실행(login.jsp.class) 
            > 실행 (정적+동적) > 응답
    

    상식 퀴즈)
    asp(MS꺼), aspx (MS꺼), php, jsp 공통점은 무엇일까? 
    코드 노출이 안되요 >> 보안에 좋아요 >> 클라이언트는 실행 결과만 보아요 (text 또는 html 형태로)
    (php가 가장빠르다
            php가 템플릿이 가장 많다고.. 단점은 기업환경에는 맞지 않다고..)
    
    서버 오픈 (2023 05 18 12:00)
    홍길동 최초 요청자 >> http://www.it.or.kr/default.jsp 
    최초 요청이라서 default.jsp이게 메모리에 아직 없다(.class파일이 있는지 확인 -> 없으면 컴파일)
        -> WAS (처음 , 기존 실행적이 있는지)
    처음(실행파일이 없어요) > 컴파일 > class 만들고 > 실행 > 정적+동적 결합 > 서비스
    
    길동 두번쨰 요청자 >> http://www.it.or.kr/default.jsp -> WAS (처음 , 기존 실행적이 있는지)
    >> 실행파일 존재 (실행) >> 정적 + 동적 결합 > 서비스
    
    최초요청은 컴파일필요해서 느리지만 다음 요청부터는 바로 실행만해서 빨라짐
    
    질문) jsp 다시 컴파일하고 실행파일이 만들어지는 언제일까? 
    1. 개발자가 코드 수정 배포했을때 다시 컴파일(서버가 알아서 함)
    2. 웹 서버를 재시작했을때(메모리에 있던거 날아가기 때문에 다시 컴파일함)
    
    이 경우를 제외하고는 2번째 요청부터는 계속 재사용 함.
    
    질문) 
        2025년 현재 JSP가 UI에 사용이 될까? 신규 프로젝트에?
                -> 사용하지 않음, 전자정부프레임워크에서도 바꾸고 있다.
          -> 그럼 이제 뭘 쓸까?
                  -> 타임리프(html), 머츠테치(html), 프리마커
                  -> MPA방식(멀티페이지.. 서버가 모든페이지를 다 가지고 있음)
                  
        <-> 반대개념은 SPA(싱글페이지, 리액트, 뷰) -> 서버는 데이터만 제공(서버역할 축소)
        지금은 클라이언트 환경이 좋아서.. 인터넷도 좋아져서 SPA로 바뀌고 있다.
*/
%>

<%
/*
자바코드 사용 영역
JSP의 구성요소
1. 선언부  @page language="java" -> page 지시자를 통한 작업
    -> 사용 언어, 인코딩, import등 
    ex) @page import="java.util.Date"
2. 스크립트 요소
2.1 스크립트 릿 <% 안에 자바코드 사용할 수 있는 영역
2.2 표현식(출력하는 방법) , 출력대상은 클라이언트의 브라우저.

*/
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>