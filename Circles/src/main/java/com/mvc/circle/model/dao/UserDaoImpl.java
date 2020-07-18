package com.mvc.circle.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mvc.circle.model.vo.UserVO;

@Repository
public class UserDaoImpl implements UserDao{
	
	Logger logger = LoggerFactory.getLogger(UserDaoImpl.class);
	
	@Autowired
	SqlSessionTemplate sqlSession;
	

	@Override
	public Boolean nameCheck(String user_name) {
		logger.info("<< UserDaoImpl : nameCheck >>");
		UserVO user = new UserVO();
		try {
			user = sqlSession.selectOne(NAMESPACE+"nameCheck",user_name);
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		return (user == null)?true:false;
	}


	@Override
	public Boolean emailCheck(String user_email) {
		logger.info("<< UserDaoImpl : emailCheck >>");
		UserVO user = new UserVO();
		try {
			user = sqlSession.selectOne(NAMESPACE+"emailCheck",user_email);
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		return (user == null)?true:false;
	}


	@Override
	public Boolean registerUser(UserVO user) {
		logger.info("<< UserDaoImpl : registerUser >>");
		int res = 0;
		try {
			res = sqlSession.insert(NAMESPACE+"register",user);
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		
		return (res>0)?true:false;
	}


	@Override
	public UserVO loginUser(UserVO user) {
		logger.info("<< UserDaoImpl : loginUser >>");
		UserVO res = null;
		try {
			res = sqlSession.selectOne(NAMESPACE+"login",user);
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		return res;
	}

}
