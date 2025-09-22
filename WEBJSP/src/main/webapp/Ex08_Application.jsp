<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
/*  
        webproject 생성 >> Template 구조 >> WEB-INF >> web.xml 제공 (웹어플리케이션 전체 환경설정)
        
        WEB-INF : 클라이언트 쪽에서 접근 불가. 보안 폴더
            WEB-INF 폴더 안에 있는 페이지는 서버 내에서는 가능
        
        web.xml (서버가 시작되면 제일 loading 되고 해석되고 실행, 이 파일에 에러가 있으면 서버가 뜨지도 않는다) 
        -> web.xml은 환경설정파일
        -> 클라이언트가 보면 안됨. 그래서 WEB-INF밑에 들어감
        <welcome-file>index.htm</welcome-file> 웹 사이트 기본 페이지 설정 
        ex) http://192.168.0.42:8090/WEBJSP/ 엔터  하면 > 페이지 서비스 > default 페이지 구성 ....
        
        /WebJSP  >> 웹 프로젝트 이름 , 가상 디렉토리 , context root (문맥 , 흐름 , 전체)
        웹 경로 (가상경로) : http://192.168.0.42:8090/WebJSP
        >>실경로 : D:\Duzon\Web\WebBack\WebLabs\WebJSP\src\main\webapp 안에 자원을 서비스 하겠다
        
        -> 난 C:\MSA_EDU\WEB\WebBackEnd\BackEndLabs\WEBJSP\src\main\webapp -> 실소스
        
        C:\MSA_EDU\WEB\WebBackEnd\BackEndLabs\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\WEBJSP
        -> 이게 배포 경로 -> 이걸 서비스(동기화), 가끔 동기화가 안될 때가 있음
        -> 파일 업로드시에 배포경로 확인
        
        실소스경로와 배포경로가 다르다.
        배포 경로는 이클립스가 톰캣을 내장하고 있음. 
        나중에 실 운영 시에는 클라우드 사용하니까.. 의미는 없음
        스프링부트는 톰캣이 내장되어있음 -> .jar 배포하면됨
        .war파일은 jsp사용하는 경우 사용
        
        C:\MSA_EDU\WEB\WebBackEnd\BackEndLabs\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\work\Catalina\localhost\WEBJSP\org\apache\jsp
        이 경로는 .jsp 컴파일해서 배포파일의 실 경로
        
        서비스 자원 : html, htm , css , js , json , txt , jsp 
        
        >>생성하는 모든 자원은 scope 
        >> a.jsp >  <% String s ="A"    >> s변수는 a.jsp 안에서만 유효
        >> b.jsp >  <% String s ="A"    >> s변수는 b.jsp 안에서만 유효
        >> c.jsp >  <% String s ="A"    >> s변수는 c.jsp 안에서만 유효
        
        a.jsp , b.jsp , c.jsp 페이지에서 공유하는 자원은 ?
        답이 web.xml 환경설정 > 서버 시작 > 가장 해석(loading)
        
        
        <context-param>
            <description>개발자 마음...</description>
            <param-name>email</param-name>
            <param-value>kosa@kosa.or.kr</param-value>
        </context-param>
        
        web.xml 자원에 접근 방법
        Appliction 객체 (WAS 제공)
        Appliction >> web.xml 접근 >> 자원 read 가능 
        
        
        WebApp 생성 >> WEB-INF 제공받아요 >> lib (jar파일)
                                      >> web.xml (환경설정파일)
        **WEB-INF 보안폴더 : Client 접근하게 되면 없는 페이지를 리턴 (접근 불가)
        
        **http://192.168.0.42:8090/WebJSP/WEB-INF/web.xml 엔터  서버는 404 전달
        
        **WEB-INF >> views >> member >> register.jsp 등등
                           >> admin  >> admin.jsp
        클라이언트 직접 보아서는 안되는 페이지는 보안폴더에 숨김 ....^^
        ** 서버 내부에서 서로 read  할 수 있다 ...
        include , forward 이런 방식으로 ....보여주어요....
        
        http://localhost:8090/WEBJSP/WEB-INF/views/admin/admin.jsp  접근 불가 (404 file not found )
*/
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
    <h3>web.xml 설정된 전역 자원을 read (Application객체)</h3>
    <%
        String param = application.getInitParameter("email");
        out.print("<h3>" + param + "</h3>");
        
        out.print("<hr>");
        
        String param2 = application.getInitParameter("filePath");
        out.print("<h3>" + param2 + "</h3>");
    
    %>
</body>
</html>
​