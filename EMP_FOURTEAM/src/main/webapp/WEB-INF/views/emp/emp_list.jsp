<%-- 3. emp_list.jsp - 사원 목록 페이지 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>사원 목록</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .list-container { max-width: 1000px; margin: 0 auto; }
        .header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
        .emp-table { width: 100%; border-collapse: collapse; }
        .emp-table th, .emp-table td { 
            padding: 12px; text-align: left; border-bottom: 1px solid #ddd; 
        }
        .emp-table th { background-color: #f8f9fa; font-weight: bold; }
        .emp-table tr:hover { background-color: #f5f5f5; }
        button { background-color: #007bff; color: white; padding: 5px 10px; 
                border: none; border-radius: 4px; cursor: pointer; }
        button:hover { background-color: orange; }
        .btn-success { background-color: #28a745; }
        .btn-success:hover { background-color: #218838; }
        .btn-link { background: none; color: #007bff; text-decoration: underline; 
                   border: none; padding: 0; cursor: pointer; }
        .btn-link:hover { color: #0056b3; }
    </style>
</head>
<body>
    <jsp:include page="/header.jsp" />
    <br>
    <br>
    <br>
    <div class="list-container">
        <div class="header">
            <h1>사원 목록</h1>
            <button class="btn-success" onclick="location.href='emp.do'">새 사원 등록</button>
        </div>
        
        <c:if test="${not empty empList}">
            <table class="emp-table">
                <thead>
                    <tr>
                        <th>사원번호</th>
                        <th>사원명</th>
                        <th>직책</th>
                        <th>관리자번호</th>
                        <th>입사일</th>
                        <th>급여</th>
                        <th>커미션</th>
                        <th>부서번호</th>
                        <th>버튼</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="emp" items="${empList}">
                        <tr>
                            <td>${emp.empno}</td>
                            <td>
                                <button class="btn-link" onclick="location.href='empdetail.do?empno=${emp.empno}'">${emp.ename}</button>
                            </td>
                            <td>${emp.job}</td>
                            <c:choose>
                                <c:when test="${emp.mgr == 0}">
                                    <td>&nbsp;&nbsp;</td>
                                </c:when>
                                <c:otherwise>
                                    <td>${emp.mgr}</td>
                                </c:otherwise>
                            </c:choose>

                            <td>${emp.hiredate}</td>
                            <td>${emp.sal}</td>
                            <td>${emp.comm}</td>
                            <td>${emp.deptno}</td>
                            <td>
                                <button onclick="location.href='empupdate.do?empno=${emp.empno}'">수정</button>
                                <button class="btn-danger" onclick="confirmDelete(${emp.empno})">삭제</button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>
        
        <c:if test="${empty empList}">
            <p>등록된 사원이 없습니다.</p>
        </c:if>
    </div>
    
    <script>
        function confirmDelete(empno) {
            if(confirm('정말로 삭제하시겠습니까?')) {
                location.href = 'empdelete.do?empno=' + empno;
            }
        }
    </script>
    
    <style>
        .btn-danger { background-color: #dc3545; color: white; padding: 5px 10px; 
                     border: none; border-radius: 3px; cursor: pointer; margin-left: 5px; }
        .btn-danger:hover { background-color: #c82333; }
    </style>
</body>
</html>