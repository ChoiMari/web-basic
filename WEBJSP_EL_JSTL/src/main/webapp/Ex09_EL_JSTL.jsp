<%@page import="DTO.Dept"%>
<%@page import="java.util.List"%>
<%@page import="DAO.DeptDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    //servlet요청을 받아서 DB작업이 필요하다 판단. DeptDao실행
    //그 결과를 다시 가져와서 view역할을 하는 jsp에서 화면에 출력하도록 전달
    
    DeptDao dao = new DeptDao();
    List<Dept> dept = dao.getDeptList();
    
    //현재페이지에서만 필요하면 요청객체에 담음
    request.setAttribute("deptList", dept);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
   <div class="container">
    <table> 
        <thead>
           <tr>
              <th>deptno</th>
              <th>dname</th>
              <th>loc</th>
           </tr>
        </thead>
        <tbody>
            <c:forEach var="dept" items="${requestScope.deptList}">
                <tr>
                    <td>${dept.deptno}</td>
                    <td>${dept.dname}</td>
                    <td>${dept.loc}</td>
                </tr>
            </c:forEach>                        
        </tbody>
     </table>   
   </div>
   
</body>
<style>
    .container {
       width: 100vw;
       height: 100vh;
       display: flex;
       align-items : center;
       justify-content: center;
       
    }
    
    table {
      border-collapse: collapse;
      width: 50vw;
    }
    
    th, td {
      padding-top : 2vh;
      padding-bottom: 2vh;
      text-align: center;
    }
    
    tbody > th, td {
      border-bottom: 1px solid #444444;
    }
    
    thead {
      background-color: #D5DEDC;
      color: #5F7065;
    }
</style>
</html>