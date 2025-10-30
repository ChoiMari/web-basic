<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
    header nav a:hover {
        background-color: #34495e;
    }
    
    @media (max-width: 768px) {
        header div {
            flex-direction: column;
            gap: 1rem;
        }
        
        header nav ul {
            flex-direction: column;
            gap: 0.5rem;
            text-align: center;
        }
    }
    </style>
</head>
<body>
    <header
        style="background-color: #2c3e50; color: white; padding: 1rem 0; margin-bottom: 2rem;">
        <div style="max-width: 1200px; margin: 0 auto; padding: 0 20px;">
            <div
                style="display: flex; justify-content: space-between; align-items: center;">
                <h1 style="margin: 0; font-size: 1.5rem;">
                    <a href="index.do"
                        style="color: white; text-decoration: none;">사원
                        관리 시스템</a>
                </h1>
                <nav>
                    <ul
                        style="list-style: none; margin: 0; padding: 0; display: flex; gap: 2rem;">
                        <li><a href="index.do"
                            style="color: white; text-decoration: none; padding: 0.5rem 1rem; border-radius: 4px; transition: background-color 0.3s;">홈</a>
                        </li>
                        <li><a href="employeeInput.do"
                            style="color: white; text-decoration: none; padding: 0.5rem 1rem; border-radius: 4px; transition: background-color 0.3s;">사원
                                입력</a></li>
                        <li><a href="departmentEmployeeList.do"
                            style="color: white; text-decoration: none; padding: 0.5rem 1rem; border-radius: 4px; transition: background-color 0.3s;">부서별
                                사원조회</a></li>
                    </ul>
                </nav>
            </div>
        </div>
    </header>
</body>
</html>