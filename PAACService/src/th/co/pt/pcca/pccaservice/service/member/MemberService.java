package th.co.pt.pcca.pccaservice.service.member;

import java.util.List;

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
import th.co.pt.pcca.pccaservice.entities.member.WorkTimeEmailObj;
import th.co.pt.pcca.pccaservice.entities.member.WorkTimeLeaveObj;
import th.co.pt.pcca.pccaservice.entities.member.WorkTimeObj;
import th.co.pt.pcca.pccaservice.entities.util.ResultObj;

public interface MemberService {
	MemberObj GetMemberProfile(MemberObj criteria);
	List<HolidayObj> GetHoliday(MemberObj criteria);
	List<WorkTimeObj> GetWorkTime(WorkTimeCriteriaObj criteria);
	ResultObj InsertWorkTimeEditTime(WorkTimeCriteriaObj criteria);
	List<WorkTimeObj> GetWorkTimeEditTimeApprove(WorkTimeCriteriaObj criteria);
	ResultObj UpdateWorkTimeEditTime(WorkTimeCriteriaObj criteria);
	List<WorkTimeEmailMainObj> GetWorkTimeEditTimeRequestListMail(WorkTimeCriteriaObj criteria);
	ResultObj UpdateWorkTimeEditTimeMail(WorkTimeCriteriaObj criteria);
	WorkTimeLeaveObj GetWorkTimeLeavePermiss(WorkTimeCriteriaObj criteria);
	ResultObj InsertWorkTimeLeave(WorkTimeCriteriaObj criteria);
	List<WorkTimeObj> GetWorkTimeLeaveApprove(WorkTimeCriteriaObj criteria);
	ResultObj UpdateWorkTimeLeave(WorkTimeCriteriaObj criteria);
	ResultObj InsertWorkTimeOT(WorkTimeCriteriaObj criteria);
	List<WorkTimeObj> GetWorkTimeOTApprove(WorkTimeCriteriaObj criteria);
	ResultObj UpdateWorkTimeOT(WorkTimeCriteriaObj criteria);
	List<SumaryOtObj> GetSumaryOT(SumaryOtCriteriaObj criteria);
	List<WorkStateObj> GetWorkState(WorkStateCriteriaObj criteria);
	List<WorkTimeObj> GetEditTimeList(WorkTimeCriteriaObj criteria);
	List<WorkTimeObj> GetLeaveList(WorkTimeCriteriaObj criteria);
	List<WorkTimeObj> GetCaculateOT(WorkTimeCriteriaObj criteria);

	List<WorkOutObj> GetMemberWorkOut(WorkOutCriteriaObj criteria);
	ResultObj InsertWorkOut(WorkOutCriteriaObj criteria);
	ResultObj UpdateWorkOutEdit(WorkOutCriteriaObj criteria);
	ResultObj CancelWorkOutRequest(WorkOutCriteriaObj criteria);
	ResultObj UpdateWorkOut(WorkOutCriteriaObj criteria);
	List<WorkOutObj> GetWorkOutApprove(WorkOutCriteriaObj criteria);
	ResultObj ValidateWorkOut(WorkOutCriteriaObj criteria);
	
	List<WorkTimeEmailMainObj> GetRequestListCarlendar(WorkTimeCriteriaObj criteria);
	List<ApproveEmailObj> GetListApproveEmail(ApproveEmailCriteriaObj criteria);
	ResultObj UpdateApproveMail(ApproveEmailCriteriaObj criteria);
	
	List<ShiftTimeObj> GetShiftTime(ShiftTimeCriteriaObj criteria);
	List<ShiftTimeDropdownObj> GetShiftTimeList(ShiftTimeCriteriaObj criteria);
	ResultObj UpdateEditShifttime (List<ShiftTimeCriteriaObj> criteria);
	//ResultObj UpdateEditShifttime(ShiftTimeObj criteria);
}
