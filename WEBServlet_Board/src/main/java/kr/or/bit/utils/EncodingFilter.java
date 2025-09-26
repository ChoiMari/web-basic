package kr.or.bit.utils;

import java.io.IOException;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
/*
 * 서블릿? 웹용자바파일(자바로 만든 웹용 파일)
	 * 서블릿 컨테이너? 웹 요청을 받아서 서블릿(또는 JSP)을 실행해주는 서버 프로그램
	 * 서블릿 컨테이너가 요청을 받아서 적절한 서블릿을 실행
	 * 서블릿 컨테이너가 하는 일
	 * 서블릿 로딩 & 초기화
	 * 요청이 들어오기 전에 web.xml과 애노테이션 기반으로 서블릿을 로딩
	 * init()메서드 호출
	 * 
	 * 요청처리 HTTP 요청을 HttpServletRequest로 객체로 변환
	 * 요청을 적절한 서블릿으로 라우팅
	 * doGet(), doPost() 같은 메서드 호출
	 * 
	 * 응답처리
	 * 서블릿에서 반환한 데이터를 HttpServletResponse 객체로 변환
	 * 
	 * 필터(Filter) 처리
	 * 요청과 응답 사이에서 필터 체인을 실행
	 * 인코딩, 인증, 로깅 등 공통 기능 처리
 */

/**
 * 필터 인터페이스를 구현한 클래스
 * 웹 요청과 응답의 **문자 인코딩(한글 처리)**을 처리하는 필터 역할
 * 서블릿 필터를 구현하기 위한 인터페이스
 * Filter는  doFilter(), init(), destroy() 메서드를 반드시 구현하도록 약속
 */
public class EncodingFilter implements Filter {
	private String encoding = "UTF-8";//원하는 인코딩 설정

	/**
	 * 필터 초기화 시 호출 되는 메서드
	 * 필터가 서블릿 컨테이너에 의해 처음 로딩될 때 단 한 번 실행됨
	 */
	@Override
	public void init(FilterConfig filterConfig) {
		String e = filterConfig.getInitParameter("encoding");
		if (e != null)
			encoding = e;
	}

	@Override
	public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
			throws IOException, ServletException {
		req.setCharacterEncoding(encoding);
		res.setCharacterEncoding(encoding);
		chain.doFilter(req, res);
	}
}