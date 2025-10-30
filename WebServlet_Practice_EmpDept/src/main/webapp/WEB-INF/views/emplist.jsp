<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>부서별 사원조회</title>
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
        
        .search-container {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 2px 15px rgba(0,0,0,0.1);
            margin: 2rem 0;
        }
        
        .page-title {
            color: #2c3e50;
            font-size: 2rem;
            margin-bottom: 2rem;
            text-align: center;
            border-bottom: 3px solid #3498db;
            padding-bottom: 1rem;
        }
        
        .search-form {
            display: flex;
            gap: 1rem;
            align-items: end;
            margin-bottom: 2rem;
        }
        
        .form-group {
            flex: 1;
        }
        
        .form-label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: bold;
            color: #2c3e50;
        }
        
        .form-select {
            width: 100%;
            padding: 0.8rem;
            border: 2px solid #e9ecef;
            border-radius: 5px;
            font-size: 1rem;
            background: white;
            cursor: pointer;
            transition: border-color 0.3s ease;
        }
        
        .form-select:focus {
            outline: none;
            border-color: #3498db;
            box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
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
        
        .loading {
            text-align: center;
            color: #3498db;
            font-size: 1rem;
            padding: 1rem;
            display: none;
        }
        
        .loading::after {
            content: '';
            display: inline-block;
            width: 20px;
            height: 20px;
            margin-left: 10px;
            border: 2px solid #3498db;
            border-radius: 50%;
            border-top-color: transparent;
            animation: spin 1s ease-in-out infinite;
        }
        
        @keyframes spin {
            to { transform: rotate(360deg); }
        }
        
        .result-container {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 2px 15px rgba(0,0,0,0.1);
            margin: 2rem 0;
            display: none;
        }
        
        .result-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
            padding-bottom: 1rem;
            border-bottom: 2px solid #e9ecef;
        }
        
        .result-title {
            color: #2c3e50;
            font-size: 1.5rem;
        }
        
        .result-count {
            background: #3498db;
            color: white;
            padding: 0.3rem 0.8rem;
            border-radius: 20px;
            font-size: 0.9rem;
        }
        
        .employee-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1rem;
        }
        
        .employee-table th,
        .employee-table td {
            padding: 1rem;
            text-align: left;
            border-bottom: 1px solid #e9ecef;
        }
        
        .employee-table th {
            background: #f8f9fa;
            font-weight: bold;
            color: #2c3e50;
            position: sticky;
            top: 0;
            z-index: 10;
        }
        
        .employee-table tbody tr {
            transition: background-color 0.2s ease;
            cursor: pointer;
        }
        
        .employee-table tbody tr:hover {
            background-color: #f1f3f4;
        }
        
        .employee-table tbody tr:nth-child(even) {
            background-color: #fafafa;
        }
        
        .employee-table tbody tr:nth-child(even):hover {
            background-color: #f1f3f4;
        }
        
        .salary-cell {
            font-weight: bold;
            color: #27ae60;
        }
        
        .empno-cell {
            font-weight: bold;
            color: #3498db;
        }
        
        .dept-cell {
            background: #ecf0f1;
            border-radius: 4px;
            padding: 0.3rem 0.6rem;
            font-size: 0.9rem;
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
        
        .stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
            margin-bottom: 2rem;
        }
        
        .stat-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 1.5rem;
            border-radius: 10px;
            text-align: center;
        }
        
        .stat-number {
            font-size: 2rem;
            font-weight: bold;
            margin-bottom: 0.5rem;
        }
        
        .stat-label {
            font-size: 0.9rem;
            opacity: 0.9;
        }
        
        @media (max-width: 768px) {
            .container {
                padding: 0 10px;
            }
            
            .search-form {
                flex-direction: column;
                align-items: stretch;
            }
            
            .employee-table {
                font-size: 0.9rem;
            }
            
            .employee-table th,
            .employee-table td {
                padding: 0.8rem 0.5rem;
            }
            
            .stats-container {
                grid-template-columns: 1fr;
            }
        }
        
        @media (max-width: 600px) {
            .employee-table {
                display: block;
                overflow-x: auto;
                white-space: nowrap;
            }
        }
    </style>
</head>
<body>
    <!-- 공통 헤더 포함 -->
    <jsp:include page="${pageContext.request.contextPath}/header.jsp" />
    <div class="container">
        <!-- 검색 폼 -->
        <div class="search-container">
            <h2 class="page-title">부서별 사원 조회</h2>
            
            <form class="search-form">
                <div class="form-group">
                    <label for="deptSelect" class="form-label">부서 선택</label>
                    <select id="deptSelect" class="form-select" onchange="searchEmployees()">
                        <option value="">부서를 선택하세요</option>
                        <!-- 비동기로 부서 목록 로드 -->
                    </select>
                </div>
                <div class="form-group">
                    <button type="button" class="btn btn-secondary" onclick="resetSearch()">초기화</button>
                </div>
            </form>
            
            <div id="loading" class="loading">부서 정보를 불러오는 중입니다</div>
        </div>
        
        <!-- 검색 결과 -->
        <div id="resultContainer" class="result-container">
            <div class="result-header">
                <h3 class="result-title" id="resultTitle">검색 결과</h3>
                <span class="result-count" id="resultCount">0명</span>
            </div>
            
            <!-- 통계 정보 -->
            <div id="statsContainer" class="stats-container">
                <div class="stat-card">
                    <div class="stat-number" id="totalEmployees">0</div>
                    <div class="stat-label">총 사원 수</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number" id="avgSalary">0</div>
                    <div class="stat-label">평균 급여</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number" id="maxSalary">0</div>
                    <div class="stat-label">최고 급여</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number" id="minSalary">0</div>
                    <div class="stat-label">최저 급여</div>
                </div>
            </div>
            
            <!-- 사원 목록 테이블 -->
            <div style="overflow-x: auto;">
                <table class="employee-table" id="employeeTable">
                    <thead>
                        <tr>
                            <th>사번</th>
                            <th>이름</th>
                            <th>급여</th>
                            <th>입사일</th>
                            <th>부서번호</th>
                            <th>부서명</th>
                        </tr>
                    </thead>
                    <tbody id="employeeTableBody">
                        <!-- 사원 데이터가 여기에 동적으로 추가됩니다 -->
                    </tbody>
                </table>
            </div>
            
            <!-- 데이터 없음 메시지 -->
            <div id="noData" class="no-data" style="display: none;">
                <h3>해당 부서에 소속된 사원이 없습니다</h3>
                <p>다른 부서를 선택해보세요.</p>
            </div>
        </div>
    </div>
    
    <script>
        let departmentData = []; // 부서 데이터 저장
        let currentEmployees = []; // 현재 조회된 사원 데이터
        
        // 페이지 로드 시 초기화
        window.onload = function() {
            loadDepartments();
        };
        
        // 부서 목록 로드 (비동기 - 직접 구현 예정)
        function loadDepartments() {
            showLoading();
            
            // TODO: 여기에 비동기 AJAX 코드 구현
            // 예시 구조:
            /*
            fetch('getDepartments.jsp')
                .then(response => response.json())
                .then(data => {
                    hideLoading();
                    departmentData = data;
                    populateDepartmentSelect(data);
                })
                .catch(error => {
                    hideLoading();
                    console.error('부서 목록 로드 실패:', error);
                    alert('부서 목록을 불러오는데 실패했습니다.');
                });
            */
            
            // 임시 처리 (실제로는 위 비동기 코드로 대체)
            setTimeout(() => {
                hideLoading();
                const mockDeptData = [
                    { deptno: 10, dname: '경영지원부', loc: '서울' },
                    { deptno: 20, dname: '개발부', loc: '서울' },
                    { deptno: 30, dname: '영업부', loc: '부산' },
                    { deptno: 40, dname: '마케팅부', loc: '대구' }
                ];
                departmentData = mockDeptData;
                populateDepartmentSelect(mockDeptData);
            }, 1000);
        }
        
        // 부서 선택 옵션 생성
        function populateDepartmentSelect(departments) {
            const select = document.getElementById('deptSelect');
            select.innerHTML = '<option value="">부서를 선택하세요</option>';
            
            departments.forEach(dept => {
                const option = document.createElement('option');
                option.value = dept.deptno;
                option.textContent = `${dept.deptno} - ${dept.dname}`;
                option.setAttribute('data-dname', dept.dname);
                select.appendChild(option);
            });
        }
        
        // 선택된 부서의 사원 조회 (비동기 - 직접 구현 예정)
        function searchEmployees() {
            const deptno = document.getElementById('deptSelect').value;
            
            if (!deptno) {
                hideResults();
                return;
            }
            
            showLoading();
            
            // TODO: 여기에 비동기 AJAX 코드 구현
            // 예시 구조:
            /*
            fetch(`getEmployeesByDept.jsp?deptno=${deptno}`)
                .then(response => response.json())
                .then(data => {
                    hideLoading();
                    currentEmployees = data.employees;
                    displayEmployees(data.employees, data.departmentInfo);
                })
                .catch(error => {
                    hideLoading();
                    console.error('사원 데이터 로드 실패:', error);
                    alert('사원 정보를 불러오는데 실패했습니다.');
                });
            */
            
            // 임시 처리 (실제로는 위 비동기 코드로 대체)
            setTimeout(() => {
                hideLoading();
                const mockEmployees = generateMockEmployees(deptno);
                const selectedDept = departmentData.find(d => d.deptno == deptno);
                currentEmployees = mockEmployees;
                displayEmployees(mockEmployees, selectedDept);
            }, 800);
        }
        
        // 임시 데이터 생성 함수 (실제로는 서버에서 받아옴)
        function generateMockEmployees(deptno) {
            const employees = [];
            const names = ['김철수', '이영희', '박민수', '정수진', '최영수', '한미영', '송지훈', '배현정'];
            const baseDate = new Date('2020-01-01');
            
            const empCount = Math.floor(Math.random() * 6) + 2; // 2-7명 랜덤
            
            for (let i = 0; i < empCount; i++) {
                const empno = parseInt(deptno) * 100 + (i + 1);
                const sal = Math.floor(Math.random() * 3000000) + 2000000; // 200-500만원
                const hireDate = new Date(baseDate.getTime() + Math.random() * (Date.now() - baseDate.getTime()));
                
                employees.push({
                    empno: empno,
                    ename: names[Math.floor(Math.random() * names.length)],
                    sal: sal,
                    hiredate: hireDate.toISOString().split('T')[0],
                    deptno: deptno,
                    dname: departmentData.find(d => d.deptno == deptno)?.dname || '알수없음'
                });
            }
            
            return employees;
        }
        
        // 사원 목록 표시
        function displayEmployees(employees, departmentInfo) {
            const resultContainer = document.getElementById('resultContainer');
            const resultTitle = document.getElementById('resultTitle');
            const resultCount = document.getElementById('resultCount');
            const tableBody = document.getElementById('employeeTableBody');
            const noData = document.getElementById('noData');
            
            if (employees.length === 0) {
                resultContainer.style.display = 'block';
                document.getElementById('employeeTable').style.display = 'none';
                document.getElementById('statsContainer').style.display = 'none';
                noData.style.display = 'block';
                resultTitle.textContent = `${departmentInfo.dname} 검색 결과`;
                resultCount.textContent = '0명';
                return;
            }
            
            // 결과 표시
            resultContainer.style.display = 'block';
            document.getElementById('employeeTable').style.display = 'table';
            document.getElementById('statsContainer').style.display = 'grid';
            noData.style.display = 'none';
            
            resultTitle.textContent = `${departmentInfo.dname} (${departmentInfo.deptno}) 사원 목록`;
            resultCount.textContent = `${employees.length}명`;
            
            // 통계 업데이트
            updateStatistics(employees);
            
            // 테이블 내용 생성
            tableBody.innerHTML = '';
            employees.forEach(emp => {
                const row = document.createElement('tr');
                row.onclick = () => viewEmployeeDetail(emp.empno);
                
                row.innerHTML = `
                    <td class="empno-cell">${emp.empno}</td>
                    <td>${emp.ename}</td>
                    <td class="salary-cell">₩${emp.sal.toLocaleString()}</td>
                    <td>${emp.hiredate}</td>
                    <td>${emp.deptno}</td>
                    <td><span class="dept-cell">${emp.dname}</span></td>
                `;
                
                tableBody.appendChild(row);
            });
        }
        
        // 통계 정보 업데이트
        function updateStatistics(employees) {
            const totalEmp = employees.length;
            const salaries = employees.map(emp => emp.sal);
            const avgSalary = Math.round(salaries.reduce((a, b) => a + b, 0) / totalEmp);
            const maxSalary = Math.max(...salaries);
            const minSalary = Math.min(...salaries);
            
            document.getElementById('totalEmployees').textContent = totalEmp;
            document.getElementById('avgSalary').textContent = '₩' + avgSalary.toLocaleString();
            document.getElementById('maxSalary').textContent = '₩' + maxSalary.toLocaleString();
            document.getElementById('minSalary').textContent = '₩' + minSalary.toLocaleString();
        }
        
        // 사원 상세보기
        function viewEmployeeDetail(empno) {
            if (confirm(`사번 ${empno} 사원의 상세정보를 보시겠습니까?`)) {
                // 사원 상세 페이지로 이동
                window.location.href = `empdetail.jsp?empno=${empno}`;
            }
        }
        
        // 검색 초기화
        function resetSearch() {
            document.getElementById('deptSelect').value = '';
            hideResults();
        }
        
        // 결과 숨기기
        function hideResults() {
            document.getElementById('resultContainer').style.display = 'none';
        }
        
        // 로딩 표시/숨김
        function showLoading() {
            document.getElementById('loading').style.display = 'block';
        }
        
        function hideLoading() {
            document.getElementById('loading').style.display = 'none';
        }
        
        // 키보드 단축키
        document.addEventListener('keydown', function(e) {
            // F5: 새로고침
            if (e.key === 'F5') {
                e.preventDefault();
                loadDepartments();
            }
            
            // ESC: 검색 초기화
            if (e.key === 'Escape') {
                resetSearch();
            }
        });
        
        // 테이블 행 애니메이션
        function animateTableRows() {
            const rows = document.querySelectorAll('#employeeTableBody tr');
            rows.forEach((row, index) => {
                row.style.opacity = '0';
                row.style.transform = 'translateX(-20px)';
                
                setTimeout(() => {
                    row.style.transition = 'all 0.3s ease';
                    row.style.opacity = '1';
                    row.style.transform = 'translateX(0)';
                }, index * 50);
            });
        }
        
        // displayEmployees 함수가 호출될 때 애니메이션 적용
        const originalDisplayEmployees = displayEmployees;
        displayEmployees = function(employees, departmentInfo) {
            originalDisplayEmployees.call(this, employees, departmentInfo);
            if (employees.length > 0) {
                setTimeout(animateTableRows, 100);
            }
        };
    </script>
</body>
</html>