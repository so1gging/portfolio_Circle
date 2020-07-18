package com.mvc.circle.model.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mvc.circle.model.dao.UserDao;
import com.mvc.circle.model.vo.UserVO;

@Service
public class UserServiceImpl implements UserService{

	Logger logger = LoggerFactory.getLogger(UserServiceImpl.class);
	
	@Autowired
	UserDao dao;
	
	@Override
	public Boolean nameCheck(String user_name) {
		logger.info("<< UserServiceImpl : nameCheck >>");
		
		return dao.nameCheck(user_name);
	}

	@Override
	public Boolean emailCheck(String user_email) {
		logger.info("<< UserServiceImpl : emailCheck >>");
		return dao.emailCheck(user_email);
	}

	@Override
	public Boolean registerUser(UserVO user) {
		logger.info("<< UserServiceImpl : registerUser >>");
		
		return dao.registerUser(user);
	}

	@Override
	public UserVO loginUser(UserVO user) {
		logger.info("<< UserServiceImpl : loginUser >>");
		return dao.loginUser(user);
	}

}
