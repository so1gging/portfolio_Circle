package com.mvc.circle.model.vo;

import java.util.Date;

public class GuestbookVO {
	private int guest_no;
	private String guest_title;
	private String user_email;
	private String user_name;
	private String guest_content;
	private Date guest_date;
	private int guest_status;
	private int guest_heart;
	
	public GuestbookVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public GuestbookVO(int guest_no, String guest_title, String user_email, String user_name, String guest_content,
			Date guest_date, int guest_status, int guest_heart) {
		super();
		this.guest_no = guest_no;
		this.guest_title = guest_title;
		this.user_email = user_email;
		this.user_name = user_name;
		this.guest_content = guest_content;
		this.guest_date = guest_date;
		this.guest_status = guest_status;
		this.guest_heart = guest_heart;
	}

	public int getGuest_no() {
		return guest_no;
	}

	public void setGuest_no(int guest_no) {
		this.guest_no = guest_no;
	}

	public String getGuest_title() {
		return guest_title;
	}

	public void setGuest_title(String guest_title) {
		this.guest_title = guest_title;
	}

	public String getUser_email() {
		return user_email;
	}

	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public String getGuest_content() {
		return guest_content;
	}

	public void setGuest_content(String guest_content) {
		this.guest_content = guest_content;
	}

	public Date getGuest_date() {
		return guest_date;
	}

	public void setGuest_date(Date guest_date) {
		this.guest_date = guest_date;
	}

	public int getGuest_status() {
		return guest_status;
	}

	public void setGuest_status(int guest_status) {
		this.guest_status = guest_status;
	}

	public int getGuest_heart() {
		return guest_heart;
	}

	public void setGuest_heart(int guest_heart) {
		this.guest_heart = guest_heart;
	}

	@Override
	public String toString() {
		return "GuestbookVO [guest_no=" + guest_no + ", guest_title=" + guest_title + ", user_email=" + user_email
				+ ", user_name=" + user_name + ", guest_content=" + guest_content + ", guest_date=" + guest_date
				+ ", guest_status=" + guest_status + ", guest_heart=" + guest_heart + "]";
	}

	
}
