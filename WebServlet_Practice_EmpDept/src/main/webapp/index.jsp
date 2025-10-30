<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta charset="UTF-8">
    <title>사원관리</title>
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
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }
        
        .main-content {
            padding: 2rem 0;
        }
        
        .welcome-section {
            background: white;
            padding: 3rem 2rem;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            text-align: center;
            margin-bottom: 3rem;
        }
        
        .welcome-section h2 {
            color: #2c3e50;
            font-size: 2.5rem;
            margin-bottom: 1rem;
        }
        
        .welcome-section p {
            color: #7f8c8d;
            font-size: 1.2rem;
            max-width: 600px;
            margin: 0 auto;
        }
        
        .menu-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
            margin-top: 2rem;
        }
        
        .menu-card {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 2px 15px rgba(0,0,0,0.1);
            text-align: center;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            border: 1px solid #e9ecef;
        }
        
        .menu-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 25px rgba(0,0,0,0.15);
        }
        
        .menu-card .icon {
            font-size: 3rem;
            margin-bottom: 1rem;
            color: #3498db;
        }
        
        .menu-card h3 {
            color: #2c3e50;
            font-size: 1.5rem;
            margin-bottom: 1rem;
        }
        
        .menu-card p {
            color: #7f8c8d;
            margin-bottom: 2rem;
            line-height: 1.5;
        }
        
        .menu-link {
            display: inline-block;
            background: linear-gradient(135deg, #3498db, #2980b9);
            color: white;
            padding: 0.8rem 2rem;
            text-decoration: none;
            border-radius: 25px;
            font-weight: bold;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
        }
        
        .menu-link:hover {
            background: linear-gradient(135deg, #2980b9, #21618c);
            transform: scale(1.05);
        }
        
        .stats-section {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 3rem 2rem;
            border-radius: 10px;
            margin-top: 3rem;
            text-align: center;
        }
        
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 2rem;
            margin-top: 2rem;
        }
        
        .stat-item {
            background: rgba(255,255,255,0.1);
            padding: 1.5rem;
            border-radius: 10px;
            backdrop-filter: blur(10px);
        }
        
        .stat-number {
            font-size: 2rem;
            font-weight: bold;
            margin-bottom: 0.5rem;
        }
        
        @media (max-width: 768px) {
            .welcome-section h2 {
                font-size: 2rem;
            }
            
            .welcome-section p {
                font-size: 1rem;
            }
            
            .menu-grid {
                grid-template-columns: 1fr;
            }
            
            .stats-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
<!-- 공통 헤더 포함 -->
    <jsp:include page="${pageCotext.request.contextPath}/header.jsp" />
    
    <div class="container">
        <main class="main-content">
            <!-- 환영 섹션 -->
            <section class="welcome-section">
                <h2>사원 관리 시스템에 오신 것을 환영합니다</h2>
                <p>효율적이고 체계적인 사원 정보 관리를 위한 통합 시스템입니다.<br>
                   아래 메뉴를 통해 원하는 기능을 선택하세요.</p>
            </section>
            
            <!-- 메인 메뉴 -->
            <section class="menu-grid">
                <div class="menu-card">
                    <div class="icon">👥</div>
                    <h3>사원 입력</h3>
                    <p>새로운 사원의 정보를 등록하고<br>관리할 수 있습니다.</p>
                    <a href="employeeInput.do" class="menu-link">사원 입력하기</a>
                </div>
                
                <div class="menu-card">
                    <div class="icon">🏢</div>
                    <h3>부서별 사원조회</h3>
                    <p>각 부서별로 소속 사원들의<br>정보를 조회할 수 있습니다.</p>
                    <a href="departmentEmployeeList.do" class="menu-link">사원 조회하기</a>
                </div>
            </section>
        </main>
    </div>
    
    <footer style="background-color: #34495e; color: white; text-align: center; padding: 2rem 0; margin-top: 3rem;">
        <div class="container">
            <p>&copy; 2025.9.29 사원 관리 시스템.</p>
        </div>
    </footer>
</body>
</html>