<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="/header.jsp" />

	<div class="card" style="margin:10rem;">
		<div class="card-body">
			ID <h5 class="card-title">${requestScope.memodetail.id}</h5>
			<hr>
			EMAIL <p class="card-text">${requestScope.memodetail.email}</p>
			<hr>
			CONTENT <p class="card-text">${requestScope.memodetail.content}</p>
			<a class="btn btn-primary" href="memodelete.do?id=${requestScope.memodetail.id}">삭제하기</a>
		<a class="btn btn-primary" href="memoupdate.do?id=${requestScope.memodetail.id}">수정하기</a>
		</div>
	</div>
</body>
</html>