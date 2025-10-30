<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>사원 등록</title>
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
        
        .form-container {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 2px 15px rgba(0,0,0,0.1);
            margin: 2rem 0;
        }
        
        .form-title {
            color: #2c3e50;
            font-size: 2rem;
            margin-bottom: 2rem;
            text-align: center;
            border-bottom: 3px solid #3498db;
            padding-bottom: 1rem;
        }
        
        .form-group {
            margin-bottom: 1.5rem;
        }
        
        .form-label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: bold;
            color: #2c3e50;
        }
        
        .form-input {
            width: 100%;
            padding: 0.8rem;
            border: 2px solid #e9ecef;
            border-radius: 5px;
            font-size: 1rem;
            transition: border-color 0.3s ease;
        }
        
        .form-input:focus {
            outline: none;
            border-color: #3498db;
            box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
        }
        
        .form-input.error {
            border-color: #e74c3c;
            background-color: #ffeaea;
        }
        
        .form-input.success {
            border-color: #27ae60;
            background-color: #eafaf1;
        }
        
        .input-group {
            display: flex;
            gap: 10px;
            align-items: stretch;
        }
        
        .input-group .form-input {
            flex: 1;
        }
        
        .btn {
            padding: 0.8rem 1.5rem;
            border: none;
            border-radius: 5px;
            font-size: 1rem;
            cursor: pointer;
            transition: all 0.3s ease;
            font-weight: bold;
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
        }
        
        .btn-check {
            background: #f39c12;
            color: white;
            white-space: nowrap;
        }
        
        .btn-check:hover {
            background: #e67e22;
        }
        
        .error-message {
            color: #e74c3c;
            font-size: 0.9rem;
            margin-top: 0.3rem;
            display: none;
        }
        
        .success-message {
            color: #27ae60;
            font-size: 0.9rem;
            margin-top: 0.3rem;
            display: none;
        }
        
        .form-buttons {
            display: flex;
            gap: 1rem;
            justify-content: center;
            margin-top: 2rem;
            padding-top: 2rem;
            border-top: 1px solid #e9ecef;
        }
        
        .loading {
            display: none;
            font-size: 0.9rem;
            color: #3498db;
            margin-top: 0.3rem;
        }
        
        .calendar-input {
            position: relative;
        }
        
        select.form-input {
            background: white;
            cursor: pointer;
        }
        
        @media (max-width: 768px) {
            .container {
                padding: 0 10px;
            }
            
            .form-container {
                padding: 1.5rem;
            }
            
            .input-group {
                flex-direction: column;
            }
            
            .form-buttons {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="${pageCotext.request.contextPath}/header.jsp" />
    <div class="container">
        <div class="form-container">
            <h2 class="form-title">사원 정보 입력</h2>
            
            <form id="empForm" action="empcreate.do" method="post">
                <!-- 사번 입력 (중복체크) -->
                <div class="form-group">
                    <label for="empno" class="form-label">사번 *</label>
                    <div class="input-group">
                        <input type="text" id="empno" name="empno" class="form-input" placeholder="사번을 입력하세요" maxlength="10" required>
                        <button type="button" class="btn btn-check" onclick="checkEmpno()">중복체크</button>
                    </div>
                    <div id="empno-loading" class="loading">확인 중...</div>
                    <div id="empno-error" class="error-message">사번을 입력해주세요.</div>
                    <div id="empno-success" class="success-message">사용 가능한 사번입니다.</div>
                </div>
                
                <!-- 이름 입력 -->
                <div class="form-group">
                    <label for="ename" class="form-label">이름 *</label>
                    <input type="text" id="ename" name="ename" class="form-input" placeholder="이름을 입력하세요" maxlength="50" required>
                    <div id="ename-error" class="error-message">이름을 입력해주세요.</div>
                </div>
                
                <!-- 급여 입력 (숫자 유효성 검사) -->
                <div class="form-group">
                    <label for="sal" class="form-label">급여 *</label>
                    <input type="text" id="sal" name="sal" class="form-input" placeholder="급여를 입력하세요 (숫자만)" required>
                    <div id="sal-error" class="error-message">올바른 급여 금액을 입력해주세요.</div>
                </div>
                
                <!-- 입사일 입력 (달력) -->
                <div class="form-group">
                    <label for="hiredate" class="form-label">입사일 *</label>
                    <div class="calendar-input">
                        <input type="date" id="hiredate" name="hiredate" class="form-input" required>
                    </div>
                    <div id="hiredate-error" class="error-message">입사일을 선택해주세요.</div>
                </div>
                
                <!-- 부서번호 선택 -->
                <div class="form-group">
                    <label for="deptno" class="form-label">부서번호 *</label>
                    <input type="text" id="deptno" name="deptno" class="form-input" placeholder="부서번호를 입력하세요." required>
                    <div id="deptno-loading" class="loading">부서 정보 로딩 중...</div>
                    <div id="deptno-error" class="error-message">부서를 선택해주세요.</div>
                </div>
                
                <!-- 관리자 사번 선택 -->
                <div class="form-group">
                    <label for="mgr" class="form-label">관리자 사번</label>
                    <input type="text" id="mgr" name="mgr" class="form-input" placeholder="관리자번호를 입력하세요." required>
                    <div id="mgr-loading" class="loading">관리자 정보 로딩 중...</div>
                    <div id="mgr-error" class="error-message"></div>
                </div>
                
                <!-- 버튼 그룹 -->
                <div class="form-buttons">
                    <button type="submit" class="btn btn-primary">사원 등록</button>
                    <button type="button" class="btn btn-secondary" onclick="resetForm()">초기화</button>
                    <button type="button" class="btn btn-secondary" onclick="location.href='index.do'">취소</button>
                </div>
            </form>
        </div>
    </div>
    
    <script>
        let empnoChecked = false;
        let isValidForm = false;
        
        // 페이지 로드 시 초기화
        window.onload = function() {
            loadDepartments();
            loadManagers();
            
            // 오늘 날짜를 기본값으로 설정
            const today = new Date().toISOString().split('T')[0];
            document.getElementById('hiredate').value = today;
        };
        
        // 사번 중복체크 (비동기 - 직접 구현 예정)
        function checkEmpno() {
            const empno = document.getElementById('empno').value.trim();
            
            if (!empno) {
                showError('empno', '사번을 입력해주세요.');
                return;
            }
            
            // 사번 형식 검증 (숫자 4자리)
            const empnoPattern = /^\d{4}$/;
            if (!empnoPattern.test(empno)) {
                showError('empno', '사번은 4자리 숫자여야 합니다.');
                return;
            }
            
            showLoading('empno');
            
            // TODO: 여기에 비동기 AJAX 코드 구현
            // 예시 구조:
            /*
            fetch('/EmpnoCheck?empno=' + empno)
                .then(response => response.json())
                .then(data => {
                    hideLoading('empno');
                    if (data.exists) {
                        showError('empno', '이미 사용 중인 사번입니다.');
                        empnoChecked = false;
                    } else {
                        showSuccess('empno', '사용 가능한 사번입니다.');
                        empnoChecked = true;
                    }
                })
                .catch(error => {
                    hideLoading('empno');
                    showError('empno', '중복체크 중 오류가 발생했습니다.');
                });
            */
            
            // 임시 처리 (실제로는 위 비동기 코드로 대체)
            setTimeout(() => {
                hideLoading('empno');
                showSuccess('empno', '사용 가능한 사번입니다.');
                empnoChecked = true;
            }, 1000);
        }
        
        // 부서 목록 로드 (비동기 - 직접 구현 예정)
        function loadDepartments() {
            showLoading('deptno');
            
            // TODO: 여기에 비동기 AJAX 코드 구현
            // 예시 구조:
            /*
            fetch('getDepartments.jsp')
                .then(response => response.json())
                .then(data => {
                    hideLoading('deptno');
                    const select = document.getElementById('deptno');
                    select.innerHTML = '<option value="">부서를 선택하세요</option>';
                    data.forEach(dept => {
                        const option = document.createElement('option');
                        option.value = dept.deptno;
                        option.textContent = dept.deptno + ' - ' + dept.dname;
                        select.appendChild(option);
                    });
                })
                .catch(error => {
                    hideLoading('deptno');
                    showError('deptno', '부서 목록을 불러오는데 실패했습니다.');
                });
            */
            
            // 임시 처리 (실제로는 위 비동기 코드로 대체)
            setTimeout(() => {
                hideLoading('deptno');
                const select = document.getElementById('deptno');
                select.innerHTML = `
                    <option value="">부서를 선택하세요</option>
                    <option value="10">10 - 경영지원부</option>
                    <option value="20">20 - 개발부</option>
                    <option value="30">30 - 영업부</option>
                    <option value="40">40 - 마케팅부</option>
                `;
            }, 500);
        }
        
        // 관리자 목록 로드 (비동기 - 직접 구현 예정)
        function loadManagers() {
            showLoading('mgr');
            
            // TODO: 여기에 비동기 AJAX 코드 구현
            
            // 임시 처리
            setTimeout(() => {
                hideLoading('mgr');
                const select = document.getElementById('mgr');
                select.innerHTML = `
                    <option value="">관리자를 선택하세요 (선택사항)</option>
                    <option value="7839">7839 - 김사장</option>
                    <option value="7698">7698 - 이부장</option>
                    <option value="7782">7782 - 박과장</option>
                    <option value="7566">7566 - 최팀장</option>
                `;
            }, 500);
        }
        
        // 부서 정보 로드
        function loadDeptInfo() {
            // 부서 선택 시 추가 작업이 필요한 경우 구현
        }
        
        // 관리자 정보 로드
        function loadMgrInfo() {
            // 관리자 선택 시 추가 작업이 필요한 경우 구현
        }
        
        // 급여 입력 유효성 검사 (실시간)
        document.getElementById('sal').addEventListener('input', function() {
            const sal = this.value.trim();
            const salPattern = /^\d+$/;  // 숫자만 허용
            
            if (sal && !salPattern.test(sal)) {
                showError('sal', '급여는 숫자만 입력 가능합니다.');
                this.classList.add('error');
            } else if (sal && parseInt(sal) < 0) {
                showError('sal', '급여는 0 이상의 값을 입력해주세요.');
                this.classList.add('error');
            } else if (sal && parseInt(sal) > 999999999) {
                showError('sal', '급여는 10억 미만으로 입력해주세요.');
                this.classList.add('error');
            } else {
                hideError('sal');
                this.classList.remove('error');
                if (sal) this.classList.add('success');
            }
        });
        
        // 이름 입력 유효성 검사
        document.getElementById('ename').addEventListener('input', function() {
            const ename = this.value.trim();
            if (ename.length > 0 && ename.length < 2) {
                showError('ename', '이름은 2자 이상 입력해주세요.');
                this.classList.add('error');
            } else if (ename.length >= 2) {
                hideError('ename');
                this.classList.remove('error');
                this.classList.add('success');
            }
        });
        
        // 사번 입력 시 중복체크 상태 초기화
        document.getElementById('empno').addEventListener('input', function() {
            empnoChecked = false;
            hideError('empno');
            hideSuccess('empno');
            this.classList.remove('error', 'success');
        });
        
        // 폼 제출 처리
        document.getElementById('empForm').addEventListener('submit', function(e) {
            e.preventDefault();
            
            if (validateForm()) {
                // 폼이 유효하면 실제 제출
                this.submit();
            }
        });
        
        // 전체 폼 유효성 검사
        function validateForm() {
            let isValid = true;
            
            // 사번 검사
            const empno = document.getElementById('empno').value.trim();
            if (!empno) {
                showError('empno', '사번을 입력해주세요.');
                isValid = false;
            } else if (!empnoChecked) {
                showError('empno', '사번 중복체크를 해주세요.');
                isValid = false;
            }
            
            // 이름 검사
            const ename = document.getElementById('ename').value.trim();
            if (!ename) {
                showError('ename', '이름을 입력해주세요.');
                isValid = false;
            } else if (ename.length < 2) {
                showError('ename', '이름은 2자 이상 입력해주세요.');
                isValid = false;
            }
            
            // 급여 검사
            const sal = document.getElementById('sal').value.trim();
            const salPattern = /^\d+$/;
            if (!sal) {
                showError('sal', '급여를 입력해주세요.');
                isValid = false;
            } else if (!salPattern.test(sal)) {
                showError('sal', '급여는 숫자만 입력 가능합니다.');
                isValid = false;
            }
            
            // 입사일 검사
            const hiredate = document.getElementById('hiredate').value;
            if (!hiredate) {
                showError('hiredate', '입사일을 선택해주세요.');
                isValid = false;
            }
            
            // 부서 검사
            const deptno = document.getElementById('deptno').value;
            if (!deptno) {
                showError('deptno', '부서를 선택해주세요.');
                isValid = false;
            }
            
            return isValid;
        }
        
        // 폼 초기화
        function resetForm() {
            if (confirm('입력한 내용이 모두 삭제됩니다. 계속하시겠습니까?')) {
                document.getElementById('empForm').reset();
                empnoChecked = false;
                
                // 에러/성공 메시지 숨기기
                const errorMessages = document.querySelectorAll('.error-message, .success-message');
                errorMessages.forEach(msg => msg.style.display = 'none');
                
                // 입력 필드 클래스 초기화
                const inputs = document.querySelectorAll('.form-input');
                inputs.forEach(input => input.classList.remove('error', 'success'));
                
                // 오늘 날짜 다시 설정
                const today = new Date().toISOString().split('T')[0];
                document.getElementById('hiredate').value = today;
            }
        }
        
        // 유틸리티 함수들
        function showError(fieldName, message) {
            const errorElement = document.getElementById(fieldName + '-error');
            const inputElement = document.getElementById(fieldName);
            
            errorElement.textContent = message;
            errorElement.style.display = 'block';
            inputElement.classList.add('error');
            inputElement.classList.remove('success');
        }
        
        function hideError(fieldName) {
            const errorElement = document.getElementById(fieldName + '-error');
            errorElement.style.display = 'none';
        }
        
        function showSuccess(fieldName, message) {
            const successElement = document.getElementById(fieldName + '-success');
            const inputElement = document.getElementById(fieldName);
            
            successElement.textContent = message;
            successElement.style.display = 'block';
            inputElement.classList.add('success');
            inputElement.classList.remove('error');
        }
        
        function hideSuccess(fieldName) {
            const successElement = document.getElementById(fieldName + '-success');
            if (successElement) {
                successElement.style.display = 'none';
            }
        }
        
        function showLoading(fieldName) {
            const loadingElement = document.getElementById(fieldName + '-loading');
            if (loadingElement) {
                loadingElement.style.display = 'block';
            }
        }
        
        function hideLoading(fieldName) {
            const loadingElement = document.getElementById(fieldName + '-loading');
            if (loadingElement) {
                loadingElement.style.display = 'none';
            }
        }
    </script>
</body>
</html>