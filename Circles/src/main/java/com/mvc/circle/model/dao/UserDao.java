package com.mvc.circle.model.dao;

import com.mvc.circle.model.vo.UserVO;

public interface UserDao {
	String NAMESPACE = "user.";
	Boolean nameCheck(String user_name);
	Boolean emailCheck(String user_email);
	Boolean registerUser(UserVO user);
	UserVO loginUser(UserVO user);

}
