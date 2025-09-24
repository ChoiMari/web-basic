<%-- 4. emp_update.jsp - 사원 수정 페이지 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>사원 정보 수정</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .form-container { max-width: 500px; margin: 0 auto; }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; font-weight: bold; }
        input[type="text"], input[type="number"], input[type="date"] { 
            width: 100%; padding: 8px; border: 1px solid #ddd; border-radius: 4px; 
        }
        input[readonly] { background-color: #f8f9fa; }
        button { background-color: #007bff; color: white; padding: 10px 20px; 
                border: none; border-radius: 4px; cursor: pointer; }
        button:hover { background-color: #0056b3; }
        .btn-secondary { background-color: #6c757d; }
        .btn-secondary:hover { background-color: #545b62; }
    </style>
</head>
<body>
    <jsp:include page="/header.jsp" />
    <br>
    <br>
    <br>
    <div class="form-container">
        <h1>사원 정보 수정</h1>
        
        <c:if test="${not empty empupdate}">
            <form action="empupdateok.do" method="post">
                <div class="form-group">
                    <label for="empno">사원번호</label>
                    <input type="number" id="empno" name="empno" value="${empupdate.empno}" readonly>
                </div>
                
                <div class="form-group">
                    <label for="ename">사원명</label>
                    <input type="text" id="ename" name="ename" value="${empupdate.ename}" required>
                </div>
                
                <div class="form-group">
                    <label for="job">직책</label>
                    <input type="text" id="job" name="job" value="${empupdate.job}" maxlength="9" required>
                </div>
                
                <div class="form-group">
                    <label for="sal">급여</label>
                    <input type="number" id="sal" name="sal" value="${empupdate.sal}" required>
                </div>
                
                <button type="submit">수정 완료</button>
                <button type="button" class="btn-secondary" onclick="location.href='empdetail.do?empno=${empupdate.empno}'">취소</button>
            </form>
        </c:if>
        
        <c:if test="${empty empupdate}">
            <p>수정할 사원 정보를 찾을 수 없습니다.</p>
            <button class="btn-secondary" onclick="location.href='emplist.do'">목록으로 돌아가기</button>
        </c:if>
    </div>
</body>
</html>