package th.co.pt.pcca.pccaservice.entities.member;

import java.math.BigDecimal;
import java.util.List;

public class WorkTimeObj {
	
	private String codempid;
	private String namempt;
	private String namempe;
	private String dtestrtw;
	private String timstrtw;
	private String dteendw;
	private String timendw;
	private String req_docno;
	private String dtein;
	private String timin;
	private String dteout;
	private String timout;
	private String case_worktype;
	private String dtework;
	private String dtework_db;
	private String codshift;
	private String codcomp;
	private String case_doc;
	private String case_time;
	private String namcenttha;
	private String nampost;
	private String codreqst;
	private String descodt;
	private String remark;
	private String trans_id;
	private String curr_status;
	private String typwork;
	private String dtein_real;
	private String timin_real;
	private String dteout_real;
	private String timout_real;
	private String dtein_shift;
	private String timin_shift;
	private String dteout_shift;
	private String timout_shift;
	
	private String request_datein;
	private String request_timein;
	private String request_dateout;
	private String request_timeout;
	private String request_cause;
	private String request_remark;
	private String request_doc_status;
	private String case_date;
	private String request_approver;
	
	private String start_date;
	private String start_time;
	private String end_date;
	private String end_time;
	private String leave_docno;
	private String leave_id;
	private String leave_desc;
	private String file_name;
	private String case_another_doc;
	private String start_leave_flag;
	private String end_leave_flag;
	private String start_leave_date;
	private String end_leave_date;
	private String leave_remark;
	private String leave_file_name;
	private String leave_request_date;
	private String leave_request_status;
	private String shift_start_time;
	private String shift_end_time;
	private String shift_start_breaktime;
	private String shift_end_breaktime;
	private String emp_type;
	
	private BigDecimal ot1_h;
	private BigDecimal ot15_h;
	private BigDecimal ot2_h;
	private BigDecimal ot3_h;
	private String request_docno;
	private String cancel_status;
	private String cancel_docno;
	private String cancel_doc_status;
	private String cancel_approver;
	private String cancel_leave_status;
	private String ot_docno;
	private String ot_desc;
	private String ot_request_status;
	private String flag_time;
	private String short_date;
	private String holiday_desc;
	private String holiday_year;
	private List<WorkTimeObj> list_leave;
	private List<WorkTimeObj> list_ot;
	public String getCodempid() {
		return codempid;
	}
	public void setCodempid(String codempid) {
		this.codempid = codempid;
	}
	public String getNamempt() {
		return namempt;
	}
	public void setNamempt(String namempt) {
		this.namempt = namempt;
	}
	public String getNamempe() {
		return namempe;
	}
	public void setNamempe(String namempe) {
		this.namempe = namempe;
	}
	public String getDtestrtw() {
		return dtestrtw;
	}
	public void setDtestrtw(String dtestrtw) {
		this.dtestrtw = dtestrtw;
	}
	public String getTimstrtw() {
		return timstrtw;
	}
	public void setTimstrtw(String timstrtw) {
		this.timstrtw = timstrtw;
	}
	public String getDteendw() {
		return dteendw;
	}
	public void setDteendw(String dteendw) {
		this.dteendw = dteendw;
	}
	public String getTimendw() {
		return timendw;
	}
	public void setTimendw(String timendw) {
		this.timendw = timendw;
	}
	public String getReq_docno() {
		return req_docno;
	}
	public void setReq_docno(String req_docno) {
		this.req_docno = req_docno;
	}
	public String getDtein() {
		return dtein;
	}
	public void setDtein(String dtein) {
		this.dtein = dtein;
	}
	public String getTimin() {
		return timin;
	}
	public void setTimin(String timin) {
		this.timin = timin;
	}
	public String getDteout() {
		return dteout;
	}
	public void setDteout(String dteout) {
		this.dteout = dteout;
	}
	public String getTimout() {
		return timout;
	}
	public void setTimout(String timout) {
		this.timout = timout;
	}
	public String getCase_worktype() {
		return case_worktype;
	}
	public void setCase_worktype(String case_worktype) {
		this.case_worktype = case_worktype;
	}
	public String getDtework() {
		return dtework;
	}
	public void setDtework(String dtework) {
		this.dtework = dtework;
	}
	public String getCodshift() {
		return codshift;
	}
	public void setCodshift(String codshift) {
		this.codshift = codshift;
	}
	public String getCodcomp() {
		return codcomp;
	}
	public void setCodcomp(String codcomp) {
		this.codcomp = codcomp;
	}
	public String getCase_doc() {
		return case_doc;
	}
	public void setCase_doc(String case_doc) {
		this.case_doc = case_doc;
	}
	public String getCase_time() {
		return case_time;
	}
	public void setCase_time(String case_time) {
		this.case_time = case_time;
	}
	
	public String getNamcenttha() {
		return namcenttha;
	}
	public void setNamcenttha(String namcenttha) {
		this.namcenttha = namcenttha;
	}
	public String getNampost() {
		return nampost;
	}
	public void setNampost(String nampost) {
		this.nampost = nampost;
	}
	public String getCodreqst() {
		return codreqst;
	}
	public void setCodreqst(String codreqst) {
		this.codreqst = codreqst;
	}
	public String getDescodt() {
		return descodt;
	}
	public void setDescodt(String descodt) {
		this.descodt = descodt;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getTrans_id() {
		return trans_id;
	}
	public void setTrans_id(String trans_id) {
		this.trans_id = trans_id;
	}
	public String getCurr_status() {
		return curr_status;
	}
	public void setCurr_status(String curr_status) {
		this.curr_status = curr_status;
	}
	public String getTypwork() {
		return typwork;
	}
	public void setTypwork(String typwork) {
		this.typwork = typwork;
	}
	public String getDtein_real() {
		return dtein_real;
	}
	public void setDtein_real(String dtein_real) {
		this.dtein_real = dtein_real;
	}
	public String getTimin_real() {
		return timin_real;
	}
	public void setTimin_real(String timin_real) {
		this.timin_real = timin_real;
	}
	public String getDteout_real() {
		return dteout_real;
	}
	public void setDteout_real(String dteout_real) {
		this.dteout_real = dteout_real;
	}
	public String getTimout_real() {
		return timout_real;
	}
	public void setTimout_real(String timout_real) {
		this.timout_real = timout_real;
	}
	public String getRequest_datein() {
		return request_datein;
	}
	public void setRequest_datein(String request_datein) {
		this.request_datein = request_datein;
	}
	public String getRequest_timein() {
		return request_timein;
	}
	public void setRequest_timein(String request_timein) {
		this.request_timein = request_timein;
	}
	public String getRequest_dateout() {
		return request_dateout;
	}
	public void setRequest_dateout(String request_dateout) {
		this.request_dateout = request_dateout;
	}
	public String getRequest_timeout() {
		return request_timeout;
	}
	public void setRequest_timeout(String request_timeout) {
		this.request_timeout = request_timeout;
	}
	public String getRequest_cause() {
		return request_cause;
	}
	public void setRequest_cause(String request_cause) {
		this.request_cause = request_cause;
	}
	public String getRequest_remark() {
		return request_remark;
	}
	public void setRequest_remark(String request_remark) {
		this.request_remark = request_remark;
	}
	public String getRequest_doc_status() {
		return request_doc_status;
	}
	public void setRequest_doc_status(String request_doc_status) {
		this.request_doc_status = request_doc_status;
	}
	public String getCase_date() {
		return case_date;
	}
	public void setCase_date(String case_date) {
		this.case_date = case_date;
	}
	public String getRequest_approver() {
		return request_approver;
	}
	public void setRequest_approver(String request_approver) {
		this.request_approver = request_approver;
	}
	public String getStart_date() {
		return start_date;
	}
	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}
	public String getStart_time() {
		return start_time;
	}
	public void setStart_time(String start_time) {
		this.start_time = start_time;
	}
	public String getEnd_date() {
		return end_date;
	}
	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}
	public String getEnd_time() {
		return end_time;
	}
	public void setEnd_time(String end_time) {
		this.end_time = end_time;
	}
	public String getLeave_id() {
		return leave_id;
	}
	public void setLeave_id(String leave_id) {
		this.leave_id = leave_id;
	}
	public String getLeave_desc() {
		return leave_desc;
	}
	public void setLeave_desc(String leave_desc) {
		this.leave_desc = leave_desc;
	}
	public String getFile_name() {
		return file_name;
	}
	public void setFile_name(String file_name) {
		this.file_name = file_name;
	}
	public String getCase_another_doc() {
		return case_another_doc;
	}
	public void setCase_another_doc(String case_another_doc) {
		this.case_another_doc = case_another_doc;
	}
	public String getStart_leave_flag() {
		return start_leave_flag;
	}
	public void setStart_leave_flag(String start_leave_flag) {
		this.start_leave_flag = start_leave_flag;
	}
	public String getEnd_leave_flag() {
		return end_leave_flag;
	}
	public void setEnd_leave_flag(String end_leave_flag) {
		this.end_leave_flag = end_leave_flag;
	}
	public String getStart_leave_date() {
		return start_leave_date;
	}
	public void setStart_leave_date(String start_leave_date) {
		this.start_leave_date = start_leave_date;
	}
	public String getEnd_leave_date() {
		return end_leave_date;
	}
	public void setEnd_leave_date(String end_leave_date) {
		this.end_leave_date = end_leave_date;
	}
	public String getLeave_remark() {
		return leave_remark;
	}
	public void setLeave_remark(String leave_remark) {
		this.leave_remark = leave_remark;
	}
	public String getLeave_file_name() {
		return leave_file_name;
	}
	public void setLeave_file_name(String leave_file_name) {
		this.leave_file_name = leave_file_name;
	}
	public String getLeave_request_date() {
		return leave_request_date;
	}
	public void setLeave_request_date(String leave_request_date) {
		this.leave_request_date = leave_request_date;
	}
	public String getLeave_request_status() {
		return leave_request_status;
	}
	public void setLeave_request_status(String leave_request_status) {
		this.leave_request_status = leave_request_status;
	}
	public String getShift_start_time() {
		return shift_start_time;
	}
	public void setShift_start_time(String shift_start_time) {
		this.shift_start_time = shift_start_time;
	}
	public String getShift_end_time() {
		return shift_end_time;
	}
	public void setShift_end_time(String shift_end_time) {
		this.shift_end_time = shift_end_time;
	}
	public String getShift_start_breaktime() {
		return shift_start_breaktime;
	}
	public void setShift_start_breaktime(String shift_start_breaktime) {
		this.shift_start_breaktime = shift_start_breaktime;
	}
	public String getShift_end_breaktime() {
		return shift_end_breaktime;
	}
	public void setShift_end_breaktime(String shift_end_breaktime) {
		this.shift_end_breaktime = shift_end_breaktime;
	}
	public String getEmp_type() {
		return emp_type;
	}
	public void setEmp_type(String emp_type) {
		this.emp_type = emp_type;
	}
	public BigDecimal getOt1_h() {
		return ot1_h;
	}
	public void setOt1_h(BigDecimal ot1_h) {
		this.ot1_h = ot1_h;
	}
	public BigDecimal getOt15_h() {
		return ot15_h;
	}
	public void setOt15_h(BigDecimal ot15_h) {
		this.ot15_h = ot15_h;
	}
	public BigDecimal getOt2_h() {
		return ot2_h;
	}
	public void setOt2_h(BigDecimal ot2_h) {
		this.ot2_h = ot2_h;
	}
	public BigDecimal getOt3_h() {
		return ot3_h;
	}
	public void setOt3_h(BigDecimal ot3_h) {
		this.ot3_h = ot3_h;
	}
	public String getDtein_shift() {
		return dtein_shift;
	}
	public void setDtein_shift(String dtein_shift) {
		this.dtein_shift = dtein_shift;
	}
	public String getTimin_shift() {
		return timin_shift;
	}
	public void setTimin_shift(String timin_shift) {
		this.timin_shift = timin_shift;
	}
	public String getDteout_shift() {
		return dteout_shift;
	}
	public void setDteout_shift(String dteout_shift) {
		this.dteout_shift = dteout_shift;
	}
	public String getTimout_shift() {
		return timout_shift;
	}
	public void setTimout_shift(String timout_shift) {
		this.timout_shift = timout_shift;
	}
	public String getRequest_docno() {
		return request_docno;
	}
	public void setRequest_docno(String request_docno) {
		this.request_docno = request_docno;
	}
	public List<WorkTimeObj> getList_leave() {
		return list_leave;
	}
	public void setList_leave(List<WorkTimeObj> list_leave) {
		this.list_leave = list_leave;
	}
	public String getLeave_docno() {
		return leave_docno;
	}
	public void setLeave_docno(String leave_docno) {
		this.leave_docno = leave_docno;
	}
	public String getDtework_db() {
		return dtework_db;
	}
	public void setDtework_db(String dtework_db) {
		this.dtework_db = dtework_db;
	}
	public String getCancel_status() {
		return cancel_status;
	}
	public void setCancel_status(String cancel_status) {
		this.cancel_status = cancel_status;
	}
	public String getCancel_docno() {
		return cancel_docno;
	}
	public void setCancel_docno(String cancel_docno) {
		this.cancel_docno = cancel_docno;
	}
	public String getCancel_doc_status() {
		return cancel_doc_status;
	}
	public void setCancel_doc_status(String cancel_doc_status) {
		this.cancel_doc_status = cancel_doc_status;
	}
	public String getCancel_approver() {
		return cancel_approver; 
	}
	public void setCancel_approver(String cancel_approver) {
		this.cancel_approver = cancel_approver;
	}
	public String getCancel_leave_status() {
		return cancel_leave_status;
	}
	public void setCancel_leave_status(String cancel_leave_status) {
		this.cancel_leave_status = cancel_leave_status;
	}
	public List<WorkTimeObj> getList_ot() {
		return list_ot;
	}
	public void setList_ot(List<WorkTimeObj> list_ot) {
		this.list_ot = list_ot;
	}
	public String getOt_docno() {
		return ot_docno;
	}
	public void setOt_docno(String ot_docno) {
		this.ot_docno = ot_docno;
	}
	public String getOt_desc() {
		return ot_desc;
	}
	public void setOt_desc(String ot_desc) {
		this.ot_desc = ot_desc;
	}
	public String getOt_request_status() {
		return ot_request_status;
	}
	public void setOt_request_status(String ot_request_status) {
		this.ot_request_status = ot_request_status;
	}
	public String getFlag_time() {
		return flag_time;
	}
	public void setFlag_time(String flag_time) {
		this.flag_time = flag_time;
	}
	public String getShort_date() {
		return short_date;
	}
	public void setShort_date(String short_date) {
		this.short_date = short_date;
	}
	public String getHoliday_desc() {
		return holiday_desc;
	}
	public void setHoliday_desc(String holiday_desc) {
		this.holiday_desc = holiday_desc;
	}
	public String getHoliday_year() {
		return holiday_year;
	}
	public void setHoliday_year(String holiday_year) {
		this.holiday_year = holiday_year;
	}

	
	
}
