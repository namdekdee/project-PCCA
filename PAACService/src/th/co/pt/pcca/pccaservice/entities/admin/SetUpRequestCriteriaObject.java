package th.co.pt.pcca.pccaservice.entities.admin;

public class SetUpRequestCriteriaObject {
	private String codePID;
	private String menu_ID;
	private String wfID;
	private String action;
	private String date;
	
	public String getCodePID() {
		return codePID;
	}
	public void setCodePID(String codemPID) {
		this.codePID = codemPID;
	}
	public String getMenu_ID() {
		return menu_ID;
	}
	public void setMenu_ID(String menu_ID) {
		this.menu_ID = menu_ID;
	}
	public String getWfID() {
		return wfID;
	}
	public void setWfID(String wfID) {
		this.wfID = wfID;
	}
	public String getAction() {
		return action;
	}
	public void setAction(String action) {
		this.action = action;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	
	
}
