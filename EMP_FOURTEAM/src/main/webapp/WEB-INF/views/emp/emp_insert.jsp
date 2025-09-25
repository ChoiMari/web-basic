<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>새 사원 등록</title>
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
            max-width: 800px;
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
        
        .form-card {
            background: white;
            border-radius: 25px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.1);
            overflow: hidden;
            animation: slideInUp 0.8s ease-out 0.2s both;
        }
        
        .form-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 40px 30px;
            text-align: center;
            color: white;
            position: relative;
        }
        
        .form-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 20"><defs><pattern id="grid" width="10" height="10" patternUnits="userSpaceOnUse"><path d="M 10 0 L 0 0 0 10" fill="none" stroke="rgba(255,255,255,0.1)" stroke-width="1"/></pattern></defs><rect width="100" height="20" fill="url(%23grid)"/></svg>');
            opacity: 0.3;
        }
        
        .form-header-icon {
            width: 80px;
            height: 80px;
            background: rgba(255,255,255,0.2);
            backdrop-filter: blur(10px);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 32px;
            margin: 0 auto 20px;
            border: 3px solid rgba(255,255,255,0.3);
            position: relative;
            z-index: 1;
        }
        
        .form-header h1 {
            font-size: 2.2em;
            font-weight: 300;
            margin-bottom: 10px;
            position: relative;
            z-index: 1;
        }
        
        .form-header .subtitle {
            opacity: 0.8;
            position: relative;
            z-index: 1;
        }
        
        .form-body {
            padding: 40px;
        }
        
        .form-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 30px;
            margin-bottom: 30px;
        }
        
        .form-section {
            background: linear-gradient(135deg, #f8f9ff 0%, #f0f2ff 100%);
            border-radius: 20px;
            padding: 25px;
            border-left: 4px solid #667eea;
        }
        
        .form-section h3 {
            color: #667eea;
            font-size: 1.3em;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-group label {
            display: block;
            font-weight: 600;
            color: #555;
            margin-bottom: 8px;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .form-group input,
        .form-group select {
            width: 100%;
            padding: 15px 20px;
            border: 2px solid #e0e0e0;
            border-radius: 15px;
            font-size: 16px;
            transition: all 0.3s ease;
            background: white;
        }
        
        .form-group input:focus,
        .form-group select:focus {
            border-color: #667eea;
            outline: none;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
            transform: translateY(-2px);
        }
        
        .form-group input:hover,
        .form-group select:hover {
            border-color: #999;
        }
        
        .required {
            color: #e74c3c;
            margin-left: 3px;
        }
        
        .input-group {
            position: relative;
        }
        
        .input-icon {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #999;
            pointer-events: none;
        }
        
        .form-actions {
            display: flex;
            gap: 15px;
            justify-content: center;
            padding-top: 20px;
            border-top: 1px solid #e0e0e0;
        }
        
        .btn {
            padding: 15px 30px;
            border: none;
            border-radius: 25px;
            font-weight: 600;
            font-size: 16px;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            min-width: 150px;
            justify-content: center;
            box-shadow: 0 6px 20px rgba(0,0,0,0.1);
            cursor: pointer;
            text-decoration: none;
        }
        
        .btn-submit {
            background: linear-gradient(45deg, #667eea, #764ba2);
            color: white;
        }
        
        .btn-reset {
            background: linear-gradient(45deg, #ffeaa7, #fdcb6e);
            color: #2d3436;
        }
        
        .btn-cancel {
            background: linear-gradient(45deg, #ddd, #bbb);
            color: #666;
        }
        
        .btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.2);
        }
        
        .form-tips {
            background: #e8f4fd;
            border-left: 4px solid #3498db;
            padding: 15px 20px;
            border-radius: 10px;
            margin-bottom: 30px;
        }
        
        .form-tips h4 {
            color: #2980b9;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .form-tips ul {
            color: #34495e;
            padding-left: 20px;
        }
        
        .form-tips li {
            margin-bottom: 5px;
        }
        
        .validation-message {
            color: #e74c3c;
            font-size: 0.9em;
            margin-top: 5px;
            display: none;
        }
        
        .input-error {
            border-color: #e74c3c !important;
            box-shadow: 0 0 0 3px rgba(231, 76, 60, 0.1) !important;
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
            .form-grid {
                grid-template-columns: 1fr;
            }
            
            .form-actions {
                flex-direction: column;
            }
            
            .btn {
                width: 100%;
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
        
        <div class="form-card">
            <div class="form-header">
                <div class="form-header-icon">
                    <i class="fas fa-user-plus"></i>
                </div>
                <h1>새 사원 등록</h1>
                <div class="subtitle">신규 직원의 정보를 입력해주세요</div>
            </div>
            
            <div class="form-body">
                <div class="form-tips">
                    <h4>
                        <i class="fas fa-info-circle"></i>
                        입력 가이드
                    </h4>
                    <ul>
                        <li>사원번호는 고유한 번호여야 합니다</li>
                        <li>급여는 숫자만 입력 가능합니다</li>
                        <li>커미션이 없는 경우 0을 입력해주세요</li>
                        <li>상급자번호는 기존 사원번호 중 하나여야 합니다</li>
                    </ul>
                </div>
                
                <form action="empinsert.do" method="post" id="empForm">
                    <div class="form-grid">
                        <div class="form-section">
                            <h3>
                                <i class="fas fa-user"></i>
                                기본 정보
                            </h3>
                            
                            <div class="form-group">
                                <label for="empno">
                                    <i class="fas fa-id-badge"></i>
                                    사원번호 <span class="required">*</span>
                                </label>
                                <div class="input-group">
                                    <input type="number" id="empno" name="empno" required 
                                           placeholder="예: 1001" min="1" max="9999">
                                    <i class="input-icon fas fa-hashtag"></i>
                                </div>
                                <div class="validation-message" id="empno-error">사원번호를 입력해주세요.</div>
                            </div>
                            
                            <div class="form-group">
                                <label for="ename">
                                    <i class="fas fa-user"></i>
                                    이름 <span class="required">*</span>
                                </label>
                                <div class="input-group">
                                    <input type="text" id="ename" name="ename" required 
                                           placeholder="예: 홍길동" maxlength="20">
                                    <i class="input-icon fas fa-user"></i>
                                </div>
                                <div class="validation-message" id="ename-error">이름을 입력해주세요.</div>
                            </div>
                            
                            <div class="form-group">
                                <label for="job">
                                    <i class="fas fa-briefcase"></i>
                                    직책 <span class="required">*</span>
                                </label>
                                <div class="input-group">
                                    <select id="job" name="job" required>
                                        <option value="">직책을 선택해주세요</option>
                                        <option value="CLERK">CLERK</option>
                                        <option value="SALESMAN">SALESMAN</option>
                                        <option value="ANALYST">ANALYST</option>
                                        <option value="MANAGER">MANAGER</option>
                                        <option value="PRESIDENT">PRESIDENT</option>
                                    </select>
                                </div>
                                <div class="validation-message" id="job-error">직책을 선택해주세요.</div>
                            </div>
                        </div>
                        
                        <div class="form-section">
                            <h3>
                                <i class="fas fa-building"></i>
                                조직 정보
                            </h3>
                            
                            <div class="form-group">
                                <label for="mgr">
                                    <i class="fas fa-user-tie"></i>
                                    상급자번호
                                </label>
                                <div class="input-group">
                                    <input type="number" id="mgr" name="mgr" 
                                           placeholder="예: 7839" min="1" max="9999" required>
                                    <i class="input-icon fas fa-crown"></i>
                                </div>
                                <div class="validation-message" id="mgr-error">올바른 상급자 번호를 입력해주세요.</div>
                            </div>
                            
                            <div class="form-group">
                                <label for="deptno">
                                    <i class="fas fa-building"></i>
                                    부서번호 <span class="required">*</span>
                                </label>
                                <div class="input-group">
                                    <select id="deptno" name="deptno" required>
                                        <option value="">부서를 선택해주세요</option>
                                        <option value="10">10 - ACCOUNTING</option>
                                        <option value="20">20 - RESEARCH</option>
                                        <option value="30">30 - SALES</option>
                                        <option value="40">40 - OPERATIONS</option>
                                    </select>
                                </div>
                                <div class="validation-message" id="deptno-error">부서를 선택해주세요.</div>
                            </div>
                        </div>
                        
                        <div class="form-section">
                            <h3>
                                <i class="fas fa-money-bill-wave"></i>
                                급여 정보
                            </h3>
                            
                            <div class="form-group">
                                <label for="sal">
                                    <i class="fas fa-dollar-sign"></i>
                                    기본급 <span class="required">*</span>
                                </label>
                                <div class="input-group">
                                    <input type="number" id="sal" name="sal" required 
                                           placeholder="예: 3000" min="1" max="999999">
                                    <i class="input-icon fas fa-won-sign"></i>
                                </div>
                                <div class="validation-message" id="sal-error">급여를 입력해주세요.</div>
                            </div>
                            <div class="form-group">
                                <label for="hiredate">📅 입사일</label>
                                <input type="date" id="hiredate" name="hiredate" value="${empupdate.hiredate}" 
                                       placeholder="입사일을 선택하세요" required>
                            </div>
                            <div class="form-group">
                                <label for="comm">
                                    <i class="fas fa-plus"></i>
                                    커미션
                                </label>
                                <div class="input-group">
                                    <input type="number" id="comm" name="comm" value="0"
                                           placeholder="예: 300 (없으면 0)" min="0" max="99999">
                                    <i class="input-icon fas fa-percentage"></i>
                                </div>
                                <div class="validation-message" id="comm-error">올바른 커미션을 입력해주세요.</div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="form-actions">
                        <button type="submit" class="btn btn-submit">
                            <i class="fas fa-save"></i>
                            등록하기
                        </button>
                        <button type="reset" class="btn btn-reset">
                            <i class="fas fa-undo"></i>
                            초기화
                        </button>
                        <a href="emplist.do" class="btn btn-cancel">
                            <i class="fas fa-times"></i>
                            취소
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <script src="/js/emp_list.js"></script>
</body>
</html>