package com.malangstore.interceptor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * Interceptor 등록(Interceptor를 등록한 후 적용할 경로, 제외할 경로를 지정 가능)
 */
@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

	@Autowired
	@Qualifier(value = "loginInterceptor")
	private HandlerInterceptor loginInterceptor;

	@Autowired
	@Qualifier(value = "authorityInterceptor")
	private HandlerInterceptor authorityInterceptor;

	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(authorityInterceptor)
				.addPathPatterns("/registProducts/**");
		registry.addInterceptor(loginInterceptor)
				.addPathPatterns("/**")
				.excludePathPatterns("/res/**", "/", "/joinForm/**", "/join/**", "/isDuplicate/**", "/loginForm/**", "/login/**", "/logout/**", "/categories/**", "/productList/**", "/products/**", "/productDetail/**");
	}
}
