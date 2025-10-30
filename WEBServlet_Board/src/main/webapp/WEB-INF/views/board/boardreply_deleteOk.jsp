<%@page import="kr.or.bit.service.BoardService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:choose>
    <c:when test="${empty idx_fk || empty no || empty pwd || empty fn:trim(no)}">
        <script type="text/javascript">
        	history.back();
    	</script>
    </c:when>
    <c:otherwise>
        <jsp:forward page="/WEB-INF/views/board/redirect.do"></jsp:forward>
    </c:otherwise>
</c:choose>











