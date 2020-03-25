package com.niconicomics.core.user.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.niconicomics.core.user.vo.User;

public class AuthorInterceptor extends HandlerInterceptorAdapter {
	private static final Logger logger = LoggerFactory.getLogger(AuthorInterceptor.class);
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		logger.debug("LoginInterceptor 실행");
		
		HttpSession session = request.getSession();
		User loginUser = (User) session.getAttribute("loginUser");
		if(loginUser == null) {
			response.setStatus(401);
			return false;
		}
		if(!loginUser.getType().equals("AUTHOR")) {
			response.setStatus(403);
			return false;
		}

		return super.preHandle(request, response, handler);
	}
}
