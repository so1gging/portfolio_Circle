package com.mvc.circle.model.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mvc.circle.model.service.UserService;
import com.mvc.circle.model.vo.UserVO;

@Controller
@RequestMapping("/user")
public class UserController {
	Logger logger = LoggerFactory.getLogger(UserController.class);
	
	@Autowired
	UserService service;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@RequestMapping(value="/nameCheck/{user_name}", method=RequestMethod.GET)
	@ResponseBody
	public Map<String,Boolean> nameCheck(@PathVariable("user_name") String user_name){
		logger.info("<< UserController : nameCheck >>");
		Boolean is = service.nameCheck(user_name);
		
		Map<String,Boolean> param = new HashMap<String,Boolean>();
		param.put("chk", is);
		return param;
	}
	
	@RequestMapping(value="/emailCheck", method=RequestMethod.POST)
	@ResponseBody
	public Map<String,Boolean> emailCheck(@RequestBody String user_email){
		logger.info("<< UserController : emailCheck >>");
		user_email = user_email.substring(1, user_email.length()-1);
		logger.info(user_email);
		Boolean is = service.emailCheck(user_email);
		
		Map<String,Boolean> param = new HashMap<String,Boolean>();
		param.put("chk", is);
		
		return param;
	}
	
	@RequestMapping(value="/register", method=RequestMethod.POST)
	@ResponseBody
	public Map<String,Boolean> registerUser(@RequestBody UserVO user){
		logger.info("<< UserController : registerUser >>");
		user.setUser_password(passwordEncoder.encode(user.getUser_password()));
		Boolean is = service.registerUser(user);

		
		Map<String,Boolean> param = new HashMap<String,Boolean>();
		param.put("chk", is);
		
		return param;
	}	
	
	@RequestMapping(value="/login",method=RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> loginUser(HttpSession session, @RequestBody UserVO user){
		logger.info("<< UserController : loginUser >>");
		UserVO res = service.loginUser(user);
		Boolean is = false;
		Map<String,Object> param = new HashMap<String,Object>();
		
		if(res!=null) {
			if(passwordEncoder.matches(user.getUser_password(), res.getUser_password())) {
				session.setAttribute("user", res);
				is = true;
				param.put("user_name", res.getUser_name());
			}
		}
		
		param.put("chk", is);
		
		return param;
	}	

}
