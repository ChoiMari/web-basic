<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="/header.jsp"/>
	<div style="margin: 100px;">
		<form action="${pageContext.request.contextPath}/memoupdateok.do?id=${requestScope.memoupdate.id}"
			method="post">
			<div class="mb-3">
				<label for="formGroupExampleInput" class="form-label">ID</label> 
				<input
					value="${requestScope.memoupdate.id}" readonly
					type="text" class="form-control" name="id" placeholder="id입력"
					required="required">
			</div>
			<div class="mb-3">
				<label for="formGroupExampleInput" class="form-label">EMAIL</label>
				<input value="${requestScope.memoupdate.email}" type="text" class="form-control" name="email"
					placeholder="email입력" required="required">
			</div>
			<div class="mb-3">
				<label for="formGroupExampleInput" class="form-label">CONTENT</label>
				<input value="${requestScope.memoupdate.content}" type="text" class="form-control" name="content"
					placeholder="content 입력" required="required">
			</div>
			<div class="col-12">
				<button type="submit" class="btn btn-primary">수정하기</button>
			</div>
			<div class="col-12">
				<button onclick="location.href = 'memolist.do'" type="button"
					class="btn btn-light">취소</button>
			</div>
		</form>
	</div>

</body>
</html>