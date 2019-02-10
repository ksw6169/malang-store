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

@Component("loginInterceptor")
public class LoginInterceptor implements HandlerInterceptor {

	private final Logger logger = LoggerFactory.getLogger(LoginInterceptor.class);

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		logger.info("[loginInterceptor] : preHandle()");

		HttpSession session = request.getSession();
		Object id = session.getAttribute("loginId");

		if(id == null) {
			request.setAttribute("msg", "로그인이 필요한 서비스입니다.");
			RequestDispatcher dis = request.getRequestDispatcher("loginForm");
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
