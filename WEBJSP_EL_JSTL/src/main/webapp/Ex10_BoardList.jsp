<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>게시판 목록</title>
    <style>
        table { border-collapse: collapse; width: 600px; margin: 20px auto; }
        th, td { border: 1px solid #ccc; padding: 8px; text-align: center; }
        th { background: #f2f2f2; }
    </style>
</head>
<body>
<h2 style="text-align:center;">게시판 목록</h2>
<table>
    <thead>
        <tr>
            <th>번호</th>
            <th>제목</th>
            <th>작성자</th>
            <th>작성일</th>
            <th>조회수</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="board" items="${boardList}">
            <tr>
                <td>${board.id}</td>
                <td>
                    <a href="detail.do?id=${board.id}">${board.title}</a>
                </td>
                <td>${board.writer}</td>
                <td>${board.regdate}</td>
                <td>${board.hit}</td>
            </tr>
        </c:forEach>
        
        <!-- 게시글이 없을 경우 -->
        <c:if test="${empty boardList}">
            <tr>
                <td colspan="5">등록된 게시물이 없습니다.</td>
            </tr>
        </c:if>
    </tbody>
</table>
</body>
</html>