package com.mvc.circle.model.dao;

import java.util.Map;

import com.mvc.circle.model.vo.UserVO;

public interface UserDao {
	String NAMESPACE = "user.";
	Boolean nameCheck(String user_name);
	Boolean emailCheck(String user_email);
	Boolean registerUser(UserVO user);
	UserVO loginUser(UserVO user);
	Boolean findUser(UserVO user);
	Boolean changePwd(Map<String, Object> param);

}
