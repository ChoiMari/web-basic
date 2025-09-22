<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page buffer="8kb" autoFlush="true" %>    
<%
    /* 
        JAVA : IO > buffer > default 8kb > 
        비워지는 시점 : 
            1. 8kbyte(채워지면)  
            2. 강제 출발(flush (close()))

        기본적으로 JSP 페이지도
        설정을 강제하지 않으면 
        기본값
        buffer="8kbyte" autoFlush="true" 버퍼가 다 채워지면 내보낸다.
        jsp도 이런 설정을 기본으로 가지고 있다.
        웹페이지 요청이 들어오면 페이지 내용을 부분적으로 담아서 서비스 한다.
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
            for(int i = 0 ; i < 10 ; i++){
                out.print("<b>" + i + "<b><br>");
            }
        %>
</body>
</html>