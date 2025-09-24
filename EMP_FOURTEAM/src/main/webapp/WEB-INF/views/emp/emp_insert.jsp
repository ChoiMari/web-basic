<%-- 1. emp_insert.jsp - 사원 등록 페이지 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>사원 등록</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .form-container { max-width: 500px; margin: 0 auto; }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; font-weight: bold; }
        input[type="text"], input[type="number"], input[type="date"] { 
            width: 100%; padding: 8px; border: 1px solid #ddd; border-radius: 4px; 
        }
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
        <h1>사원 등록</h1>
        <form action="empinsert.do" method="post">
            <div class="form-group">
                <label for="empno">사원번호</label>
                <input type="number" id="empno" name="empno" required>
            </div>
            
            <div class="form-group">
                <label for="ename">사원명</label>
                <input type="text" id="ename" name="ename" required>
            </div>
            
            <div class="form-group">
                <label for="job">직책</label>
                <input type="text" id="job" name="job" required>
            </div>
            
            <div class="form-group">
                <label for="mgr">관리자번호</label>
                <input type="number" id="mgr" name="mgr">
            </div>
            
            <div class="form-group">
                <label for="sal">급여</label>
                <input type="number" id="sal" name="sal" required>
            </div>
            
            <div class="form-group">
                <label for="comm">커미션</label>
                <input type="number" id="comm" name="comm">
            </div>
            
            <div class="form-group">
                <label for="deptno">부서번호</label>
                <input type="number" id="deptno" name="deptno" required>
            </div>
            
            <button type="submit">등록</button>
            <button type="button" class="btn-secondary" onclick="location.href='emplist.do'">목록</button>
        </form>
    </div>
</body>
</html>