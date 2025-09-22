<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!--  
    정보(자료) 데이터 저장 > 어디에 (where)
    
    웹이라는 환경 관점 : 데이터는 어디에 저장
    
    클라이언트(개인 로컬 PC) : 서버(웹서버(웹서비스가능) or DB서버)
    
    
    어디에 저장(보관)? 
    고민 (기준점) :  보안 (데이터 중요성) , 소멸(일시적 , 영속적)
    
    보안 : 클라이언트 - 서버 중에 -> 서버
    소멸 : 메모리 , 파일 , DB 중 선택
    
    클라이언트 Client (Local PC) : 웹 브라우져
    쿠키는 브라우저의 메모리에 저장하는 쿠키, 파일로 저장하는 쿠키가 있음
    -> 근데 보안에 너무 취약함
    파일 쿠키 만드는 방법? 서버에서 만들어주는거라고.. 소멸타임 
    명시적으로 기간을 설정하면 파일로 만들어주고 아니면 세션으로 만들어진다고(세션 소멸 시 같이 소멸)
    
    1. Cookie (메모리 쿠키 - 파일 쿠키 (local 디스크에 txt 암호화 시켜서 저장 : 소멸타임)
       단점) 크기 제한적 (4096byte) , 보안에 취약함 (사용자가 삭제 가능, 해커 파일 노출 위험)
    2. local storage(key ,value) 형태 > JSON 형태로 read , write
       장점) 크기 , 객체 사용(데이터 : 의미있는 데이터 저장)
    
    Server (웹 서버 (WAS) : 메모리 + 파일(보조) , DB서버)
    1. server memory : 서버 메모리에 주로 올라가는 것은? session 객체 (사이트 접속하는 [사용자]마다 [고유]하게 부여되는 메모리(객체) > 서버 리부팅 , 개발 코드 변경 > 소멸 > 생성
    2. server memory : application 객체 (사이트 접속하는 [모든 사용자]에게 부여되는 메모리(객체) > 서버 리부팅 , 개발 코드 변경 > 소멸 > 생성
    3. server 영속적 : 파일.txt  (관리가 힘들어요)
    4. DB server    : 보안, 영속적인 데이터 관리 >> 비용 >> 클라우드 
-->      
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
        <%
            Cookie mycookie = new Cookie("cname","1004");
            //서버 쿠키 생성
            //Client 전달하지 않았어요
            //서버 -> 클라이언트 (response)
            //cname : Name
            //1004 : value
            // 소멸타임 지정하지 않아서 이건 메모리 쿠키
            // 명시하면 파일 쿠키로 저장됨
            response.addCookie(mycookie); //이 한줄이 클라이언트 브라우저에 저장시키는 코드
            //한줄 Client 에게 write
        %>
        <a href="Ex15_Coolie_Read.jsp">Cookie Read</a>
</body>
</html>