package com.mvc.circle.model.controller;

import java.util.UUID;

import javax.mail.internet.MimeMessage;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mvc.circle.model.service.UserService;
import com.mvc.circle.model.vo.EmailVO;

@Controller
public class MailController {
	Logger logger = LoggerFactory.getLogger(MailController.class);
	
	@Autowired
	  private JavaMailSender mailSender;
	
	@Autowired
	private UserService service;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@RequestMapping("/mail/mailSending")
	@ResponseBody
	public Boolean mailSending(@RequestBody EmailVO email) {

	    String setfrom = email.getSenderMail();      //보내는 사람 이메일    
	    String tomail  = email.getReceiveMail();     // 받는 사람 이메일
	    
	    email.setSubject("<< Circles : " + email.getReceiveName()+"님 임시비밀번호 발급되었습니다  >>");
	   
	    //////임시 비밀번호//////
	    UUID one = UUID.randomUUID();
	    String tempPwd = one.toString().substring(0,6);
	    ///////////////////
	    
	    logger.info("귀하의 임시 비밀번호는 [" + tempPwd + "] 입니다.");
	    email.setMessage("귀하의 임시 비밀번호는 [" + tempPwd + "] 입니다.");
	    
	    String title   = email.getSubject();      // 제목
	    String content = email.getMessage();    // 내용
	    Boolean is = false;
	   
	    try {
	      MimeMessage message = mailSender.createMimeMessage();
	      MimeMessageHelper messageHelper 
	                        = new MimeMessageHelper(message, true, "UTF-8");
	 
	      messageHelper.setFrom(setfrom);  // 보내는사람 생략하거나 하면 정상작동을 안함
	      messageHelper.setTo(tomail);     // 받는사람 이메일
	      messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
	      messageHelper.setText(content);  // 메일 내용
	     
	      mailSender.send(message);
	      is=true;
	      if(is) {
	    	  tempPwd = passwordEncoder.encode(tempPwd);
	    	  is = service.changePwd(email.getReceiveMail(),email.getReceiveName(),tempPwd);
	      }

	    } catch(Exception e){
	      System.out.println(e);
	      is=false;
	    }
	    
	    return is;
	}
	
}
