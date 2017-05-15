package th.co.pt.pcca.pccaservice.entities.util;

public class ResultObj {

	 public int success;
	 public String message;
	 public String doc_no;
	 public String runno_oa_ref;
	 public String cancel_user;
	 
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
	public String getRunno_oa_ref() {
		return runno_oa_ref;
	}
	public void setRunno_oa_ref(String runno_oa_ref) {
		this.runno_oa_ref = runno_oa_ref;
	} 
}
