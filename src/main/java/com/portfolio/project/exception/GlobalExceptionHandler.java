package com.portfolio.project.exception;

import org.springframework.http.HttpStatus;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

@ControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(RuntimeException.class)
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    public ModelAndView handleRuntimeException(RuntimeException ex, HttpServletRequest request, Model model) {
        String redirectUrl = "redirect:/login/login?toURL=" + request.getRequestURL();
        model.addAttribute("error", ex.getMessage()); // You can add error message to the model
        return new ModelAndView(redirectUrl);
    }
}