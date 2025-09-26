<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    // 컨텍스트 경로를 동적으로 가져와서 list.do로 리다이렉트
    String ctx = request.getContextPath();
    response.sendRedirect(ctx + "/list.do");
%>