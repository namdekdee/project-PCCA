package th.co.pt.pcca.pccaservice.entities.member;

import java.math.BigDecimal;

public class WorkStateObj {
	
	private String state_type;
	private BigDecimal data_month_amt;
	private BigDecimal day_month_amt;
	private String hour_minute_month_amt;
	private BigDecimal data_year_amt;
	private BigDecimal day_year_amt;
	private String hour_minute_year_amt;
	public String getState_type() {
		return state_type;
	}
	public void setState_type(String state_type) {
		this.state_type = state_type;
	}
	public BigDecimal getData_month_amt() {
		return data_month_amt;
	}
	public void setData_month_amt(BigDecimal data_month_amt) {
		this.data_month_amt = data_month_amt;
	}
	public BigDecimal getDay_month_amt() {
		return day_month_amt;
	}
	public void setDay_month_amt(BigDecimal day_month_amt) {
		this.day_month_amt = day_month_amt;
	}
	
	public BigDecimal getData_year_amt() {
		return data_year_amt;
	}
	public void setData_year_amt(BigDecimal data_year_amt) {
		this.data_year_amt = data_year_amt;
	}
	public BigDecimal getDay_year_amt() {
		return day_year_amt;
	}
	public void setDay_year_amt(BigDecimal day_year_amt) {
		this.day_year_amt = day_year_amt;
	}
	public String getHour_minute_month_amt() {
		return hour_minute_month_amt;
	}
	public void setHour_minute_month_amt(String hour_minute_month_amt) {
		this.hour_minute_month_amt = hour_minute_month_amt;
	}
	public String getHour_minute_year_amt() {
		return hour_minute_year_amt;
	}
	public void setHour_minute_year_amt(String hour_minute_year_amt) {
		this.hour_minute_year_amt = hour_minute_year_amt;
	}
	
	
	
}
