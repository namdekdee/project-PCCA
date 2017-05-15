package th.co.pt.pcca.pccaapp.entities.util;

public class ResultObj {

	 public int success;
	 public String message;
	 public String runno_oa_ref;
	 public String doc_no;
	 public String cancel_user;
	 public String default_page;
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
	public String getRunno_oa_ref() {
		return runno_oa_ref;
	}
	public void setRunno_oa_ref(String runno_oa_ref) {
		this.runno_oa_ref = runno_oa_ref;
	}
	
	public String getCancel_user() {
		return cancel_user;
	}
	public void setCancel_user(String cancel_user) {
		this.cancel_user = cancel_user;
	}
	public String getDefault_page() {
		return default_page;
	}
	public void setDefault_page(String default_page) {
		this.default_page = default_page;
	}
	
	
}
