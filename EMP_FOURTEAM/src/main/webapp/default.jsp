<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>💖 4-TEAM 사원 관리 시스템 💖</title>
<link href="https://fonts.googleapis.com/css2?family=Cute+Font&family=Noto+Sans+KR:wght@300;400;500;700;800&display=swap" rel="stylesheet">
<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }
    
    body {
        font-family: 'Noto Sans KR', sans-serif;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 50%, #667eea 100%);
        min-height: 100vh;
        overflow-x: hidden;
    }
    
    /* 배경 애니메이션 */
    .bg-animation {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        z-index: -1;
        overflow: hidden;
    }
    
    .floating-hearts {
        position: absolute;
        font-size: 20px;
        animation: floatHearts 15s linear infinite;
        opacity: 0.6;
    }
    
    @keyframes floatHearts {
        0% {
            transform: translateY(100vh) rotate(0deg);
            opacity: 0.6;
        }
        100% {
            transform: translateY(-100px) rotate(360deg);
            opacity: 0;
        }
    }
    
    /* 메인 컨테이너 */
    .main-container {
        display: flex;
        flex-direction: column;
        min-height: 100vh;
        position: relative;
        z-index: 1;
    }
    
    /* 헤로 섹션 */
    .hero-section {
        flex: 1;
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 50px 20px;
        text-align: center;
    }
    
    .hero-content {
        background: rgba(255, 255, 255, 0.95);
        border-radius: 30px;
        padding: 60px 50px;
        box-shadow: 0 30px 60px rgba(0,0,0,0.2);
        backdrop-filter: blur(20px);
        border: 2px solid rgba(255, 255, 255, 0.3);
        max-width: 800px;
        width: 100%;
        position: relative;
        overflow: hidden;
        animation: slideInUp 1s ease-out;
    }
    
    .hero-content::before {
        content: '';
        position: absolute;
        top: -50%;
        left: -50%;
        width: 200%;
        height: 200%;
        background: radial-gradient(circle, rgba(102, 126, 234, 0.1) 0%, transparent 70%);
        animation: rotate 10s linear infinite;
        pointer-events: none;
    }
    
    @keyframes rotate {
        0% { transform: rotate(0deg); }
        100% { transform: rotate(360deg); }
    }
    
    .hero-title {
        font-family: 'Cute Font', cursive;
        font-size: 3.5em;
        background: linear-gradient(45deg, #667eea, #764ba2, #ff6b6b);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        background-clip: text;
        margin-bottom: 20px;
        position: relative;
        z-index: 2;
        text-shadow: 2px 2px 4px rgba(0,0,0,0.1);
    }
    
    .hero-subtitle {
        font-size: 1.4em;
        color: #555;
        margin-bottom: 40px;
        line-height: 1.6;
        position: relative;
        z-index: 2;
    }
    
    .cta-buttons {
        display: flex;
        gap: 20px;
        justify-content: center;
        flex-wrap: wrap;
        position: relative;
        z-index: 2;
    }
    
    .cta-btn {
        display: inline-flex;
        align-items: center;
        gap: 10px;
        padding: 18px 35px;
        text-decoration: none;
        border-radius: 50px;
        font-weight: 600;
        font-size: 1.1em;
        transition: all 0.3s ease;
        position: relative;
        overflow: hidden;
        min-width: 200px;
        justify-content: center;
    }
    
    .cta-btn::before {
        content: '';
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 100%;
        background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent);
        transition: left 0.5s;
    }
    
    .cta-btn:hover::before {
        left: 100%;
    }
    
    .btn-primary {
        background: linear-gradient(45deg, #667eea, #764ba2);
        color: white;
        box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);
    }
    
    .btn-secondary {
        background: linear-gradient(45deg, #ff6b6b, #ffa500);
        color: white;
        box-shadow: 0 8px 25px rgba(255, 107, 107, 0.4);
    }
    
    .cta-btn:hover {
        transform: translateY(-5px) scale(1.05);
        box-shadow: 0 15px 35px rgba(0,0,0,0.3);
        text-decoration: none;
        color: white;
    }
    
    /* 특징 섹션 */
    .features-section {
        padding: 60px 20px;
        background: rgba(255, 255, 255, 0.1);
        backdrop-filter: blur(10px);
    }
    
    .features-container {
        max-width: 1200px;
        margin: 0 auto;
    }
    
    .features-title {
        text-align: center;
        font-size: 2.5em;
        color: white;
        margin-bottom: 50px;
        font-weight: 700;
        text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
    }
    
    .features-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
        gap: 30px;
    }
    
    .feature-card {
        background: rgba(255, 255, 255, 0.9);
        border-radius: 20px;
        padding: 40px 30px;
        text-align: center;
        box-shadow: 0 15px 35px rgba(0,0,0,0.15);
        transition: all 0.3s ease;
        position: relative;
        overflow: hidden;
    }
    
    .feature-card::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        height: 5px;
        background: linear-gradient(45deg, #667eea, #764ba2, #ff6b6b, #ffa500);
    }
    
    .feature-card:hover {
        transform: translateY(-10px);
        box-shadow: 0 25px 45px rgba(0,0,0,0.2);
    }
    
    .feature-icon {
        font-size: 4em;
        margin-bottom: 20px;
        display: block;
        animation: bounce 2s ease-in-out infinite;
    }
    
    .feature-card:nth-child(2) .feature-icon { animation-delay: 0.5s; }
    .feature-card:nth-child(3) .feature-icon { animation-delay: 1s; }
    
    @keyframes bounce {
        0%, 100% { transform: translateY(0); }
        50% { transform: translateY(-10px); }
    }
    
    .feature-title {
        font-size: 1.5em;
        font-weight: 700;
        color: #333;
        margin-bottom: 15px;
    }
    
    .feature-description {
        color: #666;
        line-height: 1.6;
        font-size: 1.1em;
    }
    
    /* 반응형 */
    @media (max-width: 768px) {
        .hero-title {
            font-size: 2.5em;
        }
        
        .hero-subtitle {
            font-size: 1.2em;
        }
        
        .hero-content {
            padding: 40px 30px;
            margin: 20px;
        }
        
        .cta-buttons {
            flex-direction: column;
            align-items: center;
        }
        
        .cta-btn {
            width: 100%;
            max-width: 300px;
        }
        
        .features-title {
            font-size: 2em;
        }
        
        .features-grid {
            grid-template-columns: 1fr;
        }
    }
    
    @media (max-width: 480px) {
        .hero-title {
            font-size: 2em;
        }
        
        .hero-content {
            padding: 30px 20px;
        }
        
        .feature-card {
            padding: 30px 20px;
        }
    }
    
    /* 애니메이션 */
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
    
    .feature-card {
        animation: slideInUp 0.8s ease-out;
    }
    
    .feature-card:nth-child(2) { animation-delay: 0.2s; }
    .feature-card:nth-child(3) { animation-delay: 0.4s; }
</style>
</head>
<body>
    <!-- 배경 애니메이션 -->
    <div class="bg-animation">
        <div class="floating-hearts" style="left: 10%; animation-delay: 0s;">💖</div>
        <div class="floating-hearts" style="left: 20%; animation-delay: 2s;">✨</div>
        <div class="floating-hearts" style="left: 30%; animation-delay: 4s;">💝</div>
        <div class="floating-hearts" style="left: 40%; animation-delay: 6s;">⭐</div>
        <div class="floating-hearts" style="left: 50%; animation-delay: 8s;">🌟</div>
        <div class="floating-hearts" style="left: 60%; animation-delay: 10s;">💫</div>
        <div class="floating-hearts" style="left: 70%; animation-delay: 12s;">🎉</div>
        <div class="floating-hearts" style="left: 80%; animation-delay: 14s;">💕</div>
        <div class="floating-hearts" style="left: 90%; animation-delay: 16s;">🎊</div>
    </div>

    <div class="main-container">
        <!-- 헤더 포함 -->
        <jsp:include page="/header.jsp"/>
        
        <!-- 히어로 섹션 -->
        <section class="hero-section">
            <div class="hero-content">
                <h1 class="hero-title">💖 4-TEAM 사원 관리 시스템 💖</h1>
                <p class="hero-subtitle">
                    우리 회사의 소중한 사원들을 체계적으로 관리하고,<br>
                    함께 성장하는 아름다운 워크플레이스를 만들어가세요! 🌟
                </p>
                <div class="cta-buttons">
                    <a href="emplist.do" class="cta-btn btn-primary">
                        👥 우리 사원들 보기
                    </a>
                    <a href="emp.do" class="cta-btn btn-secondary">
                        ➕ 새 사원 등록하기
                    </a>
                </div>
            </div>
        </section>
        
        <!-- 특징 섹션 -->
        <section class="features-section">
            <div class="features-container">
                <h2 class="features-title">🌟 우리 시스템의 특별한 기능들 🌟</h2>
                <div class="features-grid">
                    <div class="feature-card">
                        <span class="feature-icon">👥</span>
                        <h3 class="feature-title">사원 목록 관리</h3>
                        <p class="feature-description">
                            우리 팀의 모든 사원들을 한눈에 보고, 각자의 정보를 쉽게 확인할 수 있어요!
                            카드 형태로 예쁘게 정리되어 있답니다. 💕
                        </p>
                    </div>
                    
                    <div class="feature-card">
                        <span class="feature-icon">✏️</span>
                        <h3 class="feature-title">손쉬운 정보 관리</h3>
                        <p class="feature-description">
                            신입 사원 등록부터 기존 정보 수정까지! 
                            직관적이고 사용하기 쉬운 인터페이스로 누구나 쉽게 관리할 수 있어요. 🎯
                        </p>
                    </div>
                    
                    <div class="feature-card">
                        <span class="feature-icon">💖</span>
                        <h3 class="feature-title">사랑스러운 디자인</h3>
                        <p class="feature-description">
                            지루한 관리 시스템은 그만! 
                            사랑스럽고 기깔나는 디자인으로 업무도 즐겁게 할 수 있어요. ✨
                        </p>
                    </div>
                </div>
            </div>
        </section>
        
        <!-- 통계 섹션 -->
        <section class="stats-section">
            <div class="stats-container">
                <h2 class="stats-title">📊 우리 회사 현황 📊</h2>
                <div class="stats-grid">
                    <div class="stat-card">
                        <div class="stat-icon">👤</div>
                        <div class="stat-number" id="totalEmployees">-</div>
                        <div class="stat-label">총 직원 수</div>
                    </div>
                    
                    <div class="stat-card">
                        <div class="stat-icon">🏢</div>
                        <div class="stat-number" id="totalDepartments">-</div>
                        <div class="stat-label">활성 부서</div>
                    </div>
                    
                    <div class="stat-card">
                        <div class="stat-icon">⭐</div>
                        <div class="stat-number" id="avgSalary">-</div>
                        <div class="stat-label">평균 급여</div>
                    </div>
                    
                    <div class="stat-card">
                        <div class="stat-icon">🎉</div>
                        <div class="stat-number">100%</div>
                        <div class="stat-label">행복지수</div>
                    </div>
                </div>
            </div>
        </section>
    </div>

    <style>
        /* 통계 섹션 스타일 */
        .stats-section {
            padding: 60px 20px;
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(10px);
        }
        
        .stats-container {
            max-width: 1200px;
            margin: 0 auto;
        }
        
        .stats-title {
            text-align: center;
            font-size: 2.5em;
            color: white;
            margin-bottom: 50px;
            font-weight: 700;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
        }
        
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 30px;
        }
        
        .stat-card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 40px 20px;
            text-align: center;
            box-shadow: 0 15px 35px rgba(0,0,0,0.15);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }
        
        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 5px;
            background: linear-gradient(45deg, #43e97b, #38f9d7);
        }
        
        .stat-card:hover {
            transform: translateY(-10px) scale(1.05);
            box-shadow: 0 25px 45px rgba(0,0,0,0.2);
        }
        
        .stat-icon {
            font-size: 3em;
            margin-bottom: 15px;
            display: block;
        }
        
        .stat-number {
            font-size: 2.5em;
            font-weight: 800;
            color: #333;
            margin-bottom: 10px;
            background: linear-gradient(45deg, #667eea, #764ba2);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }
        
        .stat-label {
            color: #666;
            font-size: 1.1em;
            font-weight: 500;
        }
    </style>
    
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // 통계 애니메이션
            function animateNumber(element, target) {
                let current = 0;
                const increment = target / 100;
                const timer = setInterval(() => {
                    current += increment;
                    if (current >= target) {
                        current = target;
                        clearInterval(timer);
                    }
                    element.textContent = Math.floor(current);
                }, 20);
            }
            
            // 관찰자 API로 스크롤 시 애니메이션 실행
            const observer = new IntersectionObserver((entries) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        // 실제 데이터를 가져올 수 있다면 AJAX로 가져오기
                        // 여기서는 예시 데이터 사용
                        animateNumber(document.getElementById('totalEmployees'), 25);
                        animateNumber(document.getElementById('totalDepartments'), 5);
                        
                        // 평균 급여는 특별 처리
                        const avgSalaryEl = document.getElementById('avgSalary');
                        let salary = 0;
                        const salaryTimer = setInterval(() => {
                            salary += 100000;
                            if (salary >= 3500000) {
                                salary = 3500000;
                                clearInterval(salaryTimer);
                            }
                            avgSalaryEl.textContent = salary.toLocaleString() + '원';
                        }, 30);
                        
                        observer.unobserve(entry.target);
                    }
                });
            });
            
            const statsSection = document.querySelector('.stats-section');
            if (statsSection) {
                observer.observe(statsSection);
            }
            
            // 랜덤 색상 변경 애니메이션
            const cards = document.querySelectorAll('.feature-card, .stat-card');
            cards.forEach((card, index) => {
                card.addEventListener('mouseenter', function() {
                    const colors = [
                        'linear-gradient(45deg, #667eea, #764ba2)',
                        'linear-gradient(45deg, #ff6b6b, #ffa500)',
                        'linear-gradient(45deg, #43e97b, #38f9d7)',
                        'linear-gradient(45deg, #4facfe, #00f2fe)'
                    ];
                    const randomColor = colors[Math.floor(Math.random() * colors.length)];
                    this.querySelector('::before') && (this.style.setProperty('--hover-gradient', randomColor));
                });
            });
            
            /*
            // 페이지 로드 환영 메시지
            setTimeout(() => {
                if (confirm('🎉 4-TEAM 사원 관리 시스템에 오신 것을 환영합니다! 🎉\n직원 목록을 바로 확인해보시겠어요?')) {
                    window.location.href = 'emplist.do';
                }
            }, 2000);
            */
            // 키보드 단축키
            document.addEventListener('keydown', function(e) {
                if (e.ctrlKey && e.key === '1') {
                    e.preventDefault();
                    window.location.href = 'emplist.do';
                } else if (e.ctrlKey && e.key === '2') {
                    e.preventDefault();
                    window.location.href = 'emp.do';
                }
            });
            
            // Easter Egg - 더블클릭시 특별 효과
            let clickCount = 0;
            document.querySelector('.hero-title').addEventListener('click', function() {
                clickCount++;
                if (clickCount === 5) {
                    this.style.animation = 'rainbow 2s ease-in-out infinite';
                    document.body.style.animation = 'party 3s ease-in-out';
                    
                    // 파티 효과
                    for (let i = 0; i < 20; i++) {
                        setTimeout(() => {
                            createParticle();
                        }, i * 100);
                    }
                    
                    setTimeout(() => {
                        clickCount = 0;
                        this.style.animation = '';
                        document.body.style.animation = '';
                    }, 3000);
                }
            });
            
            function createParticle() {
                const particle = document.createElement('div');
                const emojis = ['🎉', '🎊', '✨', '💖', '⭐', '🌟', '💫'];
                particle.textContent = emojis[Math.floor(Math.random() * emojis.length)];
                particle.style.cssText = `
                    position: fixed;
                    z-index: 9999;
                    font-size: 30px;
                    pointer-events: none;
                    left: ${Math.random() * 100}vw;
                    top: ${Math.random() * 100}vh;
                    animation: explode 2s ease-out forwards;
                `;
                document.body.appendChild(particle);
                setTimeout(() => particle.remove(), 2000);
            }
        });
    </script>
    
    <style>
        @keyframes rainbow {
            0% { filter: hue-rotate(0deg); }
            100% { filter: hue-rotate(360deg); }
        }
        
        @keyframes party {
            0%, 100% { transform: scale(1); }
            25% { transform: scale(1.02) rotate(1deg); }
            75% { transform: scale(0.98) rotate(-1deg); }
        }
        
        @keyframes explode {
            0% {
                transform: scale(0) rotate(0deg);
                opacity: 1;
            }
            100% {
                transform: scale(1) rotate(360deg) translateY(-200px);
                opacity: 0;
            }
        }
        
        /* 추가 호버 효과 */
        .cta-btn:active {
            transform: translateY(-3px) scale(0.95);
        }
        
        .feature-card:hover .feature-icon,
        .stat-card:hover .stat-icon {
            transform: scale(1.2) rotate(360deg);
            transition: transform 0.5s ease;
        }
    </style>
</body>
</html>