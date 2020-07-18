package com.mvc.circle.model.service;

import com.mvc.circle.model.vo.UserVO;

public interface UserService {

	Boolean nameCheck(String user_name);

	Boolean emailCheck(String user_email);

	Boolean registerUser(UserVO user);

	UserVO loginUser(UserVO user);

}
