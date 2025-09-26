<%@page import="kr.or.kosa.dto.Emp"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    //CORS 정책
    //다른 주소(URL)에 대해 허락하지 않는다
    //동일주소 다 허락
   response.addHeader("Access-Control-Allow-Origin", "*"); //모든 주소의 접근 허용
//파라미터 2가지 
//Ex09_Client_gson.html에서 
// url:"http://192.168.2.229:8090/WebScript_Jquery_Ajax/Ex09_GSON.jsp",
//-> 이 요청주소에서 데이터를 비동기로 받아오는데 
//이 요청주소를 제공해주는 서버에서 CORS설정으로 허용해준
// 오리진(프로토콜+호스트(IP)+포트번호)허용 해준 서버만 접근가능함
//response.addHeader("Access-Control-Allow-Origin", "*"); //모든 주소 허용
//하면 다른 오리진에서 요청해도 허용해줌
//다른 서버에서 url:"http://192.168.2.229:8090/WebScript_Jquery_Ajax/Ex09_GSON.jsp",해도
//이 서버에서 CORS설정 허용안해주면 접근 불가
    
    Class.forName("oracle.jdbc.OracleDriver");
    Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","kosa","1004");
    Statement stmt = conn.createStatement();
    String sql = "select empno , ename , sal , job , comm from emp";
    ResultSet rs = stmt.executeQuery(sql);
    
    List<Emp> list = new ArrayList<Emp>();
    while(rs.next()) {
        Emp emp = new Emp();
        emp.setEmpno(rs.getInt("empno"));
        emp.setEname(rs.getString("ename"));
        emp.setSal(rs.getInt("sal"));
        emp.setJob(rs.getString("job"));
        emp.setComm(rs.getInt("comm"));
        list.add(emp);
    }
    
    rs.close();
    stmt.close();
    conn.close();
    
    //2줄 
    //[{empno:7788,ename:"SMITH"}]  
    Gson gson = new Gson();
    String jsonlist = gson.toJson(list);
%>    
<%=jsonlist%>