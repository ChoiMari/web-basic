<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>부서별 사원 조회</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>

<h2>부서별 사원 조회</h2>

<!-- 부서 선택 -->
<select id="deptSelect">
    <option value="">부서를 선택하세요</option>
</select>

<!-- 사원 테이블 -->
<table border="1" id="empTable">
    <thead>
        <tr>
            <th>사번</th>
            <th>이름</th>
            <th>급여</th>
            <th>입사일</th>
            <th>부서번호</th>
            <th>부서명</th>
        </tr>
    </thead>
    <tbody>
    </tbody>
</table>

<script>
$(document).ready(function() {
    // 1. 페이지 로드 시 부서 목록 비동기 가져오기
    $.ajax({
    url: '${pageContext.request.contextPath}/DeptListAjax',
    method: 'GET',
    dataType: 'json',
    success: function(data) {
        data.forEach(function(dept) {
        	//console.log(data); 
        	$('#deptSelect').append(
                    '<option value="' + dept.deptno + '">' + dept.dname + '</option>'
                );
        });
    },
    error: function() {
        alert('부서 목록을 가져오는데 실패했습니다.');
    }
});


    // 2. 부서 선택 시 사원 목록 가져오기
    $('#deptSelect').change(function() {
        var deptno = $(this).val();
        if(!deptno) {
            $('#empTable tbody').html('');
            return;
        }
        $.ajax({
            url: '${pageContext.request.contextPath}/EmployeeByDeptAjax',
            method: 'GET',
            data: { deptno: deptno },
            dataType: 'json',
            success: function(data) {
            	console.log(data);
                var html = '';
                data.forEach(function(emp) {
                    html += '<tr>' +
                                '<td>' + emp.empno + '</td>' +
                                '<td>' + emp.ename + '</td>' +
                                '<td>' + emp.sal + '</td>' +
                                '<td>' + emp.hiredate + '</td>' +
                                '<td>' + emp.deptno + '</td>' +
                                '<td>' + emp.dname + '</td>' +
                            '</tr>';
                });
                $('#empTable tbody').html(html);
            },
            error: function() {
                alert('사원 목록을 가져오는데 실패했습니다.');
            }
        });
    });
});
</script>

</body>
</html>