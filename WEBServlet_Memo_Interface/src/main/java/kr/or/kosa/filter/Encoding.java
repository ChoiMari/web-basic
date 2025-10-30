package kr.or.kosa.filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.annotation.WebInitParam;
import jakarta.servlet.http.HttpFilter;
import java.io.IOException;


@WebFilter(
	    description = "어노테이션 활용 필터 적용하기",
	    urlPatterns = {"/*"},
	    initParams = {@WebInitParam(name="encoding" , value="UTF-8")}
	  )
public class Encoding extends HttpFilter implements Filter {
    
	private String encoding;
	
	public void init(FilterConfig fConfig) throws ServletException {
		this.encoding = fConfig.getInitParameter("encoding");	
		
	}

    public Encoding() {
        super();
        // TODO Auto-generated constructor stub
    }

	public void destroy() {
		// TODO Auto-generated method stub
	}


	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		//필터는 AOP 구현
		if(request.getCharacterEncoding() == null) {
			request.setCharacterEncoding(this.encoding);
		}
		System.out.println("이 영역은 내 웹 접근 시 urlPatterns = {*} 로 설정하여 거친다.");
		//컨트롤러 서블릿에서 이제 한글처리가 필요없음
		chain.doFilter(request, response);
	}



}
