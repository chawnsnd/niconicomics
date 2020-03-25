package com.niconicomics.core.user.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginInterceptor extends HandlerInterceptorAdapter {
	private static final Logger logger = LoggerFactory.getLogger(LoginInterceptor.class);
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		logger.debug("LoginInterceptor 실행");
		
		HttpSession session = request.getSession();
		String loginEmail = (String) session.getAttribute("loginEmail");
		
		if(loginEmail == null) {
			response.sendRedirect(request.getContextPath() + "/users/login");
			return false;
		}

		return super.preHandle(request, response, handler);
	}
}
