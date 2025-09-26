<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    //http://localhost:8090/WebScript_Ajax/Ex06_Server_Param.jsp?no=2
    int no = Integer.parseInt(request.getParameter("no"));
    String strex="";
    String[][] strArray = {
            {"컴퓨터","노트북","태블릿"},
            {"java","jquery","oracle"},
            {"AA","BB","CC"}
    };
    for(int i = 0 ; i < strArray.length ; i++){
        if(i < strArray.length -1){
            strex+=strArray[no][i] + ",";
        }else{
            strex+=strArray[no][i];
        }
        
    }
%>    
<%=strex%>