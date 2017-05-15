package th.co.pt.pcca.pccaservice.entities.util;

public class DropDownCriteriaObj {
	private String head_emp_id	;
	private String emp_id;
	 private String company;
	 private String gu_id;
	 private String comp1;
	 private String comp2;
	 private String comp3;
	 private String comp4;
	 private String comp5;
	 private String comp6;
	 private String comp7;
	 private String startDate;
	 private String endDate;
	 
	 private int numminlvl;
	 
	
	public int getNumminlvl() {
		return numminlvl;
	}

	public void setNumminlvl(int numminlvl) {
		this.numminlvl = numminlvl;
	}

	public String getHead_emp_id() {
		return head_emp_id;
	}

	public void setHead_emp_id(String head_emp_id) {
		this.head_emp_id = head_emp_id;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public String getComp1() {
		return comp1;
	}

	public void setComp1(String comp1) {
		this.comp1 = comp1;
	}

	public String getComp2() {
		return comp2;
	}

	public void setComp2(String comp2) {
		this.comp2 = comp2;
	}

	public String getComp3() {
		return comp3;
	}

	public void setComp3(String comp3) {
		this.comp3 = comp3;
	}

	public String getComp4() {
		return comp4;
	}

	public void setComp4(String comp4) {
		this.comp4 = comp4;
	}

	public String getComp5() {
		return comp5;
	}

	public void setComp5(String comp5) {
		this.comp5 = comp5;
	}

	public String getComp6() {
		return comp6;
	}

	public void setComp6(String comp6) {
		this.comp6 = comp6;
	}

	public String getComp7() {
		return comp7;
	}

	public void setComp7(String comp7) {
		this.comp7 = comp7;
	}

	public String getGu_id() {
		return gu_id;
	}

	public void setGu_id(String gu_id) {
		this.gu_id = gu_id;
	}

	public String getEmp_id() {
		return emp_id;
	}

	public void setEmp_id(String emp_id) {
		this.emp_id = emp_id;
	}

	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	@Override
	public String toString() {
		return "DropDownCriteriaObj [head_emp_id=" + head_emp_id + ", emp_id="
				+ emp_id + ", company=" + company + ", gu_id=" + gu_id
				+ ", comp1=" + comp1 + ", comp2=" + comp2 + ", comp3=" + comp3
				+ ", comp4=" + comp4 + ", comp5=" + comp5 + ", comp6=" + comp6
				+ ", comp7=" + comp7 + ", startDate=" + startDate
				+ ", endDate=" + endDate + "]";
	}
	
}
