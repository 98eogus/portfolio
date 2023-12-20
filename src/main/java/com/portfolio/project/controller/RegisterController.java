package com.portfolio.project.controller;


import com.portfolio.project.domain.BoardDto;
import com.portfolio.project.domain.PageHandler;
import com.portfolio.project.domain.SearchCondition;
import com.portfolio.project.domain.User;

import com.portfolio.project.service.RegisterService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/register")
public class RegisterController {
    @Autowired
    RegisterService registerService;


    @InitBinder
    public void toDate(WebDataBinder binder) {
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        binder.registerCustomEditor(Date.class, new CustomDateEditor(df, false));
        //	List<Validator> validatorList = binder.getValidators();
        //	System.out.println("validatorList="+validatorList);
    }

    @GetMapping("/add")
    public String list() {

        return "registerForm";
    }

    //회원가입
    @PostMapping("/save")
    //@ResponseBody
    public String register(User user, RedirectAttributes rattr) {


        try {
            if(registerService.add(user)!=1)
                throw new Exception("failed.");

            rattr.addFlashAttribute("msg","REG_OK");
        } catch (Exception e) {
            e.printStackTrace();
            rattr.addFlashAttribute("msg","REG_ERR");
        }
        return "redirect:/";
    }


}
