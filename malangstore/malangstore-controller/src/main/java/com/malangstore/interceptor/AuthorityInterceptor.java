package com.malangstore.interceptor;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Component("authorityInterceptor")
public class AuthorityInterceptor implements HandlerInterceptor {

	private final Logger logger = LoggerFactory.getLogger(AuthorityInterceptor.class);

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		logger.info("[AuthorityInterceptor] : preHandle()");

		HttpSession session = request.getSession();
		Object authority = session.getAttribute("authority");

		if(authority == null) {
			request.setAttribute("msg", "로그인이 필요한 서비스입니다.");
			RequestDispatcher dis = request.getRequestDispatcher("loginForm");
			dis.forward(request, response);
			return false;
		} else if(authority.equals("user")) {
			request.setAttribute("msg", "관리자만 접근 가능한 서비스입니다.");
			RequestDispatcher dis = request.getRequestDispatcher("/");
			dis.forward(request, response);
			return false;
		}

		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
		// logger.info("Method Excuted");      // Mapping 된 후 처리
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
		// logger.info("Method Complete");     // 모든 작업이 완료된 후 실행
	}
}
