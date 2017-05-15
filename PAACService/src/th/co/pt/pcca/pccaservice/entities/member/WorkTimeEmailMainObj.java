package th.co.pt.pcca.pccaservice.entities.member;

import java.util.List;

public class WorkTimeEmailMainObj {
	
	private String approver_id;
	private String approver_name;
	private String approver_comp;
	private String mail_body;
	private String mail_footer;
	private String mail_subject;
	private String approver_email;
	private String approve_link;
	private String trans_id;
	private List<WorkTimeEmailObj> list_user;
	private String event_id;
	public String getApprover_id() {
		return approver_id;
	}
	public void setApprover_id(String approver_id) {
		this.approver_id = approver_id;
	}
	public String getApprover_name() {
		return approver_name;
	}
	public void setApprover_name(String approver_name) {
		this.approver_name = approver_name;
	}
	public String getApprover_comp() {
		return approver_comp;
	}
	public void setApprover_comp(String approver_comp) {
		this.approver_comp = approver_comp;
	}
	
	public String getMail_body() {
		return mail_body;
	}
	public void setMail_body(String mail_body) {
		this.mail_body = mail_body;
	}
	public String getMail_footer() {
		return mail_footer;
	}
	public void setMail_footer(String mail_footer) {
		this.mail_footer = mail_footer;
	}
	public String getApprover_email() {
		return approver_email;
	}
	public void setApprover_email(String approver_email) {
		this.approver_email = approver_email;
	}
	public String getApprove_link() {
		return approve_link;
	}
	public void setApprove_link(String approve_link) {
		this.approve_link = approve_link;
	}
	public String getTrans_id() {
		return trans_id;
	}
	public void setTrans_id(String trans_id) {
		this.trans_id = trans_id;
	}
	public List<WorkTimeEmailObj> getList_user() {
		return list_user;
	}
	public void setList_user(List<WorkTimeEmailObj> list_user) {
		this.list_user = list_user;
	}
	public String getMail_subject() {
		return mail_subject;
	}
	public void setMail_subject(String mail_subject) {
		this.mail_subject = mail_subject;
	}
	public String getEvent_id() {
		return event_id;
	}
	public void setEvent_id(String event_id) {
		this.event_id = event_id;
	}
	
	
}
