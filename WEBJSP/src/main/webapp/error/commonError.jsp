<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 
예외 상황이 발생하더라도 특정 페이지가 보여지도록(다른 화면 보여주기)
처리방법 2가지
1. 해당 페이지에서 설정하기 
    page errorPage로 설정
2. 전역적인 방법(여기서는 web.xml에서 설정) - 웹사이트 전체에서 설정
에러페이지는 -> 최종 배포 시점에 설정한다..
 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
    <h3>잠시 네트워크 장애가 발생하였습니다... 잠시후 다시 시도해주세요.</h3>

</body>
</html>