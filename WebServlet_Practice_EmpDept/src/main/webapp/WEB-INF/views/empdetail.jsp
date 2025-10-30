<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <!-- JSTL 및 fmt 태그 라이브러리 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>사원 상세보기</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Malgun Gothic', sans-serif;
            line-height: 1.6;
            background-color: #f8f9fa;
        }
        
        .container {
            max-width: 800px;
            margin: 0 auto;
            padding: 0 20px;
        }
        
        .detail-container {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 2px 15px rgba(0,0,0,0.1);
            margin: 2rem 0;
        }
        
        .detail-title {
            color: #2c3e50;
            font-size: 2rem;
            margin-bottom: 2rem;
            text-align: center;
            border-bottom: 3px solid #3498db;
            padding-bottom: 1rem;
        }
        
        .detail-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }
        
        .detail-item {
            background: #f8f9fa;
            padding: 1.2rem;
            border-radius: 8px;
            border-left: 4px solid #3498db;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }
        
        .detail-item:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        
        .detail-label {
            font-weight: bold;
            color: #2c3e50;
            font-size: 0.9rem;
            margin-bottom: 0.5rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        .detail-value {
            color: #34495e;
            font-size: 1.1rem;
            word-break: break-all;
        }
        
        .detail-value.empty {
            color: #95a5a6;
            font-style: italic;
        }
        
        .btn-group {
            display: flex;
            gap: 1rem;
            justify-content: center;
            margin-top: 2rem;
            padding-top: 2rem;
            border-top: 1px solid #e9ecef;
        }
        
        .btn {
            padding: 0.8rem 1.5rem;
            border: none;
            border-radius: 5px;
            font-size: 1rem;
            cursor: pointer;
            transition: all 0.3s ease;
            font-weight: bold;
            text-decoration: none;
            display: inline-block;
            text-align: center;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, #3498db, #2980b9);
            color: white;
        }
        
        .btn-primary:hover {
            background: linear-gradient(135deg, #2980b9, #21618c);
            transform: translateY(-2px);
        }
        
        .btn-secondary {
            background: #95a5a6;
            color: white;
        }
        
        .btn-secondary:hover {
            background: #7f8c8d;
            transform: translateY(-2px);
        }
        
        .btn-warning {
            background: #f39c12;
            color: white;
        }
        
        .btn-warning:hover {
            background: #e67e22;
            transform: translateY(-2px);
        }
        
        .employee-header {
            text-align: center;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 2rem;
            border-radius: 10px;
            margin-bottom: 2rem;
        }
        
        .employee-name {
            font-size: 2.5rem;
            font-weight: bold;
            margin-bottom: 0.5rem;
        }
        
        .employee-id {
            font-size: 1.2rem;
            opacity: 0.9;
        }
        
        .no-data {
            text-align: center;
            padding: 3rem;
            color: #7f8c8d;
        }
        
        .no-data h3 {
            font-size: 1.5rem;
            margin-bottom: 1rem;
        }
        
        @media (max-width: 768px) {
            .container {
                padding: 0 10px;
            }
            
            .detail-container {
                padding: 1.5rem;
            }
            
            .detail-grid {
                grid-template-columns: 1fr;
            }
            
            .btn-group {
                flex-direction: column;
            }
            
            .employee-name {
                font-size: 2rem;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="'${pageContext.request.contextPath}/header.jsp" />
    <div class="container">
        <div class="detail-container">
            <!-- 사원 정보가 있는 경우 -->
            <c:if test="${not empty empDetail}">
                <!-- 사원 헤더 -->
                <div class="employee-header">
                    <div class="employee-name">${empDetail.ename}</div>
                    <div class="employee-id">사번: ${empDetail.empno}</div>
                </div>
                
                <h2 class="detail-title">사원 상세정보</h2>
                
                <!-- 상세정보 그리드 -->
                <div class="detail-grid">
                    <div class="detail-item">
                        <div class="detail-label">사번</div>
                        <div class="detail-value">${empDetail.empno}</div>
                    </div>
                    
                    <div class="detail-item">
                        <div class="detail-label">이름</div>
                        <div class="detail-value">${empDetail.ename}</div>
                    </div>
                    
                    <div class="detail-item">
                        <div class="detail-label">직책</div>
                        <div class="detail-value ${empty empDetail.job ? 'empty' : ''}">
                            ${empty empDetail.job ? '직책 정보 없음' : empDetail.job}
                        </div>
                    </div>
                    
                    <div class="detail-item">
                        <div class="detail-label">상사번호</div>
                        <div class="detail-value ${empty empDetail.mgr ? 'empty' : ''}">
                            ${empty empDetail.mgr ? '상사 정보 없음' : empDetail.mgr}
                        </div>
                    </div>
                    
                    <div class="detail-item">
                        <div class="detail-label">입사일</div>
                        <div class="detail-value">${empDetail.hiredate}</div>
                    </div>
                    
                    <div class="detail-item">
                        <div class="detail-label">급여</div>
                        <div class="detail-value">
                            <c:choose>
                                <c:when test="${not empty empDetail.sal}">
                                    ₩ <fmt:formatNumber value="${empDetail.sal}" pattern="#,###"/>
                                </c:when>
                                <c:otherwise>
                                    <span class="empty">급여 정보 없음</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    
                    <div class="detail-item">
                        <div class="detail-label">커미션</div>
                        <div class="detail-value">
                            <c:choose>
                                <c:when test="${not empty empDetail.comm}">
                                    ₩ <fmt:formatNumber value="${empDetail.comm}" pattern="#,###"/>
                                </c:when>
                                <c:otherwise>
                                    <span class="empty">커미션 없음</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    
                    <div class="detail-item">
                        <div class="detail-label">부서번호</div>
                        <div class="detail-value">${empDetail.deptno}</div>
                    </div>
                </div>
                
                <!-- 버튼 그룹 -->
                <div class="btn-group">
                    <a href="emplist.do" class="btn btn-secondary">목록으로</a>
                    <button type="button" class="btn btn-warning" onclick="printEmployee()">인쇄</button>
                    <button type="button" class="btn btn-secondary" onclick="history.back()">이전으로</button>
                </div>
            </c:if>
            
            <!-- 사원 정보가 없는 경우 -->
            <c:if test="${empty empDetail}">
                <div class="no-data">
                    <h3>사원 정보를 찾을 수 없습니다</h3>
                    <p>요청하신 사원의 정보가 존재하지 않거나 삭제되었을 수 있습니다.</p>
                    
                    <div class="btn-group">
                        <a href="emplist.do" class="btn btn-primary">사원 목록</a>
                        <a href="index.do" class="btn btn-secondary">메인으로</a>
                    </div>
                </div>
            </c:if>
        </div>
    </div>
    
    <script>
        // 인쇄 기능
        function printEmployee() {
            const originalTitle = document.title;
            document.title = '사원정보_${empDetail.ename}_${empDetail.empno}';
            
            // 인쇄 전용 스타일 추가
            const printStyle = document.createElement('style');
            printStyle.innerHTML = `
                @media print {
                    .btn-group { display: none !important; }
                    body { background: white !important; }
                    .detail-container { box-shadow: none !important; }
                    .employee-header { 
                        background: #2c3e50 !important; 
                        -webkit-print-color-adjust: exact; 
                    }
                }
            `;
            document.head.appendChild(printStyle);
            
            window.print();
            
            // 인쇄 후 정리
            document.title = originalTitle;
            document.head.removeChild(printStyle);
        }
        
        // 키보드 단축키
        document.addEventListener('keydown', function(e) {
            // Ctrl + P: 인쇄
            if (e.ctrlKey && e.key === 'p') {
                e.preventDefault();
                printEmployee();
            }
            
            // ESC: 이전 페이지
            if (e.key === 'Escape') {
                history.back();
            }
        });
        
        // 페이지 로드 시 애니메이션
        window.onload = function() {
            const items = document.querySelectorAll('.detail-item');
            items.forEach((item, index) => {
                setTimeout(() => {
                    item.style.opacity = '0';
                    item.style.transform = 'translateY(20px)';
                    item.style.transition = 'all 0.5s ease';
                    
                    setTimeout(() => {
                        item.style.opacity = '1';
                        item.style.transform = 'translateY(0)';
                    }, 100);
                }, index * 100);
            });
        };
    </script>
</body>
</html>