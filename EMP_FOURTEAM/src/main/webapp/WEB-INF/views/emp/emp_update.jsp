<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>사원 정보 수정</title>
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
            padding: 20px;
            padding-top: 100px; /* 헤더 공간 확보 */
        }

        .container {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            width: 100%;
            max-width: 500px;
            margin: 0 auto;
            transform: translateY(0);
            transition: transform 0.3s ease;
        }

        .container:hover {
            transform: translateY(-5px);
        }

        .header {
            text-align: center;
            margin-bottom: 30px;
        }

        .header h1 {
            color: #333;
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 10px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .header p {
            color: #666;
            font-size: 16px;
        }

        .form-group {
            margin-bottom: 25px;
            position: relative;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #555;
            font-weight: 600;
            font-size: 14px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .form-group input {
            width: 100%;
            padding: 15px 20px;
            border: 2px solid #e1e5e9;
            border-radius: 12px;
            font-size: 16px;
            transition: all 0.3s ease;
            background: #f8f9fa;
        }

        .form-group input:focus {
            outline: none;
            border-color: #667eea;
            background: #fff;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
            transform: translateY(-2px);
        }

        .form-group input[readonly] {
            background: #e9ecef;
            color: #6c757d;
            cursor: not-allowed;
        }

        .button-group {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }

        .btn {
            flex: 1;
            padding: 15px 20px;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(102, 126, 234, 0.4);
        }

        .btn-secondary {
            background: #6c757d;
            color: white;
        }

        .btn-secondary:hover {
            background: #5a6268;
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(108, 117, 125, 0.4);
        }

        .emp-info {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            padding: 20px;
            border-radius: 12px;
            margin-bottom: 30px;
            border-left: 4px solid #667eea;
        }

        .emp-info h3 {
            color: #333;
            margin-bottom: 10px;
            font-size: 18px;
        }

        .emp-info p {
            color: #666;
            margin: 5px 0;
        }

        @media (max-width: 768px) {
            .container {
                padding: 30px 20px;
                margin: 10px;
            }
            
            .button-group {
                flex-direction: column;
            }
        }

        /* 애니메이션 효과 */
        .form-group {
            opacity: 0;
            transform: translateX(-30px);
            animation: slideIn 0.6s ease forwards;
        }

        .form-group:nth-child(1) { animation-delay: 0.1s; }
        .form-group:nth-child(2) { animation-delay: 0.2s; }
        .form-group:nth-child(3) { animation-delay: 0.3s; }
        .form-group:nth-child(4) { animation-delay: 0.4s; }

        @keyframes slideIn {
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }
    </style>
</head>
<body>
    <jsp:include page="/header.jsp"/>
    <div class="container mt-4">
        <div class="header">
            <h1>✨ 사원 정보 수정</h1>
            <p>사원 정보를 업데이트하세요</p>
        </div>

        <div class="emp-info">
            <h3>🔍 현재 사원 정보</h3>
            <p><strong>사원번호:</strong> ${empupdate.empno}</p>
            <p><strong>현재 이름:</strong> ${empupdate.ename}</p>
            <p><strong>현재 직책:</strong> ${empupdate.job}</p>
        </div>

        <form action="empupdateok.do" method="post" onsubmit="return validateForm()">
            <input type="hidden" name="empno" value="${empupdate.empno}">
            
            <div class="form-group">
                <label for="empno_display">👤 사원번호</label>
                <input type="text" id="empno_display" value="${empupdate.empno}" readonly>
            </div>

            <div class="form-group">
                <label for="ename">✏️ 사원명</label>
                <input type="text" id="ename" name="ename" value="${empupdate.ename}" 
                       placeholder="사원명을 입력하세요" required maxlength="20">
            </div>

            <div class="form-group">
                <label for="job">💼 직책</label>
                <input type="text" id="job" name="job" value="${empupdate.job}" 
                       placeholder="직책을 입력하세요" required maxlength="20">
            </div>

            <div class="form-group">
                <label for="sal">💰 급여</label>
                <input type="number" id="sal" name="sal" value="${empupdate.sal}" 
                       placeholder="급여를 입력하세요" required min="0" max="9999999">
            </div>
            
            <div class="form-group">
                <label for="hiredate">📅 입사일</label>
                <input type="date" id="hiredate" name="hiredate" value="${empupdate.hiredate}" 
                       placeholder="입사일을 선택하세요" required>
            </div>            
            
            <div class="button-group">
                <button type="submit" class="btn btn-primary">
                    🚀 수정완료
                </button>
                <button type="button" class="btn btn-secondary" onclick="history.back()">
                    🔙 취소
                </button>
            </div>
        </form>
    </div>

    <script>
        function validateForm() {
            const ename = document.getElementById('ename').value.trim();
            const job = document.getElementById('job').value.trim();
            const sal = document.getElementById('sal').value;

            if (!ename) {
                alert('🚨 사원명을 입력해주세요!');
                document.getElementById('ename').focus();
                return false;
            }

            if (!job) {
                alert('🚨 직책을 입력해주세요!');
                document.getElementById('job').focus();
                return false;
            }

            if (!sal || sal <= 0) {
                alert('🚨 올바른 급여를 입력해주세요!');
                document.getElementById('sal').focus();
                return false;
            }

            if (confirm('🤔 정말로 수정하시겠습니까?')) {
                return true;
            }
            
            return false;
        }

        // 입력 필드 실시간 유효성 검사
        document.getElementById('ename').addEventListener('input', function(e) {
            if (e.target.value.trim().length === 0) {
                e.target.style.borderColor = '#dc3545';
            } else {
                e.target.style.borderColor = '#28a745';
            }
        });

        document.getElementById('job').addEventListener('input', function(e) {
            if (e.target.value.trim().length === 0) {
                e.target.style.borderColor = '#dc3545';
            } else {
                e.target.style.borderColor = '#28a745';
            }
        });

        document.getElementById('sal').addEventListener('input', function(e) {
            if (e.target.value <= 0 || !e.target.value) {
                e.target.style.borderColor = '#dc3545';
            } else {
                e.target.style.borderColor = '#28a745';
            }
        });

        // 페이지 로드 시 첫 번째 입력 필드에 포커스
        window.onload = function() {
            document.getElementById('ename').focus();
        };
    </script>
</body>
</html>