<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
    /*  
    [요청에 대한 흐름 제어]
    인크루드 : 내 페이지에서 인크루드를 만나면 다른 페이지를 버퍼에서 채움(읽고) 그러다가
    다시 내 페이지로 다시 가져옴
    
    포워드 : 내 페이지에서 버퍼에 채우다가 포워드를 만나면 버퍼를 지우고 다른 페이지로 채움
    그리고 내 페이지로 다시 안간다. 
    실제 요청 주소는 동일, 나가는 내용은 다를 수가 있음.
    자기 버퍼에 다른 페이지의 내용을 채움
    
    1. include (공통 디자인) > 공통 페이지 만들고(top,bottom)  추가
    2. forward (중계자 : 경찰서 112상황실 통제권한) > 자기코드는 의미가 없어요 > 논리제어 ....
    
    *******************************************************************************
    공통점 : request객체를 공유한다 (^^!)
    *******************************************************************************
    차이점 : 제어권 : include(제어권을 다시 가지고 온다)
                   foward (제어권을 넘겨준다) >> spring 에서 ....(servlet) >>요청마다 다른 서비스
                 ******  POINT) [요청주소]는 [동일]한데 [다른 page]의 내용을 서비스 *******
    ex)
    http://192.168.0.29:8090/WebJSP/_forward.jsp?code=B
    http://192.168.0.29:8090/WebJSP/_forward.jsp?code=C
    요청파라미터에 따라서 보여주는 페이지가 다름
    
    1. 클라이언트가 요청한 page >> _forward.jsp
    2. 클랑이언트가 받는 page 정보는 > A.jsp or  B.jsp or C.jsp
    
    원리: Buffer 주인 > _forward.jsp > Buffer는 _forward 내용을 담아야 하는데
        forward를 만나면 > 주인 배신 > Buffer 비워버리고 > 비워진 Buffer > forward 된 page 내용 
        > Client 서비스 
    
    */
    
    String code = request.getParameter("code");
    String viewUrl = null;
    
    //논리의 흐름 : 요청값에 따라서 다른 페이지의 내용을 서비스 -> 포워드
    if(code.equals("A")){
        viewUrl = "/forward/A.jsp";
    }else if(code.equals("B")){
        viewUrl = "/forward/B.jsp";
    }else if(code.equals("C")){
        viewUrl = "/forward/C.jsp";
    }
    
    //http://localhost:8090/Ex12_forward_main.jsp?code=A    사용되는  buffer > Ex12_forward_main.jsp
    //http://localhost:8090/Ex12_forward_main.jsp?code=B        
%>

<!-- 포워드 : 요청의 주소 바꾸지 않으면서 다른(웹페이지)것을 서비스
요청의 흐름제어로 사용함 -->
<jsp:forward page="<%=viewUrl%>"></jsp:forward>


<!-- 아래 UI 의미가 없다 ... forward 되기 때문에..
자기 버퍼에 다른 페이지의 내용을 채움 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- 아래 내용 읽고 렌더링하지 않음. 의미 없음 -->
        <h3>forward jsp 내용</h3>
        fdsklfdsfsd <!-- 논리의 흐름제어 페이지 -->
    
</body>
</html>