<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/top.jsp"%>
<h3>Department List</h3>
<div class="text-end mb-2">
	<a class="btn btn-primary"
		href="${pageContext.request.contextPath}/dept/write.do">신규등록</a>
</div>
<table class="table table-striped">
	<thead>
		<tr>
			<th>DEPTNO</th>
			<th>DNAME</th>
			<th>LOC</th>
			<th></th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${list}" var="d">
			<tr>
				<td>${d.deptno}</td>
				<td>${d.dname}</td>
				<td>${d.loc}</td>
				<td><a class="btn btn-sm btn-outline-secondary"
					href="${pageContext.request.contextPath}/dept/view.do?deptno=${d.deptno}">보기</a>
				</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
<%@ include file="/WEB-INF/views/common/bottom.jsp"%>