<%@page import="kr.or.kosa.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- <%@ page import="com.example.model.MemberDTO" %> --%>
<%
    MemberDTO user = (MemberDTO) session.getAttribute("user");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>메인 페이지</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body { padding-top: 5rem; }
        .main-container { max-width: 960px; }
        .nav-link { cursor: pointer; }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-md navbar-dark bg-dark fixed-top">
        <a class="navbar-brand" href="#">권한 처리 예제</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item"><a class="nav-link" href="/index.jsp">홈</a></li>
                <li class="nav-item"><a class="nav-link" href="/commonPage.jsp">일반 사용자/관리자 페이지</a></li>
                <li class="nav-item"><a class="nav-link" href="/userPage.jsp">일반 사용자 페이지</a></li>
                <li class="nav-item"><a class="nav-link" href="/adminPage.jsp">관리자 페이지</a></li>
            </ul>
        </div>
    </nav>

    <main role="main" class="container main-container">
        <div class="jumbotron">
            <h1>MVC 패턴 기반 권한 처리</h1>
            <p class="lead">로그인 상태에 따라 접근 가능한 페이지가 달라집니다.</p>

            <% if (user == null) { %>
                <!-- 로그인 폼 -->
                <form action="/member/login" method="post" class="form-signin mt-4">
                    <h2 class="form-signin-heading">로그인</h2>
                    <label for="inputId" class="sr-only">아이디</label>
                    <input type="text" id="inputId" name="id" class="form-control mb-2" placeholder="아이디 (admin 또는 user)" required autofocus>
                    <label for="inputPassword" class="sr-only">비밀번호</label>
                    <input type="password" id="inputPassword" name="pw" class="form-control mb-3" placeholder="비밀번호 (1234)" required>
                    <button class="btn btn-lg btn-primary btn-block" type="submit">로그인</button>
                </form>
            <% } else { %>
                <!-- 로그인 성공 정보 -->
                <div class="alert alert-success mt-4" role="alert">
                    <h4 class="alert-heading">환영합니다, <%= user.getName() %>님!</h4>
                    <p>당신의 권한은 '<strong><%= user.getRole() %></strong>' 입니다.</p>
                    <hr>
                    <p class="mb-0">이제 권한에 맞는 페이지에 접근할 수 있습니다.</p>
                </div>
                <a href="/member/logout" class="btn btn-lg btn-danger btn-block">로그아웃</a>
            <% } %>

            <div class="mt-4">
                <h5>테스트 계정 정보</h5>
                <ul>
                    <li>관리자: id(admin), pw(1234)</li>
                    <li>일반사용자: id(user), pw(1234)</li>
                </ul>
            </div>
        </div>
    </main>

    <!-- jQuery and Bootstrap Bundle (includes Popper) -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
