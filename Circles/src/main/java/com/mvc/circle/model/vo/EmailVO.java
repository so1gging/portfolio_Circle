package com.mvc.circle.model.vo;

public class EmailVO {
	   private String senderName;    //발신자 이름
	    private String senderMail;    //발신자 이메일 주소
	    private String receiveMail;    //수신자 이메일 주소
	    private String receiveName;
	    private String subject;            //제목
	    private String message;            //본문
		public EmailVO() {
			super();
			// TODO Auto-generated constructor stub
		}
		public EmailVO(String senderName, String senderMail, String receiveMail, String receiveName, String subject,
				String message) {
			super();
			this.senderName = senderName;
			this.senderMail = senderMail;
			this.receiveMail = receiveMail;
			this.receiveName = receiveName;
			this.subject = subject;
			this.message = message;
		}
		public String getSenderName() {
			return senderName;
		}
		public void setSenderName(String senderName) {
			this.senderName = senderName;
		}
		public String getSenderMail() {
			return senderMail;
		}
		public void setSenderMail(String senderMail) {
			this.senderMail = senderMail;
		}
		public String getReceiveMail() {
			return receiveMail;
		}
		public void setReceiveMail(String receiveMail) {
			this.receiveMail = receiveMail;
		}
		public String getReceiveName() {
			return receiveName;
		}
		public void setReceiveName(String receiveName) {
			this.receiveName = receiveName;
		}
		public String getSubject() {
			return subject;
		}
		public void setSubject(String subject) {
			this.subject = subject;
		}
		public String getMessage() {
			return message;
		}
		public void setMessage(String message) {
			this.message = message;
		}
		@Override
		public String toString() {
			return "EmailVO [senderName=" + senderName + ", senderMail=" + senderMail + ", receiveMail=" + receiveMail
					+ ", receiveName=" + receiveName + ", subject=" + subject + ", message=" + message + "]";
		}
	    
	    
}
