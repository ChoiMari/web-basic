<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.time.LocalDate, java.time.temporal.ChronoUnit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>사원 상세정보 - ${empdetail.ename}</title>
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
            max-width: 1000px;
            margin: 0 auto;
            padding: 20px;
            animation: fadeIn 1s ease-out;
        }
        
        .back-button {
            margin-bottom: 20px;
            animation: slideInLeft 0.8s ease-out;
        }
        
        .btn-back {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 12px 20px;
            background: rgba(255,255,255,0.1);
            backdrop-filter: blur(10px);
            color: white;
            text-decoration: none;
            border-radius: 25px;
            transition: all 0.3s ease;
            border: 1px solid rgba(255,255,255,0.2);
        }
        
        .btn-back:hover {
            background: rgba(255,255,255,0.2);
            transform: translateX(-5px);
        }
        
        .profile-card {
            background: white;
            border-radius: 25px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.1);
            overflow: hidden;
            position: relative;
            animation: slideInUp 0.8s ease-out 0.2s both;
        }
        
        .profile-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 40px 30px;
            text-align: center;
            color: white;
            position: relative;
        }
        
        .profile-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 20"><defs><pattern id="grid" width="10" height="10" patternUnits="userSpaceOnUse"><path d="M 10 0 L 0 0 0 10" fill="none" stroke="rgba(255,255,255,0.1)" stroke-width="1"/></pattern></defs><rect width="100" height="20" fill="url(%23grid)"/></svg>');
            opacity: 0.3;
        }
        
        .profile-avatar {
            width: 120px;
            height: 120px;
            background: rgba(255,255,255,0.2);
            backdrop-filter: blur(10px);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 48px;
            font-weight: bold;
            margin: 0 auto 20px;
            border: 4px solid rgba(255,255,255,0.3);
            position: relative;
            z-index: 1;
        }
        
        .profile-name {
            font-size: 2.5em;
            font-weight: 300;
            margin-bottom: 5px;
            position: relative;
            z-index: 1;
        }
        
        .profile-id {
            font-size: 1.1em;
            opacity: 0.8;
            position: relative;
            z-index: 1;
        }
        
        .profile-body {
            padding: 40px;
        }
        
        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 30px;
            margin-bottom: 40px;
        }
        
        .info-section {
            background: linear-gradient(135deg, #f8f9ff 0%, #f0f2ff 100%);
            border-radius: 20px;
            padding: 25px;
            border-left: 4px solid #667eea;
        }
        
        .info-section h3 {
            color: #667eea;
            font-size: 1.3em;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .info-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 0;
            border-bottom: 1px solid rgba(102, 126, 234, 0.1);
        }
        
        .info-item:last-child {
            border-bottom: none;
        }
        
        .info-label {
            font-weight: 600;
            color: #555;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .info-value {
            font-weight: bold;
            color: #333;
        }
        
        .salary-highlight {
            color: #28a745;
            font-size: 1.2em;
        }
        
        .status-badge {
            padding: 6px 15px;
            border-radius: 20px;
            font-size: 0.9em;
            font-weight: 600;
            background: linear-gradient(45deg, #4ecdc4, #44a08d);
            color: white;
        }
        
        .actions {
            display: flex;
            gap: 15px;
            justify-content: center;
            flex-wrap: wrap;
        }
        
        .btn {
            padding: 15px 30px;
            text-decoration: none;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            min-width: 140px;
            justify-content: center;
            box-shadow: 0 6px 20px rgba(0,0,0,0.1);
        }
        
        .btn-edit {
            background: linear-gradient(45deg, #ffeaa7, #fdcb6e);
            color: #2d3436;
        }
        
        .btn-delete {
            background: linear-gradient(45deg, #fd79a8, #e84393);
            color: white;
        }
        
        .btn-list {
            background: linear-gradient(45deg, #a29bfe, #6c5ce7);
            color: white;
        }
        
        .btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.2);
        }
        
        .stats-row {
            display: flex;
            justify-content: space-around;
            margin-top: 30px;
            padding: 20px;
            background: linear-gradient(135deg, #f8f9ff 0%, #f0f2ff 100%);
            border-radius: 15px;
        }
        
        .stat-item {
            text-align: center;
        }
        
        .stat-number {
            font-size: 2em;
            font-weight: bold;
            color: #667eea;
            display: block;
        }
        
        .stat-label {
            font-size: 0.9em;
            color: #666;
            margin-top: 5px;
        }
        
        .timeline {
            margin-top: 30px;
            padding: 20px;
            background: white;
            border-radius: 15px;
            border-left: 4px solid #667eea;
        }
        
        .timeline h3 {
            color: #667eea;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .timeline-item {
            position: relative;
            padding-left: 30px;
            margin-bottom: 15px;
        }
        
        .timeline-item::before {
            content: '';
            position: absolute;
            left: 0;
            top: 5px;
            width: 10px;
            height: 10px;
            background: #667eea;
            border-radius: 50%;
        }
        
        .timeline-item::after {
            content: '';
            position: absolute;
            left: 4px;
            top: 15px;
            width: 2px;
            height: 25px;
            background: #e0e0e0;
        }
        
        .timeline-item:last-child::after {
            display: none;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
        
        @keyframes slideInUp {
            from { 
                opacity: 0; 
                transform: translateY(50px); 
            }
            to { 
                opacity: 1; 
                transform: translateY(0); 
            }
        }
        
        @keyframes slideInLeft {
            from { 
                opacity: 0; 
                transform: translateX(-30px); 
            }
            to { 
                opacity: 1; 
                transform: translateX(0); 
            }
        }
        
        @media (max-width: 768px) {
            .info-grid {
                grid-template-columns: 1fr;
            }
            
            .actions {
                flex-direction: column;
                align-items: center;
            }
            
            .btn {
                width: 100%;
                max-width: 300px;
            }
            
            .stats-row {
                flex-direction: column;
                gap: 20px;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="/header.jsp"/>
    <div class="container mt-4">
        <div class="back-button">
            <a href="emplist.do" class="btn-back">
                <i class="fas fa-arrow-left"></i>
                사원 목록으로 돌아가기
            </a>
        </div>
        
        <div class="profile-card">
            <div class="profile-header">
                <div class="profile-avatar">
                    ${empdetail.ename.charAt(0)}
                </div>
                <div class="profile-name">${empdetail.ename}</div>
                <div class="profile-id">사원번호: ${empdetail.empno}</div>
            </div>
            
            <div class="profile-body">
                <div class="info-grid">
                    <div class="info-section">
                        <h3>
                            <i class="fas fa-user"></i>
                            기본 정보
                        </h3>
                        <div class="info-item">
                            <span class="info-label">
                                <i class="fas fa-id-badge"></i>
                                사원번호
                            </span>
                            <span class="info-value">${empdetail.empno}</span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">
                                <i class="fas fa-user"></i>
                                이름
                            </span>
                            <span class="info-value">${empdetail.ename}</span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">
                                <i class="fas fa-briefcase"></i>
                                직책
                            </span>
                            <span class="info-value status-badge">${empdetail.job}</span>
                        </div>
                    </div>
                    
                    <div class="info-section">
                        <h3>
                            <i class="fas fa-building"></i>
                            근무 정보
                        </h3>
                        <div class="info-item">
                            <span class="info-label">
                                <i class="fas fa-calendar-alt"></i>
                                입사일
                            </span>
                            <span class="info-value">
                                ${empdetail.hiredate}
                            </span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">
                                <i class="fas fa-user-tie"></i>
                                상급자
                            </span>
                            <span class="info-value">
                                <c:choose>
                                    <c:when test="${empdetail.mgr != null}">
                                        ${empdetail.mgr}번
                                    </c:when>
                                    <c:otherwise>
                                        최고 관리자
                                    </c:otherwise>
                                </c:choose>
                            </span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">
                                <i class="fas fa-building"></i>
                                부서
                            </span>
                            <span class="info-value">${empdetail.deptno}번 부서</span>
                        </div>
                    </div>
                    
                    <div class="info-section">
                        <h3>
                            <i class="fas fa-money-bill-wave"></i>
                            급여 정보
                        </h3>
                        <div class="info-item">
                            <span class="info-label">
                                <i class="fas fa-dollar-sign"></i>
                                기본급
                            </span>
                            <span class="info-value salary-highlight">
                                <fmt:formatNumber value="${empdetail.sal}" pattern="#,###"/>원
                            </span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">
                                <i class="fas fa-plus"></i>
                                커미션
                            </span>
                            <span class="info-value">
                                <c:choose>
                                    <c:when test="${empdetail.comm != null and empdetail.comm > 0}">
                                        <fmt:formatNumber value="${empdetail.comm}" pattern="#,###"/>원
                                    </c:when>
                                    <c:otherwise>
                                        없음
                                    </c:otherwise>
                                </c:choose>
                            </span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">
                                <i class="fas fa-calculator"></i>
                                총 급여
                            </span>
                            <span class="info-value salary-highlight">
                                <c:set var="totalSal" value="${empdetail.sal + (empdetail.comm != null ? empdetail.comm : 0)}"/>
                                <fmt:formatNumber value="${totalSal}" pattern="#,###"/>원
                            </span>
                        </div>
                    </div>
                </div>

                <div class="actions">
                    <a href="empupdate.do?empno=${empdetail.empno}" class="btn btn-edit">
                        <i class="fas fa-edit"></i>
                        정보 수정
                    </a>
                    <a href="javascript:void(0)" onclick="deleteEmp()" class="btn btn-delete">
                        <i class="fas fa-trash-alt"></i>
                        사원 삭제
                    </a>
                    <a href="emplist.do" class="btn btn-list">
                        <i class="fas fa-list"></i>
                        전체 목록
                    </a>
                </div>
            </div>
        </div>
    </div>
    
    <script>
        function deleteEmp() {
            const empName = '${empdetail.ename}';
            const empno = '${empdetail.empno}';
            
            if (confirm(`정말로 삭제하시겠습니까?\n\n삭제된 데이터는 복구할 수 없습니다.`)) {
                // 삭제 진행 애니메이션
                document.querySelector('.profile-card').style.transform = 'scale(0.95)';
                document.querySelector('.profile-card').style.opacity = '0.5';
                
                setTimeout(() => {
                    window.location.href = 'empdelete.do?empno=' + empno;
                }, 500);
            }
        }
        
        // 페이지 로드 시 애니메이션 효과
        window.addEventListener('load', function() {
            document.querySelectorAll('.info-section').forEach((section, index) => {
                section.style.animation = `slideInUp 0.6s ease-out ${index * 0.1 + 0.3}s both`;
            });
        });
        
        // 버튼 클릭 효과
        document.querySelectorAll('.btn').forEach(btn => {
            btn.addEventListener('click', function(e) {
                if (this.getAttribute('href') !== 'javascript:void(0)') {
                    e.preventDefault();
                    this.style.transform = 'scale(0.95)';
                    setTimeout(() => {
                        window.location.href = this.getAttribute('href');
                    }, 150);
                }
            });
        });
    </script>
</body>
</html>