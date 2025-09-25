<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 
    공통 페이지를 만들고 싶음
    jsp : include 현재 페이지에 공통의 페이지를 붙일 수 있다
    
    .master파일 -> C# , 공통 미리 만들어놓고 바뀌는부분만 체인지
 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
    <b>SITE MAIN PAGE 상단</b>
    <br><!-- 공통페이지 설정 -->
        <jsp:include page="/common/sub.jsp"></jsp:include>
    <br>
    <b>SITE MAIN PAGE 하단</b>
</body>
</html>