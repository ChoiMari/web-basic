<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>💖 4-TEAM 💖</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-SgOJa3DmI69IUzQ2PVdRZhwQ+dy64/BUtbMJw1MZ8t5HZApcHrRKUc4W0kG879m7" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/js/bootstrap.bundle.min.js" integrity="sha384-k6d4wzSIapyDyv1kpU366/PK5hCdSbCRGRCMv+eplOQJWyd1fbcAu9OCUj5zNLiq" crossorigin="anonymous"></script>
<link href="https://fonts.googleapis.com/css2?family=Cute+Font&family=Noto+Sans+KR:wght@300;400;500;700;800&display=swap" rel="stylesheet">
<style>
    :root {
        --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        --secondary-gradient: linear-gradient(45deg, #ff6b6b, #ffa500);
        --accent-gradient: linear-gradient(45deg, #4facfe, #00f2fe);
        --success-gradient: linear-gradient(45deg, #43e97b, #38f9d7);
    }
    
    body {
        font-family: 'Noto Sans KR', sans-serif;
        margin: 0;
        padding: 0;
    }
    
    /* 네비게이션 컨테이너 */
    .navbar-container {
        background: var(--primary-gradient);
        box-shadow: 0 8px 32px rgba(31, 38, 135, 0.37);
        backdrop-filter: blur(8px);
        border-bottom: 1px solid rgba(255, 255, 255, 0.18);
        position: relative;
        overflow: hidden;
    }
    
    /* 배경 애니메이션 요소들 */
    .navbar-container::before {
        content: '';
        position: absolute;
        top: -50%;
        left: -50%;
        width: 200%;
        height: 200%;
        background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%);
        animation: float-bg 6s ease-in-out infinite;
        pointer-events: none;
    }
    
    .navbar-container::after {
        content: '✨💫⭐🌟💖';
        position: absolute;
        top: 10px;
        right: 20px;
        font-size: 20px;
        opacity: 0.3;
        animation: twinkle 3s ease-in-out infinite;
        pointer-events: none;
        z-index: 1;
    }
    
    @keyframes float-bg {
        0%, 100% { transform: translate(-50%, -50%) rotate(0deg); }
        50% { transform: translate(-45%, -45%) rotate(180deg); }
    }
    
    @keyframes twinkle {
        0%, 100% { opacity: 0.3; transform: scale(1); }
        50% { opacity: 0.7; transform: scale(1.1); }
    }
    
    /* 네비게이션 바 스타일 */
    .custom-navbar {
        background: transparent !important;
        padding: 15px 0;
        position: relative;
        z-index: 10;
    }
    
    /* 브랜드 로고 */
    .navbar-brand {
        font-family: 'Cute Font', cursive !important;
        font-size: 2.2em !important;
        font-weight: 800 !important;
        background: linear-gradient(45deg, #fff, #f0f8ff);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        background-clip: text;
        text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
        padding: 10px 20px;
        border-radius: 25px;
        background-color: rgba(255, 255, 255, 0.1);
        backdrop-filter: blur(10px);
        transition: all 0.3s ease;
        position: relative;
        overflow: hidden;
    }
    
    .navbar-brand::before {
        content: '';
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 100%;
        background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent);
        transition: left 0.6s;
    }
    
    .navbar-brand:hover::before {
        left: 100%;
    }
    
    .navbar-brand:hover {
        transform: translateY(-3px) scale(1.05);
        background-color: rgba(255, 255, 255, 0.2);
        box-shadow: 0 10px 25px rgba(0,0,0,0.2);
    }
    
    /* 네비게이션 메뉴 */
    .navbar-nav .nav-link {
        color: white !important;
        font-weight: 500 !important;
        font-size: 1.1em !important;
        padding: 12px 25px !important;
        margin: 0 8px;
        border-radius: 25px;
        transition: all 0.3s ease;
        position: relative;
        overflow: hidden;
        background: rgba(255, 255, 255, 0.1);
        backdrop-filter: blur(5px);
    }
    
    .navbar-nav .nav-link::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: var(--secondary-gradient);
        opacity: 0;
        transition: opacity 0.3s ease;
        border-radius: 25px;
        z-index: -1;
    }
    
    .navbar-nav .nav-link:hover::before,
    .navbar-nav .nav-link.active::before {
        opacity: 1;
    }
    
    .navbar-nav .nav-link:hover,
    .navbar-nav .nav-link.active {
        transform: translateY(-3px);
        box-shadow: 0 8px 25px rgba(0,0,0,0.3);
        color: white !important;
    }
    
    /* 아이콘 추가 */
    .nav-link[href*="emplist"]::before {
        content: '👥 ';
        font-size: 1.2em;
        margin-right: 5px;
    }
    
    .nav-link[href*="emp.do"]::before {
        content: '➕ ';
        font-size: 1.2em;
        margin-right: 5px;
    }
    
    /* 토글 버튼 스타일링 */
    .navbar-toggler {
        border: 2px solid rgba(255, 255, 255, 0.3) !important;
        border-radius: 15px !important;
        padding: 8px 12px !important;
        background: rgba(255, 255, 255, 0.1);
        backdrop-filter: blur(10px);
        transition: all 0.3s ease;
    }
    
    .navbar-toggler:hover {
        background: rgba(255, 255, 255, 0.2);
        transform: scale(1.1);
    }
    
    .navbar-toggler-icon {
        background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 30 30'%3e%3cpath stroke='rgba%28255, 255, 255, 1%29' stroke-linecap='round' stroke-miterlimit='10' stroke-width='2' d='m4 7h22M4 15h22M4 23h22'/%3e%3c/svg%3e") !important;
    }
    
    /* 네비게이션 메뉴 컬랩스 */
    .navbar-collapse {
        background: rgba(255, 255, 255, 0.1);
        backdrop-filter: blur(15px);
        border-radius: 20px;
        margin-top: 15px;
        padding: 20px;
        border: 1px solid rgba(255, 255, 255, 0.2);
    }
    
    /* 반응형 처리 */
    @media (max-width: 991px) {
        .navbar-brand {
            font-size: 1.8em !important;
        }
        
        .navbar-nav .nav-link {
            text-align: center;
            margin: 5px 0;
        }
        
        .navbar-container::after {
            display: none;
        }
    }
    
    @media (max-width: 576px) {
        .navbar-brand {
            font-size: 1.5em !important;
            padding: 8px 15px;
        }
        
        .custom-navbar {
            padding: 10px 0;
        }
    }
    
    /* 로딩 애니메이션 */
    @keyframes slideInDown {
        from {
            opacity: 0;
            transform: translateY(-30px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }
    
    .custom-navbar {
        animation: slideInDown 0.8s ease-out;
    }
    
    /* 호버 효과를 위한 추가 애니메이션 */
    @keyframes pulse {
        0% { box-shadow: 0 0 0 0 rgba(255, 255, 255, 0.7); }
        70% { box-shadow: 0 0 0 10px rgba(255, 255, 255, 0); }
        100% { box-shadow: 0 0 0 0 rgba(255, 255, 255, 0); }
    }
    
    .navbar-brand:hover {
        animation: pulse 1.5s infinite;
    }
    
    /* 글리터 효과 */
    .glitter {
        position: absolute;
        width: 100%;
        height: 100%;
        overflow: hidden;
        top: 0;
        left: 0;
        pointer-events: none;
    }
    
    .glitter::before,
    .glitter::after {
        content: '✨';
        position: absolute;
        color: rgba(255, 255, 255, 0.8);
        animation: sparkle 2s linear infinite;
    }
    
    .glitter::before {
        left: 20%;
        animation-delay: 0s;
    }
    
    .glitter::after {
        left: 80%;
        animation-delay: 1s;
    }
    
    @keyframes sparkle {
        0% {
            opacity: 0;
            transform: translateY(0) scale(0);
        }
        50% {
            opacity: 1;
            transform: translateY(-20px) scale(1);
        }
        100% {
            opacity: 0;
            transform: translateY(-40px) scale(0);
        }
    }
</style>
</head>
<body>
<div class="navbar-container">
    <div class="glitter"></div>
    <nav class="navbar navbar-expand-lg custom-navbar">
        <div class="container-fluid px-4">
            <a class="navbar-brand" href="default.jsp" data-bs-toggle="tooltip" title="⭐유정⭐하영⭐마리⭐">
                💖 4-TEAM 💖
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" 
                    aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="emplist.do" 
                           data-bs-toggle="tooltip" title="우리 사원들을 만나보세요!">
                            사원 목록보기
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="emp.do" 
                           data-bs-toggle="tooltip" title="새로운 사원을 맞이해요!">
                            사원 등록하기
                        </a>
                    </li>
                </ul>
                <div class="d-flex align-items-center">
                    <span class="text-white me-3" style="font-size: 0.9em; opacity: 0.8;">
                        🌟 함께 성장하는 우리 팀 🌟
                    </span>
                </div>
            </div>
        </div>
    </nav>
</div>

<script>
// 툴팁 초기화
document.addEventListener('DOMContentLoaded', function() {
    var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
    var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl, {
            placement: 'bottom'
        });
    });
    
    // 현재 페이지에 따른 active 상태 설정
    const currentPath = window.location.pathname;
    const navLinks = document.querySelectorAll('.nav-link');
    
    navLinks.forEach(link => {
        link.classList.remove('active');
        const href = link.getAttribute('href');
        if (currentPath.includes(href.replace('.do', ''))) {
            link.classList.add('active');
        }
    });
    
    // 네비게이션 링크 호버 효과
    navLinks.forEach(link => {
        link.addEventListener('mouseenter', function() {
            this.style.transform = 'translateY(-5px) scale(1.05)';
        });
        
        link.addEventListener('mouseleave', function() {
            if (!this.classList.contains('active')) {
                this.style.transform = 'translateY(0) scale(1)';
            }
        });
    });
    
    // 랜덤 이모지 효과
    const emojis = ['✨', '💫', '⭐', '🌟', '💖', '💝', '🎉', '🎊'];
    
    function createFloatingEmoji() {
        const emoji = document.createElement('div');
        emoji.textContent = emojis[Math.floor(Math.random() * emojis.length)];
        emoji.style.cssText = `
            position: fixed;
            z-index: 1000;
            font-size: 20px;
            pointer-events: none;
            animation: floatUp 3s ease-out forwards;
            left: ${Math.random() * 100}vw;
            top: 100vh;
        `;
        
        document.body.appendChild(emoji);
        
        setTimeout(() => {
            emoji.remove();
        }, 3000);
    }
    
    // 랜덤 이모지 생성
    setInterval(createFloatingEmoji, 5000);
});

// CSS 애니메이션 추가
const style = document.createElement('style');
style.textContent = `
    @keyframes floatUp {
        to {
            transform: translateY(-100vh) rotate(360deg);
            opacity: 0;
        }
    }
`;
document.head.appendChild(style);
</script>
</body>
</html>