package com.mvc.circle.model.vo;

public class UserVO {
	private String user_name;
	private String user_email;
	private String user_password;
	private int user_status;
	
	public UserVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public UserVO(String user_name, String user_email, String user_password, int user_status) {
		super();
		this.user_name = user_name;
		this.user_email = user_email;
		this.user_password = user_password;
		this.user_status = user_status;
	}
	
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getUser_email() {
		return user_email;
	}
	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}
	public String getUser_password() {
		return user_password;
	}
	public void setUser_password(String user_password) {
		this.user_password = user_password;
	}
	public int getUser_status() {
		return user_status;
	}
	public void setUser_status(int user_status) {
		this.user_status = user_status;
	}
	
	@Override
	public String toString() {
		return "UserVO [user_name=" + user_name + ", user_email=" + user_email + ", user_password=" + user_password
				+ ", user_status=" + user_status + "]";
	}
	
	
}
