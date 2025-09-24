<%@page import="java.sql.Connection"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%--
    DBCP = 커넥션 풀
        -> 미리 연결을 생성해놓고, 사용하고 반환함
        은행 번호표.. 사람이 많으면 미리 뽄아서 들고 있다가 나눠줌.. 이런거와 비슷한 개념
    커넥션 풀 종류가 많지만 -> 히카리 풀이 가장 현재까지는 성능이 좋다.
    
    지금은 연습.. 아파치 톰캣이 제공하는 pool사용해봄..
    tomcat-dbcp.jar사용
    
    기본적으로 context.xml파일의 설정을 가져와서 사용함
        1. 톰캣이 가지고 있는 context.xml에 설정하는 방법(서버 전체에 적용됨)
        2. 프로젝트 단위로 설정하는 방법(각각의 프로젝트에서 설정하는법)
            context.xml을 복사해서 META-INF안에 넣음
            프로젝트 마다 다른 풀 사용가능
            
        JNDI? 자바 네이밍 앤드 디렉토리 인터페이스
            파일 탐색기의 검색하기와 비슷함
            파일 탐색기 처럼 특정 단어 넣으면 그 단어가 있는 파일을 찾아준다
        -> 자바도 특정 xml이나 파일을 검색하고 찾을 수 있다.
        그걸 쓰기 위해서는 자바는..
 --%>
 <%
    Context context = new InitialContext();
 //프로젝트에서 찾는다...
 //현재 프로젝트에서 이름으로 검색하겠다.
    DataSource ds = (DataSource)context.lookup("java:comp/env/jdbc/oracle"); // 엑셀의 lookup과 비슷함
    // 약속된 표현은  java:comp/env/ 
    // jdbc/oracle 이건 리소스 태그의 name 프로퍼티값( context.xml에 설정한 값)
    // context.xml에 설정한 값
    //데이터를 연결하는 리소스
    //type="javax.sql.DataSource" 데이터 소스 객체로 만들어 진다고 함
    // 그래서 그 객체로 리턴 받아서 담음, 내부적으로는 오브젝트라서 다운 캐스팅 필요함
   
    // 웹서버 메모리 가게 오픈 한것과 같음(튜브가게의 미리 만들어둔 튜브는 20개로 설정해둠)
    // conn(커넥션 객체) 빌려 쓰고 다쓰면 반환함
    // 스프링도 다 히카리풀쓴다.
    
    Connection conn = null;
    conn = ds.getConnection();
    //가게 빌려주세요 - 가게는 ds
    //빌리기 getConnection()
    
    out.print("DB연결 여부 확인(false나와야함)" + conn.isClosed() + "<br>");
    //false나오면 DB가지고 놀수있음
    // CRUD 구현 코드 사용
    //쓴다음 **반드시 반환**해야함
    //반환 - 메서드로
    //메서드 내에서 사용하고 반환까지 해야 OK
    
    //반환
    conn.close();//-> 여기서 close()는 DBCP(커넥션 풀)에서는 자원해제가 아니고
    // 반환하는 것! -> pool에게
    
    out.print("DB연결 여부 확인(true나와야함)" + conn.isClosed() + "<br>");
    //isClosed() 너 닫혔니?
            
            //->이걸 매번 메서드에서 사용하기 불편
            //-> 유틸의 ConnectionPoolHelper로 간단하게 만듬
 /* 
 //context.xml 파일에...설정한 내용
     <Resource maxWait="-1" 
        maxIdle="20" 
        maxTotal="20"
        maxActive="20"
        password="1004" 
        username="KOSA" 
        url="jdbc:oracle:thin:@localhost:1521:XE"
        driverClassName="oracle.jdbc.OracleDriver" 
        type="javax.sql.DataSource"
        auth="Container" 
        name="jdbc/oracle" />
 
 
 */
 %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>