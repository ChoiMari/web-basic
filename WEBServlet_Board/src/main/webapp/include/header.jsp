<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

		<div id="header">
            <div class="title">
                <!-- 현재 웹 애플리케이션의 컨텍스트 경로(Context Path)를 반환
                    절대 경로.. /WEBServlet_Board 
                    request.getContextPath()와 같음(EL표현식으로 바꾼것) -->
                <a href="${pageContext.request.contextPath}">DEMO WEBSITE</a>
            </div>
            <div class="links">
                <a href="#">${pageContext.request.contextPath}</a>
                <a href="#">추후등록</a>
                <a href="#">추후로그아웃</a>

            </div>
        </div>        
        <div id="menu">
            <div>
                <ul>
                	<!-- a : 페이지 이동을 처리하는 마크업 -->
                    <li><a href="board_list.do">BOARD LIST</a></li>
					<li><a href="board_write.do">BOARD WRITE</a></li>
					<li><a href="#"></a></li>
					<li><a href="#"></a></li>
                </ul>
            </div>
        </div>
        <div style="text-align:right;margin-top:1px;
        	border:solid 1px;padding:5px">
        	[ TOTAL : 명 ]
        	[ CURRENT : 명 ]
        </div>
        
        
        
        
        
        
        
        
        
        
        
        