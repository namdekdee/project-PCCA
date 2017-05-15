package th.co.pt.pcca.pccaservice.controller.member;

import java.io.IOException;
import java.util.ArrayList;
import java.util.EmptyStackException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.xml.ws.http.HTTPException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.view.RedirectView;

import th.co.pt.pcca.pccaservice.classobject.CGlobal;
import th.co.pt.pcca.pccaservice.dao.account.MenuDao;
import th.co.pt.pcca.pccaservice.entities.member.ApproveEmailCriteriaObj;
import th.co.pt.pcca.pccaservice.entities.member.ApproveEmailObj;
import th.co.pt.pcca.pccaservice.entities.member.HolidayObj;
import th.co.pt.pcca.pccaservice.entities.member.MemberObj;
import th.co.pt.pcca.pccaservice.entities.member.ShiftTimeCriteriaObj;
import th.co.pt.pcca.pccaservice.entities.member.ShiftTimeDropdownObj;
import th.co.pt.pcca.pccaservice.entities.member.ShiftTimeObj;
import th.co.pt.pcca.pccaservice.entities.member.SumaryOtCriteriaObj;
import th.co.pt.pcca.pccaservice.entities.member.SumaryOtObj;
import th.co.pt.pcca.pccaservice.entities.member.WorkOutCriteriaObj;
import th.co.pt.pcca.pccaservice.entities.member.WorkOutObj;
import th.co.pt.pcca.pccaservice.entities.member.WorkStateCriteriaObj;
import th.co.pt.pcca.pccaservice.entities.member.WorkStateObj;
import th.co.pt.pcca.pccaservice.entities.member.WorkTimeCriteriaObj;
import th.co.pt.pcca.pccaservice.entities.member.WorkTimeEmailMainObj;
import th.co.pt.pcca.pccaservice.entities.member.WorkTimeLeaveObj;
import th.co.pt.pcca.pccaservice.entities.member.WorkTimeObj;
import th.co.pt.pcca.pccaservice.entities.util.DropDownObj;
import th.co.pt.pcca.pccaservice.entities.util.ResultObj;
import th.co.pt.pcca.pccaservice.service.account.LoginService;
import th.co.pt.pcca.pccaservice.service.member.MemberService;

@Controller
public class ApiMemberController {
	@Autowired
	private MemberService memberService;
	
	 @RequestMapping(value = "/member-getmemberprofile", method = RequestMethod.POST)
	    @ResponseBody
	    public MemberObj getmemberProfile( @RequestBody MemberObj criteria) throws HTTPException, IOException {
		 
		 try
		 {
	        return memberService.GetMemberProfile(criteria);
		 }
		 catch(Exception ex)
		 {
			 throw new HTTPException(404);
		 }
	 }
	 
	 @RequestMapping(value = "/member-getholiday", method = RequestMethod.POST)
	    @ResponseBody
	    public List<HolidayObj> getHoliday( @RequestBody MemberObj criteria) throws HTTPException, IOException {
		 
		 try
		 {
	        return memberService.GetHoliday(criteria);
		 }
		 catch(Exception ex)
		 {
			 throw new HTTPException(404);
		 }
	 }
	 
	 @RequestMapping(value = "/member-getworktime", method = RequestMethod.POST)
	    @ResponseBody
	    public List<WorkTimeObj> getWorkTime( @RequestBody WorkTimeCriteriaObj criteria) throws HTTPException, IOException {
		 
		 try
		 {
	        return memberService.GetWorkTime(criteria);
		 }
		 catch(Exception ex)
		 {
			 throw new HTTPException(404);
		 }
	 }
	
	 @RequestMapping(value = "/member-insertworktimeedittime", method = RequestMethod.POST)
	    @ResponseBody
	    public ResultObj InsertWorkTimeEditTime( @RequestBody WorkTimeCriteriaObj criteria) throws HTTPException, IOException {
		 
		 try
		 {
	        return memberService.InsertWorkTimeEditTime(criteria);
		 }
		 catch(Exception ex)
		 {
			 throw new HTTPException(404);
		 }
	 }
	 
	 @RequestMapping(value = "/member-getworktime-edittime-approve", method = RequestMethod.POST)
	    @ResponseBody
	    public List<WorkTimeObj> getWorkTimeApprove( @RequestBody WorkTimeCriteriaObj criteria) throws HTTPException, IOException {
		 
		 try
		 {
	        return memberService.GetWorkTimeEditTimeApprove(criteria);
		 }
		 catch(Exception ex)
		 {
			 throw new HTTPException(404);
		 }
	 }
	 @RequestMapping(value = "/member-updateworktimeedittime", method = RequestMethod.POST)
	    @ResponseBody
	    public ResultObj UpdateWorkTimeEditTime( @RequestBody WorkTimeCriteriaObj criteria) throws HTTPException, IOException {
		 
		 try
		 {
	        return memberService.UpdateWorkTimeEditTime(criteria);
		 }
		 catch(Exception ex)
		 {
			 throw new HTTPException(404);
		 }
	 }
	 
	 @RequestMapping(value = "/member-getsendmail-list", method = RequestMethod.GET)
	    @ResponseBody
	    public List<WorkTimeEmailMainObj> GetListSendMail(String wf_id,String email_id ) throws HTTPException, IOException {
		 
		 try
		 {
			 WorkTimeCriteriaObj criteria = new WorkTimeCriteriaObj();
			 criteria.setWf_id(wf_id);
			 criteria.setEmail_id(email_id);
	        return memberService.GetWorkTimeEditTimeRequestListMail(criteria);
		 }
		 catch(Exception ex)
		 {
			 throw new HTTPException(404);
		 }
	 }
	 
	 @RequestMapping(value = "/member-updateworktimeedittime-mail", method = RequestMethod.POST)
	    @ResponseBody
	    public ResultObj UpdateWorkTimeEditTimeMail( @RequestBody WorkTimeCriteriaObj criteria) throws HTTPException, IOException {

		 try
		 {
	        return memberService.UpdateWorkTimeEditTimeMail(criteria);
		 }
		 catch(Exception ex)
		 {
			 throw new HTTPException(404);
		 }
	 }
	 @RequestMapping(value = "/member-getworktime-leavepermiss", method = RequestMethod.POST)
	    @ResponseBody
	    public WorkTimeLeaveObj GetWorkTimeLeavePermiss( @RequestBody WorkTimeCriteriaObj criteria) throws HTTPException, IOException {

		 try
		 {
	        return memberService.GetWorkTimeLeavePermiss(criteria);
		 }
		 catch(Exception ex)
		 {
			 throw new HTTPException(404);
		 }
	 }
	 
	 @RequestMapping(value = "/member-insertworktimeleave", method = RequestMethod.POST)
	    @ResponseBody
	    public ResultObj InsertWorkTimeLeave( @RequestBody WorkTimeCriteriaObj criteria) throws HTTPException, IOException {
		 
		 try
		 {
	        return memberService.InsertWorkTimeLeave(criteria);
		 }
		 catch(Exception ex)
		 {
			 throw new HTTPException(404);
		 }
	 }
	 
	 @RequestMapping(value = "/member-getworktime-leave-approve", method = RequestMethod.POST)
	    @ResponseBody
	    public List<WorkTimeObj> getWorkTimeLeaveApprove( @RequestBody WorkTimeCriteriaObj criteria) throws HTTPException, IOException {
		 
		 try
		 {
	        return memberService.GetWorkTimeLeaveApprove(criteria);
		 }
		 catch(Exception ex)
		 {
			 throw new HTTPException(404);
		 }
	 }
	 @RequestMapping(value = "/member-updateworktimeleave", method = RequestMethod.POST)
	    @ResponseBody
	    public ResultObj UpdateWorkTimeLeave( @RequestBody WorkTimeCriteriaObj criteria) throws HTTPException, IOException {
		 
		 try
		 {
	        return memberService.UpdateWorkTimeLeave(criteria);
		 }
		 catch(Exception ex)
		 {
			 throw new HTTPException(404);
		 }
	 }
	 @RequestMapping(value = "/member-insertworktimeot", method = RequestMethod.POST)
	    @ResponseBody
	    public ResultObj InsertWorkTimeOT( @RequestBody WorkTimeCriteriaObj criteria) throws HTTPException, IOException {
		 
		 try
		 {
	        return memberService.InsertWorkTimeOT(criteria);
		 }
		 catch(Exception ex)
		 {
			 throw new HTTPException(404);
		 }
	 }
	 
	 @RequestMapping(value = "/member-getworktime-ot-approve", method = RequestMethod.POST)
	    @ResponseBody
	    public List<WorkTimeObj> getWorkTimeOTApprove( @RequestBody WorkTimeCriteriaObj criteria) throws HTTPException, IOException {
		 
		 try
		 {
	        return memberService.GetWorkTimeOTApprove(criteria);
		 }
		 catch(Exception ex)
		 {
			 throw new HTTPException(404);
		 }
	 }
	 @RequestMapping(value = "/member-updateworktimeot", method = RequestMethod.POST)
	    @ResponseBody
	    public ResultObj UpdateWorkTimeOT( @RequestBody WorkTimeCriteriaObj criteria) throws HTTPException, IOException {
		 
		 try
		 {
	        return memberService.UpdateWorkTimeOT(criteria);
		 }
		 catch(Exception ex)
		 {
			 throw new HTTPException(404);
		 }
	 }
	 @RequestMapping(value = "/member-getsumaryot", method = RequestMethod.POST)
	    @ResponseBody
	    public List<SumaryOtObj> getSumaryOT( @RequestBody SumaryOtCriteriaObj criteria) throws HTTPException, IOException {
		 
		 try
		 {
	        return memberService.GetSumaryOT(criteria);
		 }
		 catch(Exception ex)
		 {
			 throw new HTTPException(404);
		 }
	 }
	 @RequestMapping(value = "/member-getworkstate", method = RequestMethod.POST)
	    @ResponseBody
	    public List<WorkStateObj> getWorkState( @RequestBody WorkStateCriteriaObj criteria) throws HTTPException, IOException {
		 
		 try
		 {
	        return memberService.GetWorkState(criteria);
		 }
		 catch(Exception ex)
		 {
			 throw new HTTPException(404);
		 }
	 }
	 
	 @RequestMapping(value = "/member-getedittimelist", method = RequestMethod.POST)
	    @ResponseBody
	    public List<WorkTimeObj> getEditTimeList( @RequestBody WorkTimeCriteriaObj criteria) throws HTTPException, IOException {
		 
		 try
		 {
	        return memberService.GetEditTimeList(criteria);
		 }
		 catch(Exception ex)
		 {
			 throw new HTTPException(404);
		 }
	 }
	 @RequestMapping(value = "/member-getleavelist", method = RequestMethod.POST)
	    @ResponseBody
	    public List<WorkTimeObj> getLeaveList( @RequestBody WorkTimeCriteriaObj criteria) throws HTTPException, IOException {
		 
		 try
		 {
	        return memberService.GetLeaveList(criteria);
		 }
		 catch(Exception ex)
		 {
			 throw new HTTPException(404);
		 }
	 }
	 @RequestMapping(value = "/member-getcalculateot", method = RequestMethod.POST)
	    @ResponseBody
	    public List<WorkTimeObj> getCalculateOT( @RequestBody WorkTimeCriteriaObj criteria) throws HTTPException, IOException {
		 
		 try
		 {
	        return memberService.GetCaculateOT(criteria);
		 }
		 catch(Exception ex)
		 {
			 throw new HTTPException(404);
		 }
	 }

	 @RequestMapping(value = "/member-insertworkout", method = RequestMethod.POST)
	    @ResponseBody
	    public ResultObj InsertWorkOut( @RequestBody WorkOutCriteriaObj criteria) throws HTTPException, IOException {
		 
		 try
		 {
	        return memberService.InsertWorkOut(criteria);
		 }
		 catch(Exception ex)
		 {
			 throw new HTTPException(404);
		 }
	 }
	 
	 @RequestMapping(value = "/member-getmemberworkout", method = RequestMethod.POST)
	    @ResponseBody
	    public List<WorkOutObj> getWorkOut( @RequestBody WorkOutCriteriaObj criteria) throws HTTPException, IOException {
		 
		 try
		 {
	        return memberService.GetMemberWorkOut(criteria);
		 }
		 catch(Exception ex)
		 {
			 throw new HTTPException(404);
		 }
	 }
	
	 @RequestMapping(value = "/member-getworkout-approve", method = RequestMethod.POST)
	    @ResponseBody
	    public List<WorkOutObj> getWorkOutApprove( @RequestBody WorkOutCriteriaObj criteria) throws HTTPException, IOException {
		 
		 try
		 {
	        return memberService.GetWorkOutApprove(criteria);
		 }
		 catch(Exception ex)
		 {
			 throw new HTTPException(404);
		 }
	 }
	
	 @RequestMapping(value = "/member-updateworkout", method = RequestMethod.POST)
	    @ResponseBody
	    public ResultObj UpdateWorkOut( @RequestBody WorkOutCriteriaObj criteria) throws HTTPException, IOException {
		 
		 try
		 {
	        return memberService.UpdateWorkOut(criteria);
		 }
		 catch(Exception ex)
		 {
			 throw new HTTPException(404);
		 }
	 }
	 
	 @RequestMapping(value = "/member-updateworkout-edit", method = RequestMethod.POST)
	    @ResponseBody
	    public ResultObj UpdateWorkOutEdit( @RequestBody WorkOutCriteriaObj criteria) throws HTTPException, IOException {
		 
		 try
		 {
	        return memberService.UpdateWorkOutEdit(criteria);
		 }
		 catch(Exception ex)
		 {
			 throw new HTTPException(404);
		 }
	 }
	 
	 @RequestMapping(value = "/member-cancelworkout-request", method = RequestMethod.POST)
	    @ResponseBody
	    public ResultObj CancelWorkOutRequest( @RequestBody WorkOutCriteriaObj criteria) throws HTTPException, IOException {
		 
		 try
		 {
	        return memberService.CancelWorkOutRequest(criteria);
		 }
		 catch(Exception ex)
		 {
			 throw new HTTPException(404);
		 }
	 }
	 @RequestMapping(value = "/member-valid-workout", method = RequestMethod.POST)
	    @ResponseBody
	    public ResultObj ValidateWorkOut( @RequestBody WorkOutCriteriaObj criteria) throws HTTPException, IOException {
		 
		 try
		 {
	        return memberService.ValidateWorkOut(criteria);
		 }
		 catch(Exception ex)
		 {
			 throw new HTTPException(404);
		 }
	 }
	 
	 @RequestMapping(value = "/member-getsendcarlendar-list", method = RequestMethod.GET)
	    @ResponseBody
	    public List<WorkTimeEmailMainObj> GetListCalendar() throws HTTPException, IOException {
		 
		 try
		 {
			 WorkTimeCriteriaObj criteria = new WorkTimeCriteriaObj();
	        return memberService.GetRequestListCarlendar(criteria);
		 }
		 catch(Exception ex)
		 {
			 throw new HTTPException(404);
		 }
	 }
	 
	 @RequestMapping(value = "/member-getlist-approve-email", method = RequestMethod.GET)
	    @ResponseBody
	    public List<ApproveEmailObj> GetListApproveEmail(String email_case) throws HTTPException, IOException {
		 
		 try
		 {
			 ApproveEmailCriteriaObj criteria = new ApproveEmailCriteriaObj();
			 criteria.setEmail_case(email_case);
	        return memberService.GetListApproveEmail(criteria);
		 }
		 catch(Exception ex)
		 {
			 throw new HTTPException(404);
		 }
	 }
	 @RequestMapping(value = "/member-updateapprovemail", method = RequestMethod.POST)
	    @ResponseBody
	    public ResultObj UpdateApproveMail( @RequestBody ApproveEmailCriteriaObj criteria) throws HTTPException, IOException {

		 try
		 {
	        return memberService.UpdateApproveMail(criteria);
		 }
		 catch(Exception ex)
		 {
			 throw new HTTPException(404);
		 }
	 }
	 
	 @RequestMapping(value = "/member-getmember-shifttime", method = RequestMethod.POST)
	    @ResponseBody
	    public List<ShiftTimeObj> getShiftTime( @RequestBody ShiftTimeCriteriaObj criteria) throws HTTPException, IOException {
		 
		 try
		 {
	        return memberService.GetShiftTime(criteria);
		 }
		 catch(Exception ex)
		 {
			 throw new HTTPException(404);
		 }
	 }
	 
	 @RequestMapping(value = "/member-getshifttimelist", method = RequestMethod.POST)
	    @ResponseBody
	    public List<ShiftTimeDropdownObj> getShiftTimeList( @RequestBody ShiftTimeCriteriaObj criteria) throws HTTPException, IOException {
		 
		 try
		 {
	        return memberService.GetShiftTimeList(criteria);
		 }
		 catch(Exception ex)
		 {
			 throw new HTTPException(404);
		 }
	 }
	 
	 @RequestMapping(value = "/member-update-editshifttime", method = RequestMethod.POST)
	    @ResponseBody
	    public ResultObj UpdateEditShifttime( @RequestBody List<ShiftTimeCriteriaObj> criteria) throws HTTPException, IOException {

		 try
		 {
	        return memberService.UpdateEditShifttime(criteria);
		 }
		 catch(Exception ex)
		 {
			 throw new HTTPException(404);
		 }
	 }
}

