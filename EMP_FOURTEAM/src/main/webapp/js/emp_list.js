// 폼 검증 및 제출
document.getElementById('empForm').addEventListener('submit', function(e) {
    e.preventDefault();
    
    if (validateForm()) {
        // 제출 애니메이션
        const submitBtn = this.querySelector('.btn-submit');
        submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> 등록 중...';
        submitBtn.disabled = true;
        
        setTimeout(() => {
            this.submit();
        }, 1000);
    }
});

// 폼 검증 함수
function validateForm() {
    let isValid = true;
    
    // 필수 필드 검증
    const requiredFields = ['empno', 'ename', 'job', 'sal', 'deptno'];
    
    requiredFields.forEach(field => {
        const input = document.getElementById(field);
        const errorMsg = document.getElementById(field + '-error');
        
        if (!input.value.trim()) {
            showError(input, errorMsg, `${input.previousElementSibling.textContent}을(를) 입력해주세요.`);
            isValid = false;
        } else {
            hideError(input, errorMsg);
        }
    });
    
    // 사원번호 중복 체크 (실제로는 서버에서 처리해야 함)
    const empno = document.getElementById('empno');
    if (empno.value && empno.value.length < 4) {
        showError(empno, document.getElementById('empno-error'), '사원번호는 4자리 이상이어야 합니다.');
        isValid = false;
    }
    
    // 급여 범위 체크
    const sal = document.getElementById('sal');
    if (sal.value && (parseInt(sal.value) < 1000 || parseInt(sal.value) > 999999)) {
        showError(sal, document.getElementById('sal-error'), '급여는 1,000원 이상 999,999원 이하여야 합니다.');
        isValid = false;
    }
    
    return isValid;
}

function showError(input, errorElement, message) {
    input.classList.add('input-error');
    errorElement.textContent = message;
    errorElement.style.display = 'block';
}

function hideError(input, errorElement) {
    input.classList.remove('input-error');
    errorElement.style.display = 'none';
}

// 실시간 검증
document.querySelectorAll('input, select').forEach(input => {
    input.addEventListener('blur', function() {
        const errorMsg = document.getElementById(this.id + '-error');
        if (errorMsg) {
            if (this.hasAttribute('required') && !this.value.trim()) {
                showError(this, errorMsg, `${this.previousElementSibling.textContent}을(를) 입력해주세요.`);
            } else {
                hideError(this, errorMsg);
            }
        }
    });
});

// 숫자 입력 필드 포맷팅
document.getElementById('sal').addEventListener('input', function() {
    this.value = this.value.replace(/[^0-9]/g, '');
    if (this.value) {
        const formattedValue = parseInt(this.value).toLocaleString();
        this.setAttribute('data-formatted', formattedValue + '원');
    }
});

document.getElementById('comm').addEventListener('input', function() {
    this.value = this.value.replace(/[^0-9]/g, '');
});

// 초기화 버튼
document.querySelector('.btn-reset').addEventListener('click', function() {
    if (confirm('입력한 모든 내용이 초기화됩니다. 계속하시겠습니까?')) {
        document.querySelectorAll('.input-error').forEach(input => {
            input.classList.remove('input-error');
        });
        document.querySelectorAll('.validation-message').forEach(msg => {
            msg.style.display = 'none';
        });
        
        // 애니메이션 효과
        document.querySelectorAll('input, select').forEach((field, index) => {
            setTimeout(() => {
                field.style.transform = 'scale(0.95)';
                setTimeout(() => {
                    field.style.transform = 'scale(1)';
                }, 100);
            }, index * 50);
        });
    } else {
        return false;
    }
});

// 페이지 로드 애니메이션
window.addEventListener('load', function() {
    document.querySelectorAll('.form-section').forEach((section, index) => {
        section.style.animation = `slideInUp 0.6s ease-out ${index * 0.15 + 0.3}s both`;
    });
    
    document.querySelectorAll('input, select').forEach(field => {
        field.addEventListener('focus', function() {
            this.parentElement.style.transform = 'translateY(-2px)';
        });
        
        field.addEventListener('blur', function() {
            this.parentElement.style.transform = 'translateY(0)';
        });
    });
});

// 직책 선택 시 추천 급여 표시
document.getElementById('job').addEventListener('change', function() {
    const salInput = document.getElementById('sal');
    const jobSalaryGuide = {
        'CLERK': '2500',
        'SALESMAN': '3000',
        'ANALYST': '4000',
        'MANAGER': '5000',
        'PRESIDENT': '8000'
    };
    
    if (this.value && jobSalaryGuide[this.value]) {
        if (!salInput.value) {
            salInput.placeholder = `추천 급여: ${jobSalaryGuide[this.value]}`;
            salInput.style.borderColor = '#4ecdc4';
            setTimeout(() => {
                salInput.style.borderColor = '#e0e0e0';
            }, 2000);
        }
    }
});

// 부서 선택 시 관련 정보 표시
document.getElementById('deptno').addEventListener('change', function() {
    const deptInfo = {
        '10': '회계 업무를 담당합니다',
        '20': '연구개발 업무를 담당합니다',
        '30': '영업 업무를 담당합니다',
        '40': '운영 업무를 담당합니다'
    };
    
    if (this.value && deptInfo[this.value]) {
        // 임시 툴팁 표시
        const tooltip = document.createElement('div');
        tooltip.textContent = deptInfo[this.value];
        tooltip.style.cssText = `
            position: absolute;
            background: #333;
            color: white;
            padding: 8px 12px;
            border-radius: 6px;
            font-size: 12px;
            top: -35px;
            left: 50%;
            transform: translateX(-50%);
            white-space: nowrap;
            z-index: 1000;
        `;
        
        this.parentElement.style.position = 'relative';
        this.parentElement.appendChild(tooltip);
        
        setTimeout(() => {
            if (tooltip.parentElement) {
                tooltip.parentElement.removeChild(tooltip);
            }
        }, 3000);
    }
});

// 입력 필드 자동 완성 효과
document.querySelectorAll('input[type="text"], input[type="number"]').forEach(input => {
    input.addEventListener('keyup', function() {
        if (this.value.length > 0) {
            this.style.background = 'linear-gradient(135deg, #f8f9ff 0%, #ffffff 100%)';
        } else {
            this.style.background = 'white';
        }
    });
});