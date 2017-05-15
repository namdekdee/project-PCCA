package th.co.pt.pcca.pccaapp.entities.member;


public class WorkOutResultObj {
	private int success;
	private String message;
	private String doc_no;
	private String kilo_flag;
	private String allow_flag;
	private String approve_flag;
	private String approve_user;
	
	public int getSuccess() {
		return success;
	}
	public void setSuccess(int success) {
		this.success = success;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getDoc_no() {
		return doc_no;
	}
	public void setDoc_no(String doc_no) {
		this.doc_no = doc_no;
	}
	public String getKilo_flag() {
		return kilo_flag;
	}
	public void setKilo_flag(String kilo_flag) {
		this.kilo_flag = kilo_flag;
	}
	public String getAllow_flag() {
		return allow_flag;
	}
	public void setAllow_flag(String allow_flag) {
		this.allow_flag = allow_flag;
	}
	public String getApprove_flag() {
		return approve_flag;
	}
	public void setApprove_flag(String approve_flag) {
		this.approve_flag = approve_flag;
	}
	public String getApprove_user() {
		return approve_user;
	}
	public void setApprove_user(String approve_user) {
		this.approve_user = approve_user;
	}
	
}
