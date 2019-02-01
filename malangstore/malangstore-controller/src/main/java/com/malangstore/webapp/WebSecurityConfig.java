package com.malangstore.webapp;

import com.malangstore.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;

@Configuration
@EnableWebSecurity
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {

    @Autowired
    MemberService memberService;

    @Override
    public void configure(WebSecurity web) throws Exception {
        web.ignoring().antMatchers("/**");      // 모든 페이지 비인증 처리(spring security)
    }

    /*@Override
    protected void configure(HttpSecurity http) throws Exception {
        http.csrf().disable()
            .authorizeRequests()
                .antMatchers("/**").permitAll()
                .and()
                .formLogin()
                .loginPage("/login")
                .loginProcessingUrl("/loginForm")
                .usernameParameter("id")
                .passwordParameter("password")
                .and()
                .logout()
                .logoutUrl("/logout")
                .and()
                .authenticationProvider(authProvider);

            .authorizeRequests()
            .antMatchers("/", "/joinForm").permitAll()
            .anyRequest().authenticated()
                .and()
            .formLogin()
                .loginPage("/loginForm")
                .permitAll()
                .usernameParameter("id")
                .passwordParameter("pw")
                .loginProcessingUrl("/login")   // 로그인 페이지 form action에 입력할 주소
                .defaultSuccessUrl("/")         // 로그인이 성공했을 경우 호출할 주소
                .failureUrl("/loginForm")       // 로그인이 실패했을 경우 호출할 주소
                .and()
            .sessionManagement()
                .invalidSessionUrl("/login")        // 세션이 끊겼을 때 이동할 페이지
                .sessionFixation().migrateSession() // 세션 고정 공격 방지
                .and()
            .logout()
                .logoutSuccessUrl("/")
                .permitAll();
    }*/

    @Bean
    public PasswordEncoder passwordEncoder() {
        return PasswordEncoderFactories.createDelegatingPasswordEncoder();
    }
}
