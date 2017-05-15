package th.co.pt.pcca.pccaapp.entities.util;

import java.util.Date;

public class CalendarObj {

	 private String email;
	 private String email_invite;
	 private String location;
	 private String subject;
	 private String body;
	 private Date start_date;
	 private Date end_date;
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getEmail_invite() {
		return email_invite;
	}
	public void setEmail_invite(String email_invite) {
		this.email_invite = email_invite;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getBody() {
		return body;
	}
	public void setBody(String body) {
		this.body = body;
	}
	public Date getStart_date() {
		return start_date;
	}
	public void setStart_date(Date start_date) {
		this.start_date = start_date;
	}
	public Date getEnd_date() {
		return end_date;
	}
	public void setEnd_date(Date end_date) {
		this.end_date = end_date;
	}
	
	
}
