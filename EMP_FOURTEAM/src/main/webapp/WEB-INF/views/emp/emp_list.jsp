<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>사원 관리 시스템</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            color: #333;
        }
        
        .container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 20px;
        }
        
        .header {
            text-align: center;
            margin-bottom: 40px;
            animation: fadeInDown 1s ease-out;
        }
        
        .header h1 {
            color: white;
            font-size: 3em;
            font-weight: 300;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
            margin-bottom: 10px;
        }
        
        .header .subtitle {
            color: rgba(255,255,255,0.8);
            font-size: 1.2em;
        }
        
        .action-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            animation: fadeInUp 1s ease-out 0.2s both;
        }
        
        .btn {
            padding: 12px 25px;
            background: linear-gradient(45deg, #ff6b6b, #ee5a52);
            color: white;
            text-decoration: none;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }
        
        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(0,0,0,0.3);
            background: linear-gradient(45deg, #ee5a52, #ff6b6b);
        }
        
        .search-box {
            position: relative;
        }
        
        .search-box input {
            padding: 12px 45px 12px 15px;
            border: none;
            border-radius: 25px;
            width: 300px;
            font-size: 16px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            outline: none;
            transition: all 0.3s ease;
        }
        
        .search-box input:focus {
            width: 350px;
            box-shadow: 0 6px 20px rgba(0,0,0,0.2);
        }
        
        .search-box i {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #666;
        }
        
        .emp-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(400px, 1fr));
            gap: 25px;
            animation: fadeIn 1s ease-out 0.4s both;
        }
        
        .emp-card {
            background: white;
            border-radius: 20px;
            padding: 25px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }
        
        .emp-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, #667eea, #764ba2);
        }
        
        .emp-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 40px rgba(0,0,0,0.15);
        }
        
        .emp-header {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }
        
        .emp-avatar {
            width: 60px;
            height: 60px;
            background: linear-gradient(45deg, #667eea, #764ba2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 24px;
            font-weight: bold;
            margin-right: 15px;
        }
        
        .emp-info h3 {
            font-size: 1.5em;
            color: #333;
            margin-bottom: 5px;
        }
        
        .emp-info .emp-id {
            color: #666;
            font-size: 0.9em;
        }
        
        .emp-details {
            margin-bottom: 20px;
        }
        
        .emp-detail-item {
            display: flex;
            align-items: center;
            margin-bottom: 10px;
            padding: 8px 0;
        }
        
        .emp-detail-item i {
            width: 20px;
            color: #667eea;
            margin-right: 10px;
        }
        
        .emp-detail-item .label {
            font-weight: 600;
            color: #555;
            width: 80px;
        }
        
        .emp-detail-item .value {
            color: #333;
        }
        
        .salary {
            color: #28a745;
            font-weight: bold;
        }
        
        .emp-actions {
            display: flex;
            gap: 10px;
            justify-content: flex-end;
        }
        
        .btn-small {
            padding: 8px 15px;
            text-decoration: none;
            border-radius: 15px;
            font-size: 0.9em;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 5px;
        }
        
        .btn-view {
            background: linear-gradient(45deg, #4ecdc4, #44a08d);
            color: white;
        }
        
        .btn-edit {
            background: linear-gradient(45deg, #ffeaa7, #fdcb6e);
            color: #2d3436;
        }
        
        .btn-delete {
            background: linear-gradient(45deg, #fd79a8, #e84393);
            color: white;
        }
        
        .btn-small:hover {
            transform: scale(1.05);
            box-shadow: 0 4px 12px rgba(0,0,0,0.2);
        }
        
        .no-data {
            text-align: center;
            color: white;
            font-size: 1.2em;
            margin-top: 50px;
            animation: fadeIn 1s ease-out;
        }
        
        .stats-bar {
            display: flex;
            justify-content: center;
            gap: 30px;
            margin-bottom: 30px;
            animation: fadeInUp 1s ease-out 0.3s both;
        }
        
        .stat-item {
            background: rgba(255,255,255,0.1);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            padding: 15px 25px;
            text-align: center;
            color: white;
        }
        
        .stat-item .number {
            font-size: 2em;
            font-weight: bold;
            display: block;
        }
        
        .stat-item .label {
            font-size: 0.9em;
            opacity: 0.8;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
        
        @keyframes fadeInUp {
            from { 
                opacity: 0; 
                transform: translateY(30px); 
            }
            to { 
                opacity: 1; 
                transform: translateY(0); 
            }
        }
        
        @keyframes fadeInDown {
            from { 
                opacity: 0; 
                transform: translateY(-30px); 
            }
            to { 
                opacity: 1; 
                transform: translateY(0); 
            }
        }
        
        @media (max-width: 768px) {
            .emp-grid {
                grid-template-columns: 1fr;
            }
            
            .action-bar {
                flex-direction: column;
                gap: 20px;
            }
            
            .search-box input {
                width: 100%;
            }
            
            .stats-bar {
                flex-direction: column;
                gap: 15px;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="/header.jsp"/>
    <div class="container mt-4">
        <div class="header">
            <h1><i class="fas fa-users"></i> 사원 관리 시스템</h1>
            <div class="subtitle">Employee Management System</div>
        </div>
        
        <div class="stats-bar">
            <div class="stat-item">
                <span class="number">${empList.size()}</span>
                <span class="label">총 사원 수</span>
            </div>
        </div>
        
        <div class="action-bar">
            <a href="${pageContext.request.contextPath}/emp.do" class="btn">
                <i class="fas fa-plus"></i>
                새 사원 등록
            </a>
            
            <div class="search-box">
                <input type="text" id="searchInput" placeholder="사원 이름으로 검색...">
                <i class="fas fa-search"></i>
            </div>
        </div>
        
        <c:choose>
            <c:when test="${not empty empList}">
                <div class="emp-grid" id="empGrid">
                    <c:forEach var="emp" items="${empList}">
                        <div class="emp-card" data-name="${emp.ename}">
                            <div class="emp-header">
                                <div class="emp-avatar">
                                    ${emp.ename.charAt(0)}
                                </div>
                                <div class="emp-info">
                                    <h3>${emp.ename}</h3>
                                    <div class="emp-id">ID: ${emp.empno}</div>
                                </div>
                            </div>
                            
                            <div class="emp-details">
                                <div class="emp-detail-item">
                                    <i class="fas fa-briefcase"></i>
                                    <span class="label">직책</span>
                                    <span class="value">${emp.job}</span>
                                </div>
                                <div class="emp-detail-item">
                                    <i class="fas fa-calendar"></i>
                                    <span class="label">입사일</span>
                                    <span class="value">
                                        ${emp.hiredate}
                                    </span>
                                </div>
                                <div class="emp-detail-item">
                                    <i class="fas fa-dollar-sign"></i>
                                    <span class="label">급여</span>
                                    <span class="value salary">
                                        <fmt:formatNumber value="${emp.sal}" pattern="#,###"/>
                                    </span>
                                </div>
                                <div class="emp-detail-item">
                                    <i class="fas fa-building"></i>
                                    <span class="label">부서</span>
                                    <span class="value">${emp.deptno}번 부서</span>
                                </div>
                            </div>
                            
                            <div class="emp-actions">
                                <a href="empdetail.do?empno=${emp.empno}" 
                                   class="btn-small btn-view">
                                    <i class="fas fa-eye"></i>
                                    상세보기
                                </a>
                                <a href="empupdate.do?empno=${emp.empno}" 
                                   class="btn-small btn-edit">
                                    <i class="fas fa-edit"></i>
                                    수정
                                </a>
                                <a href="javascript:void(0)" 
                                   onclick="deleteEmp(${emp.empno}, '${emp.ename}')" 
                                   class="btn-small btn-delete">
                                    <i class="fas fa-trash"></i>
                                    삭제
                                </a>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="no-data">
                    <i class="fas fa-inbox fa-3x" style="margin-bottom: 20px; opacity: 0.5;"></i>
                    <div>등록된 사원이 없습니다.</div>
                    <div style="margin-top: 10px; font-size: 0.9em; opacity: 0.7;">
                        첫 번째 사원을 등록해보세요!
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
    
    <script>
        // 검색 기능
        document.getElementById('searchInput').addEventListener('input', function() {
            const searchTerm = this.value.toLowerCase();
            const empCards = document.querySelectorAll('.emp-card');
            
            empCards.forEach(card => {
                const empName = card.getAttribute('data-name').toLowerCase();
                if (empName.includes(searchTerm)) {
                    card.style.display = 'block';
                    card.style.animation = 'fadeIn 0.3s ease-out';
                } else {
                    card.style.display = 'none';
                }
            });
        });
        
        // 사원 삭제 확인
        function deleteEmp(empno, empName) {
            if (confirm(`정말로 삭제하시겠습니까?\n\n삭제된 데이터는 복구할 수 없습니다.`)) {
                // 삭제 애니메이션
                const card = event.target.closest('.emp-card');
                card.style.transform = 'scale(0.8)';
                card.style.opacity = '0.5';
                
                setTimeout(() => {
                    window.location.href = 'empdelete.do?empno=' + empno;
                }, 300);
            }
        }
        
        // 카드 호버 효과 강화
        document.querySelectorAll('.emp-card').forEach(card => {
            card.addEventListener('mouseenter', function() {
                this.style.transform = 'translateY(-8px) scale(1.02)';
            });
            
            card.addEventListener('mouseleave', function() {
                this.style.transform = 'translateY(0) scale(1)';
            });
        });
        
        // 페이지 로드 애니메이션
        window.addEventListener('load', function() {
            document.querySelectorAll('.emp-card').forEach((card, index) => {
                card.style.animation = `fadeInUp 0.6s ease-out ${index * 0.1}s both`;
            });
        });
    </script>
</body>
</html>