package com.mvc.circle.model.controller;


import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class MainController {
	
	Logger logger = LoggerFactory.getLogger(MainController.class);
	
		@RequestMapping("/main")
		public String mainView() {
			logger.info("<< MainController : mainView >>");
			return "/main";
		}
		
		@RequestMapping("/login")
		public String loginView() {
			logger.info("<< MainController : loginView >>");
			return "/login";
		}

		@RequestMapping("/register")
		public String registerView() {
			logger.info("<< MainController : registerView >>");
			return "/register";
		}
		
		@RequestMapping("/logout")
		public String logout(HttpSession session) {
			session.removeAttribute("user");
			return "redirect:main";
		}
		
		@RequestMapping("/findPwd")
		public String findPwdView() {
			return "/findPwd";
		}
		
		@RequestMapping("/mypage")
		public String mypageView() {
			return "/mypage";
		}
		
}
