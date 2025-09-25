<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
/*
    servlet으로 할땐
    out.print("<html>"); 사용
    
    jsp도 out을 활용하면 스파게티 코드를 좀 벗어날 수 있다고..
*/
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
    <h3>스파게티 코드 (UI)</h3>
    <%
        boolean b = true;
        if(10 > 5){
    %> 
        if(true)<font color="red"><%=b%></font>
    <%      
        }else{
            b = false;
    %>
        if(false)<font color="blue"><%=b%></font>
    <%      
        }
    %>
    
    <h3>out객체 (서버코드 작업 : servlet 에서 화면... jsp 없던 시절에 servlet 있던 시절)</h3>
    <% // 단점 - 자동완성 못함.. html을 문자열로 작성해야함
        boolean b2 = true;
        if(10 > 5){
            out.print("if(true)<font color='red'>" + b2 + "</font>");
        }else{
            b2 = false;
        	out.print("if(false)<font color='red'>" + b2 + "</font>");
        }
        // 결론 - jsp는 이런거 안한다..
        // => jsp는 데이터 출력만 담당
    %>
</body>
</html>