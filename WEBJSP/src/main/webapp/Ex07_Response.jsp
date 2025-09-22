<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    /*  
        웹 환경(Client - Server)
        
        Client -> Server (요청된 정보를 requset 객체를 생성해서 그 안에 정보를 담고 사용)
             요청(request)
             
        Server -> Client (response 응답 > 서버 자원 
                > Client 전달(클라이언트 브라우져 해석 가능 자원))
             응답(response)
        
        클라이언트 브라우져(크롬 , IE) 해석 : html , css , javscript , text , xml , json , img)밖에 해석을 못한다
           그래서 이런 형태로만 전송해야함
    

        response  객체 
        1. 표현식 (출력)  <%=
        2. 페이지 이동 (response.sendRedirect()) : 서버에게 새로운 페이지 요청 ...
        2.1 javascript 표현 :  location.href="이동할 주소"
        2.2 브라우져에서 F5 새로고침과 같은 효과 ()
        
        자바의 response.sendRedirect()와 
        자바스크립트의 location.href="이동할 주소" 코드와 같다
        리다이렉트(페이지 이동)
    */

%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
        1. 일반적인 출력담당 <%= 100+200+300 %><br>
        2. sendRedirect 
        <% //Ex01_index.jsp페이지로 리다이렉트됨
            //response.sendRedirect("Ex01_index.jsp"); //   나 이 페이지 Ex01_index.jsp 보여줘
        %>
</body>
    <script type="text/javascript">
         location.href="Ex01_index.jsp"; 
         //response.sendRedirect("Ex01_index.jsp");와 같은 원리
    </script>
</html>