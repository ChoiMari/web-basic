<%-- 2. emp_detail.jsp - 사원 상세보기 페이지 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>사원 상세보기</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .detail-container { max-width: 600px; margin: 0 auto; }
        .detail-table { width: 100%; border-collapse: collapse; margin: 20px 0; }
        .detail-table th, .detail-table td { 
            padding: 12px; text-align: left; border-bottom: 1px solid #ddd; 
        }
        .detail-table th { background-color: #f8f9fa; font-weight: bold; width: 150px; }
        .btn-group { margin-top: 20px; text-align: center; }
        button { background-color: #007bff; color: white; padding: 10px 20px; 
                border: none; border-radius: 4px; cursor: pointer; margin: 0 5px; }
        button:hover { background-color: #0056b3; }
        .btn-warning { background-color: #ffc107; color: #000; }
        .btn-warning:hover { background-color: #e0a800; }
        .btn-danger { background-color: #dc3545; }
        .btn-danger:hover { background-color: #c82333; }
        .btn-secondary { background-color: #6c757d; }
        .btn-secondary:hover { background-color: #545b62; }
    </style>
</head>
<body>
    <jsp:include page="/header.jsp"/>
    <div class="detail-container">
        <h1>사원 상세보기</h1>
        
        <c:if test="${not empty empdetail}">
            <table class="detail-table">
                <tr>
                    <th>사원번호</th>
                    <td>${empdetail.empno}</td>
                </tr>
                <tr>
                    <th>사원명</th>
                    <td>${empdetail.ename}</td>
                </tr>
                <tr>
                    <th>직책</th>
                    <td>${empdetail.job}</td>
                </tr>
                <tr>
                    <th>관리자번호</th>
                    <c:choose>
                        <c:when test="${emp.mgr == 0}">
                            <td>&nbsp;&nbsp;</td>
                        </c:when>
                        <c:otherwise>
                            <td>${emp.mgr}</td>
                        </c:otherwise>
                    </c:choose>
                </tr>
                <tr>
                    <th>입사일</th>
                    <td>${empdetail.hiredate}</td>
                </tr>
                <tr>
                    <th>급여</th>
                    <td>${empdetail.sal}</td>
                </tr>
                <tr>
                    <th>커미션</th>
                    <td>${empdetail.comm}</td>
                </tr>
                <tr>
                    <th>부서번호</th>
                    <td>${empdetail.deptno}</td>
                </tr>
            </table>
            
            <div class="btn-group">
                <button class="btn-warning" onclick="location.href='empupdate.do?empno=${empdetail.empno}'">수정</button>
                <button class="btn-danger" onclick="confirmDelete(${empdetail.empno})">삭제</button>
                <button class="btn-secondary" onclick="location.href='emplist.do'">목록</button>
            </div>
        </c:if>
        
        <c:if test="${empty empdetail}">
            <p>사원 정보를 찾을 수 없습니다.</p>
            <button class="btn-secondary" onclick="location.href='emplist.do'">목록으로 돌아가기</button>
        </c:if>
    </div>
    
    <script>
        function confirmDelete(empno) {
            if(confirm('정말로 삭제하시겠습니까?')) {
                location.href = 'empdelete.do?empno=' + empno;
            }
        }
    </script>
</body>
</html>