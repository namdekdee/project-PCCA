package th.co.pt.pcca.pccaservice.service.member;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import th.co.pt.pcca.pccaservice.classobject.CGlobal;
import th.co.pt.pcca.pccaservice.dao.account.MenuDao;
import th.co.pt.pcca.pccaservice.dao.member.MemberDao;
import th.co.pt.pcca.pccaservice.entities.account.MainMenuObj;
import th.co.pt.pcca.pccaservice.entities.member.ApproveEmailCriteriaObj;
import th.co.pt.pcca.pccaservice.entities.member.ApproveEmailObj;
import th.co.pt.pcca.pccaservice.entities.member.HolidayObj;
import th.co.pt.pcca.pccaservice.entities.member.MemberObj;
import th.co.pt.pcca.pccaservice.entities.member.MoveMentObj;
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
import th.co.pt.pcca.pccaservice.entities.util.CalendarObj;
import th.co.pt.pcca.pccaservice.entities.util.MailObj;
import th.co.pt.pcca.pccaservice.entities.util.ResultObj;
import th.co.pt.pcca.pccaservice.helper.CalendarUtil;
import th.co.pt.pcca.pccaservice.helper.MailUtil;
import th.co.pt.pcca.pccaservice.helper.WebUtil;
@Service("memberService")
public class MemberServiceImpl implements MemberService {
	@Autowired
	private MemberDao memberDao;
	private  final Logger logger = LoggerFactory.getLogger(this.getClass());
	public MemberObj GetMemberProfile(MemberObj criteria){
		MemberObj result =new MemberObj();
		try
		{
		List<MemberObj> result_profile=memberDao.GetMemberProfile(criteria);
			result =result_profile.get(0);
			result.movement =memberDao.GetMoveMent(criteria);
		}catch(Exception ex)
		{
			logger.error(ex.getMessage(),ex);
		}
		return result;
	}
	
	public List<HolidayObj> GetHoliday(MemberObj criteria){
		List<HolidayObj> result =new ArrayList<HolidayObj>();
		try
		{
			result=memberDao.GetHoliday(criteria);
		}catch(Exception ex)
		{
			logger.error(ex.getMessage(),ex);
		}
		return result;
	}
	
	public List<WorkTimeObj> GetWorkTime(WorkTimeCriteriaObj criteria){
		List<WorkTimeObj> result =new ArrayList<WorkTimeObj>();
		try
		{ 
			result=memberDao.GetWorkTime(criteria);
			if(result != null){
				if(result.size()>0){
					for(int i=0;i<result.size();i++){
						if(!WebUtil.IsStringEmpty(result.get(i).getLeave_docno())){
							WorkTimeCriteriaObj criteria_leave = new WorkTimeCriteriaObj();
							criteria_leave.setCodempid(result.get(i).getCodempid());
							criteria_leave.setWork_date(result.get(i).getDtework_db());
							List<WorkTimeObj> list_leave = memberDao.GetLeaveList(criteria_leave);
							result.get(i).setList_leave(list_leave);
						}
						if(!WebUtil.IsStringEmpty(result.get(i).getOt_docno())){
							WorkTimeCriteriaObj criteria_ot = new WorkTimeCriteriaObj();
							criteria_ot.setCodempid(result.get(i).getCodempid());
							criteria_ot.setWork_date(result.get(i).getDtework_db());
							List<WorkTimeObj> list_ot = memberDao.GetOTList(criteria_ot);
							result.get(i).setList_ot(list_ot);
						}
					}
				}
			}
		}catch(Exception ex)
		{
			logger.error(ex.getMessage(),ex);
		}
		return result;
	}
	public ResultObj InsertWorkTimeEditTime(WorkTimeCriteriaObj criteria){
		ResultObj result =new ResultObj();
		try
		{
			result=memberDao.InsertWorkTimeEditTime(criteria);
		}catch(Exception ex)
		{
			logger.error(ex.getMessage(),ex);
		}
		return result;
	}
	public List<WorkTimeObj> GetWorkTimeEditTimeApprove(WorkTimeCriteriaObj criteria){
		List<WorkTimeObj> result =new ArrayList<WorkTimeObj>();
		try
		{
			result=memberDao.GetWorkTimeEditTimeApprove(criteria);
		}catch(Exception ex)
		{
			logger.error(ex.getMessage(),ex);
		}
		return result;
	}
	public ResultObj UpdateWorkTimeEditTime(WorkTimeCriteriaObj criteria){
		ResultObj result =new ResultObj();
		try
		{
			result=memberDao.UpdateWorkTimeEditTime(criteria);
//			if(result.success==1)
//			{
//				List<WorkTimeEmailObj> result_mail = memberDao.GetWorkTimeEditTimeRequestListMailApprove(criteria);
//				for(int i=0;i<result_mail.size();i++)
//				{
//					MailObj mail_obj = new MailObj();
//					mail_obj.setEmail("testaek176@gmail.com");
//					mail_obj.setPassword("AdminTest123");
//					mail_obj.setEmail_to("testaek176@gmail.com");
//					mail_obj.setSubject(result_mail.get(i).getMail_subject());
//					String bb_body = result_mail.get(i).getMail_body();
//					String[] mail_body =bb_body.split("\\|");
//					String body_head=mail_body[0]+"&nbsp;&nbsp;"+result_mail.get(i).getUser_name()+"<br/><br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
//					String body =body_head;
//					body =body+" <html><body><table border='0' cellpadding='0' cellspacing='0'>";
//					body = body +"<tr>";
//					body = body +"<td colspan='2' style='background-color:#99CC66;border: 1px solid black;height:22px;'>"+mail_body[1]+"</td>";
//					body = body +"</tr>";
//					body = body +"<tr>";
//					body = body +"<td  style='background-color:#99CC99;width:120px;border: 1px solid black;border-top:none;height:22px;'>"+mail_body[2]+"</td>";
//					body = body +"<td style='border: 1px solid black;width:200px;border-top:none;border-left:none;'>"+result_mail.get(i).getCreate_name()+"</td>";
//					body = body +"</tr>";
//					body = body +"<tr>";
//					body = body +"<td  style='background-color:#99CC99;width:120px;border: 1px solid black;border-top:none;height:22px;'>"+mail_body[3]+"</td>";
//					body = body +"<td  style='border: 1px solid black;width:200px;border-top:none;border-left:none;'>"+result_mail.get(i).getCreate_date()+"</td>";
//					body = body +"</tr>";
//					body = body +"<tr>";
//					body = body +"<td  style='background-color:#99CC99;width:120px;border: 1px solid black;border-top:none;height:22px;'>"+mail_body[4]+"</td>";
//					body = body +"<td  style='border: 1px solid black;width:200px;border-top:none;border-left:none;'>"+result_mail.get(i).getWork_date()+"</td>";
//					body = body +"</tr>";
//					body = body +"<tr>";
//					body = body +"<td  style='background-color:#99CC99;width:120px;border: 1px solid black;border-top:none;height:22px;'>"+mail_body[5]+"</td>";
//					body = body +"<td  style='border: 1px solid black;width:200px;border-top:none;border-left:none;'>"+result_mail.get(i).getTime_in_out()+"</td>";
//					body = body +"</tr>";
//					body = body +"<tr>";
//					body = body +"<td  style='background-color:#99CC99;width:120px;border: 1px solid black;border-top:none;height:22px;'>"+mail_body[6]+"</td>";
//					body = body +"<td  style='border: 1px solid black;width:200px;border-top:none;border-left:none;'>"+result_mail.get(i).getDocument_status()+"</td>";
//					body = body +"</tr>";
//					body = body +"<tr>";
//					body = body +"<td  style='background-color:#99CC99;width:120px;border: 1px solid black;border-top:none;height:22px;'>"+mail_body[7]+"</td>";
//					body = body +"<td  style='border: 1px solid black;width:200px;border-top:none;border-left:none;'>"+result_mail.get(i).getRemark()+"</td>";
//					body = body +"</tr>";
//					body = body +"</table></body></html>";
//					body = body +"<br/><br/>";
//					
//					String body_footer=result_mail.get(i).getMail_footer();
//					body_footer=body_footer.replace("{0}", "");
//					//message.setText(body);
//					body =body+body_footer;
//					
//					mail_obj.setBody(body);
//					MailUtil.SendMail(mail_obj);
//					
//					CalendarObj calen_obj =new CalendarObj();
//					calen_obj.setEmail("testaek176@gmail.com");
//					calen_obj.setEmail_invite("test@gmail.com");
//					calen_obj.setSubject(result_mail.get(i).getMail_subject());
//					calen_obj.setBody(body);
//					calen_obj.setLocation("Cyber World");
//					calen_obj.setStart_date(new Date());
//					calen_obj.setEnd_date(new Date());
//					
//					CalendarUtil.AddEvent(calen_obj);
//				}
//			}
			
		}catch(Exception ex)
		{
			logger.error(ex.getMessage(),ex);
		}
		return result;
	}
	public List<WorkTimeEmailMainObj> GetWorkTimeEditTimeRequestListMail(WorkTimeCriteriaObj criteria){
		List<WorkTimeEmailMainObj> result =new ArrayList<WorkTimeEmailMainObj>();
		List<WorkTimeEmailObj> result_dao =new ArrayList<WorkTimeEmailObj>();
		try
		{
			result_dao=memberDao.GetWorkTimeEditTimeRequestListMail(criteria);
			int check =0;
			WorkTimeEmailMainObj main_obj = new WorkTimeEmailMainObj();
			List<WorkTimeEmailObj> det_list =new ArrayList<WorkTimeEmailObj>();
			WorkTimeEmailObj det_obj =new WorkTimeEmailObj();
			for(int i=0;i<result_dao.size();i++){
				check =0;
				String approver =result_dao.get(i).getApprover_id();
				for(int k=0;k<result.size();k++){
					if(approver.equals(result.get(k).getApprover_id())){
						check++;
					}
				}
					if(check==0)
					{
						main_obj =new WorkTimeEmailMainObj();
						main_obj.setApprover_id(approver);
						main_obj.setApprover_name(result_dao.get(i).getApprover_name());
						main_obj.setApprover_comp(result_dao.get(i).getApprover_comp());
						main_obj.setApprove_link(result_dao.get(i).getApprove_link());
						main_obj.setApprover_email(result_dao.get(i).getApprover_email());
						main_obj.setTrans_id(result_dao.get(i).getTrans_id());
						main_obj.setMail_body(result_dao.get(i).getMail_body());
						main_obj.setMail_footer(result_dao.get(i).getMail_footer());
						main_obj.setMail_subject(result_dao.get(i).getMail_subject());
						
						result.add(main_obj);
					}
				
			}
			
			for(int i=0;i<result.size();i++){
				check =0;
				det_list =new ArrayList<WorkTimeEmailObj>();
				String approver =result.get(i).getApprover_id();
				for(int j=0;j<result_dao.size();j++){
					if(approver.equals(result_dao.get(j).getApprover_id())){
						det_obj =new WorkTimeEmailObj();
						det_obj.setUser_id(result_dao.get(j).getUser_id());
						det_obj.setUser_name(result_dao.get(j).getUser_name());
						det_obj.setUser_comp(result_dao.get(j).getUser_comp());
						det_list.add(det_obj);
					}
				}
				result.get(i).setList_user(det_list);
			}
		}catch(Exception ex)
		{
			logger.error(ex.getMessage(),ex);
		}
		return result;
	}
	public ResultObj UpdateWorkTimeEditTimeMail(WorkTimeCriteriaObj criteria){
		ResultObj result =new ResultObj();
		try
		{
			result=memberDao.UpdateWorkTimeEditTimeMail(criteria);
		}catch(Exception ex)
		{
			logger.error(ex.getMessage(),ex);
		}
		return result;
	}
	public WorkTimeLeaveObj GetWorkTimeLeavePermiss(WorkTimeCriteriaObj criteria){
		WorkTimeLeaveObj result =new WorkTimeLeaveObj();
		try
		{
			result=memberDao.GetWorkTimeLeavePermiss(criteria);
		}catch(Exception ex)
		{
			logger.error(ex.getMessage(),ex);
		}
		return result;
	}
	public ResultObj InsertWorkTimeLeave(WorkTimeCriteriaObj criteria){
		ResultObj result =new ResultObj();
		try
		{
			result=memberDao.InsertWorkTimeLeave(criteria);
		}catch(Exception ex)
		{
			logger.error(ex.getMessage(),ex);
		}
		return result;
	}
	
	public List<WorkTimeObj> GetWorkTimeLeaveApprove(WorkTimeCriteriaObj criteria){
		List<WorkTimeObj> result =new ArrayList<WorkTimeObj>();
		try
		{
			result=memberDao.GetWorkTimeLeaveApprove(criteria);
		}catch(Exception ex)
		{
			logger.error(ex.getMessage(),ex);
		}
		return result;
	}
	public ResultObj UpdateWorkTimeLeave(WorkTimeCriteriaObj criteria){
		ResultObj result =new ResultObj();
		try
		{
			result=memberDao.UpdateWorkTimeLeave(criteria);
//			if(result.success==1)
//			{
//				List<WorkTimeEmailObj> result_mail = memberDao.GetWorkTimeLeaveRequestListMailApprove(criteria);
//				for(int i=0;i<result_mail.size();i++)
//				{
//					MailObj mail_obj = new MailObj();
//					mail_obj.setEmail("testaek176@gmail.com");
//					mail_obj.setPassword("AdminTest123");
//					mail_obj.setEmail_to("testaek176@gmail.com");
//					mail_obj.setSubject(result_mail.get(i).getMail_subject());
//					
//					String bb_body = result_mail.get(i).getMail_body();
//					String[] mail_body =bb_body.split("\\|");
//					String body_head=mail_body[0]+"&nbsp;&nbsp;"+result_mail.get(i).getUser_name()+"<br/><br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
//					String body =body_head;
//					body =body+" <html><body><table border='0' cellpadding='0' cellspacing='0'>";
//					body = body +"<tr>";
//					body = body +"<td colspan='2' style='background-color:#99CC66;border: 1px solid black;height:22px;'>"+mail_body[1]+"&nbsp;&nbsp;"+result_mail.get(i).getTrans_id()+"</td>";
//					body = body +"</tr>";
//					body = body +"<tr>";
//					body = body +"<td  style='background-color:#99CC99;width:120px;border: 1px solid black;border-top:none;height:22px;'>"+mail_body[2]+"</td>";
//					body = body +"<td style='border: 1px solid black;width:200px;border-top:none;border-left:none;'>"+result_mail.get(i).getCreate_name()+"</td>";
//					body = body +"</tr>";
//					body = body +"<tr>";
//					body = body +"<td  style='background-color:#99CC99;width:120px;border: 1px solid black;border-top:none;height:22px;'>"+mail_body[3]+"</td>";
//					body = body +"<td  style='border: 1px solid black;width:200px;border-top:none;border-left:none;'>"+result_mail.get(i).getCreate_date()+"</td>";
//					body = body +"</tr>";
//					body = body +"<tr>";
//					body = body +"<td  style='background-color:#99CC99;width:120px;border: 1px solid black;border-top:none;height:22px;'>"+mail_body[4]+"</td>";
//					body = body +"<td  style='border: 1px solid black;width:200px;border-top:none;border-left:none;'>"+result_mail.get(i).getLeave_desc()+"</td>";
//					body = body +"</tr>";
//					body = body +"<tr>";
//					body = body +"<td  style='background-color:#99CC99;width:120px;border: 1px solid black;border-top:none;height:22px;'>"+mail_body[5]+"</td>";
//					body = body +"<td  style='border: 1px solid black;width:200px;border-top:none;border-left:none;'>"+result_mail.get(i).getLeave_date()+"</td>";
//					body = body +"</tr>";
//					body = body +"<tr>";
//					body = body +"<td  style='background-color:#99CC99;width:120px;border: 1px solid black;border-top:none;height:22px;'>"+mail_body[6]+"</td>";
//					body = body +"<td  style='border: 1px solid black;width:200px;border-top:none;border-left:none;'>"+result_mail.get(i).getDocument_status()+"</td>";
//					body = body +"</tr>";
//					body = body +"<tr>";
//					body = body +"<td  style='background-color:#99CC99;width:120px;border: 1px solid black;border-top:none;height:22px;'>"+mail_body[7]+"</td>";
//					body = body +"<td  style='border: 1px solid black;width:200px;border-top:none;border-left:none;'>"+result_mail.get(i).getRemark()+"</td>";
//					body = body +"</tr>";
//					body = body +"</table></body></html>";
//					body = body +"<br/><br/>";
//					
//					String body_footer=result_mail.get(i).getMail_footer();
//					body_footer=body_footer.replace("{0}", "");
//					//message.setText(body);
//					body =body+body_footer;
//					
//					mail_obj.setBody(body);
//					MailUtil.SendMail(mail_obj);
//					
//					CalendarObj calen_obj =new CalendarObj();
//					calen_obj.setEmail("testaek176@gmail.com");
//					calen_obj.setEmail_invite("test@gmail.com");
//					calen_obj.setSubject(result_mail.get(i).getMail_subject());
//					calen_obj.setBody(body);
//					calen_obj.setLocation("Cyber World");
//					calen_obj.setStart_date(new Date());
//					calen_obj.setEnd_date(new Date());
//					
//					CalendarUtil.AddEvent(calen_obj);
//				}
//			}
			
		}catch(Exception ex)
		{
			logger.error(ex.getMessage(),ex);
		}
		return result;
	}
	public ResultObj InsertWorkTimeOT(WorkTimeCriteriaObj criteria){
		ResultObj result =new ResultObj();
		try
		{
			result=memberDao.InsertWorkTimeOT(criteria);
		}catch(Exception ex)
		{
			logger.error(ex.getMessage(),ex);
		}
		return result;
	}
	public List<WorkTimeObj> GetWorkTimeOTApprove(WorkTimeCriteriaObj criteria){
		List<WorkTimeObj> result =new ArrayList<WorkTimeObj>();
		try
		{
			result=memberDao.GetWorkTimeOTApprove(criteria);
		}catch(Exception ex)
		{
			logger.error(ex.getMessage(),ex);
		}
		return result;
	}
	public ResultObj UpdateWorkTimeOT(WorkTimeCriteriaObj criteria){
		ResultObj result =new ResultObj();
		try
		{
			result=memberDao.UpdateWorkTimeOT(criteria);
//			if(result.success==1)
//			{
//				List<WorkTimeEmailObj> result_mail = memberDao.GetWorkTimeOTRequestListMailApprove(criteria);
//				for(int i=0;i<result_mail.size();i++)
//				{
//					MailObj mail_obj = new MailObj();
//					mail_obj.setEmail("testaek176@gmail.com");
//					mail_obj.setPassword("AdminTest123");
//					mail_obj.setEmail_to("testaek176@gmail.com");
//					mail_obj.setSubject(result_mail.get(i).getMail_subject());
//					
//					String bb_body = result_mail.get(i).getMail_body();
//					String[] mail_body =bb_body.split("\\|");
//					String body_head=mail_body[0]+"&nbsp;&nbsp;"+result_mail.get(i).getUser_name()+"<br/><br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
//					String body =body_head;
//					body =body+" <html><body><table border='0' cellpadding='0' cellspacing='0'>";
//					body = body +"<tr>";
//					body = body +"<td colspan='2' style='background-color:#99CC66;border: 1px solid black;height:22px;'>"+mail_body[1]+"&nbsp;&nbsp;"+result_mail.get(i).getTrans_id()+"</td>";
//					body = body +"</tr>";
//					body = body +"<tr>";
//					body = body +"<td  style='background-color:#99CC99;width:120px;border: 1px solid black;border-top:none;height:22px;'>"+mail_body[2]+"</td>";
//					body = body +"<td style='border: 1px solid black;width:200px;border-top:none;border-left:none;'>"+result_mail.get(i).getCreate_name()+"</td>";
//					body = body +"</tr>";
//					body = body +"<tr>";
//					body = body +"<td  style='background-color:#99CC99;width:120px;border: 1px solid black;border-top:none;height:22px;'>"+mail_body[3]+"</td>";
//					body = body +"<td  style='border: 1px solid black;width:200px;border-top:none;border-left:none;'>"+result_mail.get(i).getCreate_date()+"</td>";
//					body = body +"</tr>";
//					body = body +"<tr>";
//					body = body +"<td  style='background-color:#99CC99;width:120px;border: 1px solid black;border-top:none;height:22px;'>"+mail_body[4]+"</td>";
//					body = body +"<td  style='border: 1px solid black;width:200px;border-top:none;border-left:none;'>"+result_mail.get(i).getWork_date()+"</td>";
//					body = body +"</tr>";
//					body = body +"<tr>";
//					body = body +"<td  style='background-color:#99CC99;width:120px;border: 1px solid black;border-top:none;height:22px;'>"+mail_body[5]+"</td>";
//					body = body +"<td  style='border: 1px solid black;width:200px;border-top:none;border-left:none;'>"+result_mail.get(i).getTime_in_out()+"</td>";
//					body = body +"</tr>";
//					body = body +"<tr>";
//					body = body +"<td  style='background-color:#99CC99;width:120px;border: 1px solid black;border-top:none;height:22px;'>"+mail_body[6]+"</td>";
//					body = body +"<td  style='border: 1px solid black;width:200px;border-top:none;border-left:none;'>"+result_mail.get(i).getDocument_status()+"</td>";
//					body = body +"</tr>";
//					body = body +"<tr>";
//					body = body +"<td  style='background-color:#99CC99;width:120px;border: 1px solid black;border-top:none;height:22px;'>"+mail_body[7]+"</td>";
//					body = body +"<td  style='border: 1px solid black;width:200px;border-top:none;border-left:none;'>"+result_mail.get(i).getRemark()+"</td>";
//					body = body +"</tr>";
//					body = body +"</table></body></html>";
//					body = body +"<br/><br/>";
//					
//					String body_footer=result_mail.get(i).getMail_footer();
//					body_footer=body_footer.replace("{0}", "");
//					//message.setText(body);
//					body =body+body_footer;
//					
//					mail_obj.setBody(body);
//					MailUtil.SendMail(mail_obj);
//					
//					CalendarObj calen_obj =new CalendarObj();
//					calen_obj.setEmail("testaek176@gmail.com");
//					calen_obj.setEmail_invite("test@gmail.com");
//					calen_obj.setSubject(result_mail.get(i).getMail_subject());
//					calen_obj.setBody(body);
//					calen_obj.setLocation("Cyber World");
//					calen_obj.setStart_date(new Date());
//					calen_obj.setEnd_date(new Date());
//					
//					CalendarUtil.AddEvent(calen_obj);
//				}
//			}
			
		}catch(Exception ex)
		{
			logger.error(ex.getMessage(),ex);
		}
		return result;
	}
	
	public List<SumaryOtObj> GetSumaryOT(SumaryOtCriteriaObj criteria){
		List<SumaryOtObj> result =new ArrayList<SumaryOtObj>();
		try
		{
			result=memberDao.GetSumaryOT(criteria);
		}catch(Exception ex)
		{
			logger.error(ex.getMessage(),ex);
		}
		return result;
	}
	
	public List<WorkStateObj> GetWorkState(WorkStateCriteriaObj criteria){
		List<WorkStateObj> result =new ArrayList<WorkStateObj>();
		try
		{
			result=memberDao.GetWorkState(criteria);
		}catch(Exception ex)
		{
			logger.error(ex.getMessage(),ex);
		}
		return result;
	}
	
	public List<WorkTimeObj> GetEditTimeList(WorkTimeCriteriaObj criteria){
		List<WorkTimeObj> result =new ArrayList<WorkTimeObj>();
		try
		{
			result=memberDao.GetEditTimeList(criteria);
		}catch(Exception ex)
		{
			logger.error(ex.getMessage(),ex);
		}
		return result;
	}
	public List<WorkTimeObj> GetLeaveList(WorkTimeCriteriaObj criteria){
		List<WorkTimeObj> result =new ArrayList<WorkTimeObj>();
		try
		{
			result=memberDao.GetLeaveList(criteria);
		}catch(Exception ex)
		{
			logger.error(ex.getMessage(),ex);
		}
		return result;
	}
	
	public List<WorkTimeObj> GetCaculateOT(WorkTimeCriteriaObj criteria){
		List<WorkTimeObj> result =new ArrayList<WorkTimeObj>();
		try
		{
			result=memberDao.GetCaculateOT(criteria);
		}catch(Exception ex)
		{
			logger.error(ex.getMessage(),ex);
		}
		return result;
	}

	
	public List<WorkOutObj> GetMemberWorkOut(WorkOutCriteriaObj criteria) {
		List<WorkOutObj> result =new ArrayList<WorkOutObj>();
		try
		{
			result=memberDao.GetMemberWorkOut(criteria);
		}catch(Exception ex)
		{
			logger.error(ex.getMessage(),ex);
		}
		return result;
	}

	
	public ResultObj InsertWorkOut(WorkOutCriteriaObj criteria) {
		ResultObj result =new ResultObj();
		try
		{
			result=memberDao.InsertWorkOut(criteria);
		}catch(Exception ex)
		{
			logger.error(ex.getMessage(),ex);
		}
		return result;
	}

	public ResultObj UpdateWorkOutEdit(WorkOutCriteriaObj criteria){
		ResultObj result =new ResultObj();
		try
		{
			result=memberDao.UpdateWorkOutEdit(criteria);
			
		}catch(Exception ex)
		{
			logger.error(ex.getMessage(),ex);
		}
		return result;
		}
	
	public ResultObj CancelWorkOutRequest(WorkOutCriteriaObj criteria){
		ResultObj result =new ResultObj();
		try
		{
			result=memberDao.CancelWorkOutRequest(criteria);
			
		}catch(Exception ex)
		{
			logger.error(ex.getMessage(),ex);
		}
		return result;
		}
	
	public ResultObj UpdateWorkOut(WorkOutCriteriaObj criteria){
		ResultObj result =new ResultObj();
		try
		{
			result=memberDao.UpdateWorkOut(criteria);
			
		}catch(Exception ex)
		{
			logger.error(ex.getMessage(),ex);
		}
		return result;
		}

	
	public List<WorkOutObj> GetWorkOutApprove(WorkOutCriteriaObj criteria){
		List<WorkOutObj> result =new ArrayList<WorkOutObj>();
		try
		{
			result=memberDao.GetWorkOutApprove(criteria);
		}catch(Exception ex)
		{
			logger.error(ex.getMessage(),ex);
		}
		return result;
	}
	public ResultObj ValidateWorkOut(WorkOutCriteriaObj criteria){
		ResultObj result =new ResultObj();
		try
		{
			result=memberDao.ValidateWorkOut(criteria);
			
		}catch(Exception ex)
		{
			logger.error(ex.getMessage(),ex);
		}
		return result;
		}
	
	public List<WorkTimeEmailMainObj> GetRequestListCarlendar(WorkTimeCriteriaObj criteria){
		List<WorkTimeEmailMainObj> result =new ArrayList<WorkTimeEmailMainObj>();
		List<WorkTimeEmailObj> result_dao =new ArrayList<WorkTimeEmailObj>();
		try
		{
			result_dao=memberDao.GetRequestListCarlendar(criteria);
			int check =0;
			WorkTimeEmailMainObj main_obj = new WorkTimeEmailMainObj();
			List<WorkTimeEmailObj> det_list =new ArrayList<WorkTimeEmailObj>();
			WorkTimeEmailObj det_obj =new WorkTimeEmailObj();
			for(int i=0;i<result_dao.size();i++){
				check =0;
				String approver =result_dao.get(i).getApprover_id();
				for(int k=0;k<result.size();k++){
					if(approver.equals(result.get(k).getApprover_id())){
						check++;
					}
				}
					if(check==0)
					{
						main_obj =new WorkTimeEmailMainObj();
						main_obj.setApprover_id(approver);
						main_obj.setApprover_name(result_dao.get(i).getApprover_name());
						main_obj.setApprover_comp(result_dao.get(i).getApprover_comp());
						main_obj.setApprove_link(result_dao.get(i).getApprove_link());
						main_obj.setApprover_email(result_dao.get(i).getApprover_email());
						main_obj.setTrans_id(result_dao.get(i).getTrans_id());
						main_obj.setMail_body(result_dao.get(i).getMail_body());
						main_obj.setMail_footer(result_dao.get(i).getMail_footer());
						main_obj.setMail_subject(result_dao.get(i).getMail_subject());
						result.add(main_obj);
					}
				
			}
			
			for(int i=0;i<result.size();i++){
				check =0;
				det_list =new ArrayList<WorkTimeEmailObj>();
				String approver =result.get(i).getApprover_id();
				for(int j=0;j<result_dao.size();j++){
					if(approver.equals(result_dao.get(j).getApprover_id())){
						det_obj =new WorkTimeEmailObj();
						det_obj.setUser_id(result_dao.get(i).getUser_id());
						det_obj.setUser_name(result_dao.get(i).getUser_name());
						det_obj.setUser_comp(result_dao.get(i).getUser_comp());
						det_obj.setRequest_seq(result_dao.get(j).getRequest_seq());
						det_obj.setRequest_qty(result_dao.get(j).getRequest_qty());
						det_list.add(det_obj);
					}
				}
				result.get(i).setList_user(det_list);
			}
		}catch(Exception ex)
		{
			logger.error(ex.getMessage(),ex);
		}
		return result;
	}
	
	public List<ApproveEmailObj> GetListApproveEmail(ApproveEmailCriteriaObj criteria){
		List<ApproveEmailObj> result =new ArrayList<ApproveEmailObj>();
		try
		{
			result=memberDao.GetListApproveEmail(criteria);
		}catch(Exception ex)
		{
			logger.error(ex.getMessage(),ex);
		}
		return result;
	}
	public ResultObj UpdateApproveMail(ApproveEmailCriteriaObj criteria){
		ResultObj result =new ResultObj();
		try
		{
			result=memberDao.UpdateApproveMail(criteria);
			
		}catch(Exception ex)
		{
			logger.error(ex.getMessage(),ex);
		}
		return result;
		}
	
	public List<ShiftTimeObj> GetShiftTime(ShiftTimeCriteriaObj criteria){
		List<ShiftTimeObj> result =new ArrayList<ShiftTimeObj>();
		try
		{ 
			result=memberDao.GetShiftTime(criteria);
		
		}catch(Exception ex)
		{
			logger.error(ex.getMessage(),ex);
		}
		return result;
	}
	
	public List<ShiftTimeDropdownObj> GetShiftTimeList(ShiftTimeCriteriaObj criteria){
		List<ShiftTimeDropdownObj> result =new ArrayList<ShiftTimeDropdownObj>();
		try
		{ 
			result=memberDao.GetShiftTimeList(criteria);
		
		}catch(Exception ex)
		{
			logger.error(ex.getMessage(),ex);
		}
		return result;
	} 
	
	public ResultObj UpdateEditShifttime(List<ShiftTimeCriteriaObj> criteria){
		ResultObj result =new ResultObj();
		try
		{
			result=memberDao.UpdateEditShifttime(criteria);
			
		}catch(Exception ex)
		{
			logger.error(ex.getMessage(),ex);
		}
		return result;
	}
	
}
