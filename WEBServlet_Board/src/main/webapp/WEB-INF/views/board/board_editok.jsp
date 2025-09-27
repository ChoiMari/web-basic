<%@page import="kr.or.bit.service.BoardService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:if test="${empty requestScope.idx || empty fn:trim(idx)}">
    <script>
        alert('글번호 입력 오류');
        location.href='board_list.do;
    </script>
</c:if>
<jsp:forward page="/WEB-INF/views/board/redirect.do"></jsp:forward>