package com.gd.sakila;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@WebFilter("/admin/*")
public class LoginFilter implements Filter {
	
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		//요청 전
		log.debug("●●●●▶loginFilter 요청 전");
		//매개변수의 타입이 HttpServlet이 아닌 Servlet! 
		
		HttpSession session = null;
		if(request instanceof HttpServletRequest) {	//형변환이 가능하다면 상위:ServletRequest/Response, 하위:HttpServletRequest/Response
			session = ((HttpServletRequest)request).getSession();
		}
		//로그인 필터 개발모드에서는 주석처리
		if(session.getAttribute("loginStaff")==null) {
			if(response instanceof HttpServletResponse) {
				((HttpServletResponse)response).sendRedirect("/");
			}
			return;
		}
		
		
		/* 이전에 했던 방식과 비교해보기
		HttpServletRequest httpRequest = (HttpServletRequest)request;
		HttpServletResponse httpResponse = (HttpServletResponse)response;
		
		HttpSession session = httpRequest.getSession();
		if(session.getAttribute("loginStaff") == null) {
			httpResponse.sendRedirect(httpRequest.getContextPath()+"/");
			return; //새로운 요청발생으로 doFilter메소드 종료
		}*/
		
		chain.doFilter(request, response);
		//요청 후
		log.debug("●●●●▶loginFilter 요청 후");
	}

}
