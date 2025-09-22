<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    /*
        URI (Universal Resource Identifier)
        - 인터넷상의 자원을 식별하기 위한 표기법 및 규약
        - URL + URN = URI
        - 인터넷 환경에서 URI는 대부분 URL을 의미, URN은 사용이 제한적
        
        ​URL (Uniform Resource Locator)
        - 물리적인 경로, 즉 자원의 위치 정보를 포함
        - 프로토콜, 도메인, 아이피, 포트 등
        - 컴퓨터로부터 접근 가능한 형태의 자원만 검색될 수 있어 제한적
        - 우리가 흔히 보는 'http://test.com:8090/test.jpg' 형태
        
        ​​URN (Uniform Resource Name)
        - 독립적인 이름을 제공하기 위해 존재
        - 자원에 대해 영속적이고 유일
        - 자원의 위치와는 무관
        - 예를들어 우리나라에서는 주민등록번호가 대표적
        
        ​
        StringBuffer url = request.getRequestURL(); // URL : 전체주소 (프로토콜 + IP + 포트 + 상세경로)
        String uri = request.getRequestURI(); // URI : 프로젝트 이하 경로 (CP + SP)
        String cp = request.getContextPath(); // CP : 프로젝트 명
        String sp = request.getServletPath(); // SP : 패키지 + 파일명
        
        ​
        
        System.out.println("URL : " + url);
        System.out.println("URI : " + uri);
        System.out.println("CP : " + cp);
        System.out.println("SP : " + sp);
        
        ​
        
        ​-----------------------------------------------------------------
        URL : http://192.168.0.12:8090/WebJSP/Ex11_WebApp_RealPath.jsp
        URI : /WebJSP/Ex11_WebApp_RealPath.jsp
        CP : /WebJSP
        SP : /WebJSP/Member/Ex11_WebApp_RealPath.jsp
        
        
        이클립스 톰켓 내장 
        실제 배포 경로 : 실제 서비스 되고 있는 소스는 아래 폴더 소스
        D:\Duzon\Web\WebBack\WebLabs\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\WebJSP
    
    
    */

%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
    String resourcePath = "/download/note.txt";
    out.print(resourcePath + "<br>");
    
    String realContextPath = application.getRealPath(request.getContextPath());   // >>  /WEBJSP
    out.print("getRealPath 실제 경로 : " + realContextPath + "<br>");
    //웹에서의 가상경로 >> 물리적 경로 (서버의 실경로)
    
    //실 웹사이트 배포경로 (소스가 배포된경로 ....)
    //배포가 클라이언트 보는 소스는 바로 여기 .... 
    //C:\inswave\WEB\WebBackEnd\Labs\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\WEBJSP\WEBJSP

    //개발소스 
    //C:\inswave\WEB\WebBackEnd\Labs\WEBJSP\src\main\webapp
    
    //Ctrl  + F11  (이클립스에 내장된 톰켓 서비스 경로 배포까지 실행 ....)
    //이클립스 (개발소스 ) ->  웹서버 배포 -> 이클립스 웹서버(톰켓 내장) -> 경로
    
    StringBuffer url = request.getRequestURL(); //URL  : 전체주소 (프로토콜 + IP + PORT + 상세경로)
    String uri = request.getRequestURI(); //URI  프로젝트 이하경로 (CP + SP)
    String cp = request.getContextPath(); //CP: 프로젝트명 (사이트 이름)
    String sp = request.getServletPath(); //SP: 패키지 + 파일명
    System.out.println("URL : " + url);
    System.out.println("URI : " + uri);
    System.out.println("CP : " + cp);
    System.out.println("sp : " + sp);
    
    /*
    URL : http://localhost:8090/WEBJSP/Ex09_Web_RealPath.jsp
    URI : /WEBJSP/Ex09_Web_RealPath.jsp
    CP : /WEBJSP
    sp : /Ex09_Web_RealPath.jsp
    
    활용 : 
    게시판에서 파일 업로드 사용 .... 웹 경로 (실경로) > FILE  I/O 사용 읽고 쓰기
   
    실제 웹사이트 경로(가상 디렉토리)와 실 배포 경로는 다르다.
    파일 업로드 할 때 리얼패스(실배포경로) 사용
    거기에 파일을 읽고 쓰기
    */
%>
</body>
</html>