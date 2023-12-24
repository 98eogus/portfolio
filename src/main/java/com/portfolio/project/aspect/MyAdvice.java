package com.portfolio.project.aspect;

import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Aspect
@Component
public class MyAdvice {

    @Before("execution(* com.portfolio.project.controller.RegisterController.list(..)) && args(request)")
    public void beforeListMethodExecution(HttpServletRequest request) {
        System.out.println("aop적용했음");

        if (!loginCheck(request)) {
            System.out.println("로그인이 필요합니다.");
            throw new RuntimeException("로그인하고 이용해주세요.");
        }
    }



    private boolean loginCheck(HttpServletRequest request) {
        // 1. 세션을 얻어서
        HttpSession session = request.getSession();
        // 2. 세션에 id가 있는지 확인, 있으면 true를 반환
        return session.getAttribute("id") != null;
    }


}
