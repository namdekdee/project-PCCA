package th.co.pt.pcca.pccaservice.dao.member;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import org.springframework.stereotype.Repository;
























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
import th.co.pt.pcca.pccaservice.entities.member.WorkOutResultObj;
import th.co.pt.pcca.pccaservice.entities.member.WorkStateCriteriaObj;
import th.co.pt.pcca.pccaservice.entities.member.WorkStateObj;
import th.co.pt.pcca.pccaservice.entities.member.WorkTimeCriteriaObj;
import th.co.pt.pcca.pccaservice.entities.member.WorkTimeEmailObj;
import th.co.pt.pcca.pccaservice.entities.member.WorkTimeLeaveObj;
import th.co.pt.pcca.pccaservice.entities.member.WorkTimeObj;
import th.co.pt.pcca.pccaservice.entities.util.ResultObj;
import th.co.pt.pcca.pccaservice.entities.workflow.StepWorkFlowTransactionObj;
import th.co.pt.pcca.pccaservice.helper.*;

@Repository("memberDao")
public class MemberDaoImpl implements MemberDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	private  final Logger logger = LoggerFactory.getLogger(this.getClass());
	public List<MemberObj> GetMemberProfile(MemberObj criteria) {
		List<MemberObj> result = new ArrayList<MemberObj>();
		try{
			SimpleJdbcCall call = new SimpleJdbcCall(jdbcTemplate)
			.withCatalogName("PKG_SERVICE_MEMBER")
			.withProcedureName("SP_SEARCH_MEMBER")
			.returningResultSet("P_CURSOR", new BeanPropertyRowMapper(MemberObj.class));

			result = call.executeFunction(List.class,criteria.getCodempid(),criteria.getCodcomp(),criteria.getCodpos(),criteria.getNamempt(),criteria.getDteempmt());
		
		} catch (Exception ex) {
			logger.error(ex.getMessage(),ex);
			//ex.printStackTrace();
		}
		return result;
	}
	public List<MoveMentObj> GetMoveMent(MemberObj criteria) {
		List<MoveMentObj> result = new ArrayList<MoveMentObj>();
		try{
			SimpleJdbcCall call = new SimpleJdbcCall(jdbcTemplate)
			.withCatalogName("PKG_SERVICE_MEMBER")
			.withProcedureName("SP_SEARCH_MOVEMENT")
			.returningResultSet("P_CURSOR", new BeanPropertyRowMapper(MoveMentObj.class));

			result = call.executeFunction(List.class,criteria.getCodempid());
		
		} catch (Exception ex) {
			logger.error(ex.getMessage(),ex);
			//ex.printStackTrace();
		}
		return result;
	}
	
	public List<HolidayObj> GetHoliday(MemberObj criteria) {
		List<HolidayObj> result = new ArrayList<HolidayObj>();
		try{
			SimpleJdbcCall call = new SimpleJdbcCall(jdbcTemplate)
			.withCatalogName("PKG_SERVICE_MEMBER")
			.withProcedureName("SP_SEARCH_HOLIDAY")
			.returningResultSet("P_CURSOR", new BeanPropertyRowMapper(HolidayObj.class));

			result = call.executeFunction(List.class,criteria.getCodempid(),criteria.getYear());
		
		} catch (Exception ex) {
			logger.error(ex.getMessage(),ex);
			//ex.printStackTrace();
		}
		return result;
	}
	
	public List<WorkTimeObj> GetWorkTime(WorkTimeCriteriaObj criteria) {
		List<WorkTimeObj> result = new ArrayList<WorkTimeObj>();
		try{
			
			SimpleJdbcCall call = new SimpleJdbcCall(jdbcTemplate)
			.withCatalogName("PKG_WORKTIME")
			.withProcedureName("SP_SEARCH_WORKTIME2")	
//			.withProcedureName("SP_SEARCH_WORKTIME")	
			.returningResultSet("P_CURSOR", new BeanPropertyRowMapper(WorkTimeObj.class));

			result = call.executeFunction(List.class,criteria.getApprover(),criteria.getCodempid(),criteria.getStart_date(),criteria.getEnd_date(),criteria.getWork_type(),criteria.getCompany_id());
		
		} catch (Exception ex) {
			logger.error(ex.getMessage(),ex);
			//ex.printStackTrace();
		}
		return result;
	}
	
	public ResultObj InsertWorkTimeEditTime(WorkTimeCriteriaObj criteria) {
		ResultObj result = new ResultObj();
		try{
			SimpleJdbcCall call = new SimpleJdbcCall(jdbcTemplate)
			.withCatalogName("PKG_WORKTIME_EDITTIME")
			.withProcedureName("SP_INSERT_WORKTIME_EDITTIME");
			SqlParameterSource in = new MapSqlParameterSource()
			.addValue("P_TRANS_ID", criteria.getTrans_id())
			.addValue("P_CASE", criteria.getSave_case())
	        .addValue("P_EMP_ID", criteria.getCodempid())
	        .addValue("P_COMPANY_ID", criteria.getCompany_id())
	        .addValue("P_CODE_SHIFT", criteria.getCod_shift())
	        .addValue("P_WORK_DATE", criteria.getWork_date())
	        .addValue("P_START_DATE", criteria.getStart_date())
	        .addValue("P_END_DATE", criteria.getEnd_date())
	        .addValue("P_TIME_IN", criteria.getTime_in())
	        .addValue("P_TIME_OUT", criteria.getTime_out())
	        .addValue("P_TIME_CAUSE", criteria.getTime_cause())
	        .addValue("P_REMARK", criteria.getRemark())
	        .addValue("P_UPDATE_USER", criteria.getUpdate_user()); 
			Map<String,Object> out = call.execute(in);
			result.success = ((BigDecimal)out.get("P_STATUS")).intValue();
			result.message =(String)out.get("P_MESSAGE");
		
		} catch (Exception ex) {
			result.setSuccess(0);
			result.setMessage(ex.getMessage());
			logger.error(ex.getMessage(),ex);
			//ex.printStackTrace();
		}
		return result;
	}
	
	public List<WorkTimeObj> GetWorkTimeEditTimeApprove(WorkTimeCriteriaObj criteria) {
		List<WorkTimeObj> result = new ArrayList<WorkTimeObj>();
		try{
			SimpleJdbcCall call = new SimpleJdbcCall(jdbcTemplate)
			.withCatalogName("PKG_WORKTIME_EDITTIME")
			.withProcedureName("SP_EDITTIME_SEARCH_REQUEST")
			.returningResultSet("P_CURSOR", new BeanPropertyRowMapper(WorkTimeObj.class));
			result = call.executeFunction(List.class,criteria.getApprover(),criteria.getCompany_id(),criteria.getCodempid(),criteria.getStart_date(),criteria.getEnd_date(),criteria.getStatus());
		
		} catch (Exception ex) {
			logger.error(ex.getMessage(),ex);
			//ex.printStackTrace();
		}
		return result;
	}
	public ResultObj UpdateWorkTimeEditTime(WorkTimeCriteriaObj criteria) {
		ResultObj result = new ResultObj();
		try{
			SimpleJdbcCall call = new SimpleJdbcCall(jdbcTemplate)
			.withCatalogName("PKG_WORKTIME_EDITTIME")
			.withProcedureName("SP_EDITTIME_UPDATE_REQUEST");
			SqlParameterSource in = new MapSqlParameterSource()
	        .addValue("P_TRANS_ID", criteria.getTrans_id())
	        .addValue("P_REMARK", criteria.getRemark())
	        .addValue("P_APPROVE_STATUS", criteria.getStatus())
	        .addValue("P_UPDATE_USER", criteria.getUpdate_user()); 
			Map<String,Object> out = call.execute(in);
			result.success = ((BigDecimal)out.get("P_STATUS")).intValue();
			result.message =(String)out.get("P_MESSAGE");
		
		} catch (Exception ex) {
			result.setSuccess(0);
			result.setMessage(ex.getMessage());
			logger.error(ex.getMessage(),ex);
			//ex.printStackTrace();
		}
		return result;
	}
	public List<WorkTimeEmailObj> GetWorkTimeEditTimeRequestListMail(WorkTimeCriteriaObj criteria) {
		List<WorkTimeEmailObj> result = new ArrayList<WorkTimeEmailObj>();
		try{
			SimpleJdbcCall call = new SimpleJdbcCall(jdbcTemplate)
			.withCatalogName("PKG_WORKTIME")
			.withProcedureName("SP_SEARCH_MAIL_LIST_REQ")
			.returningResultSet("P_CURSOR", new BeanPropertyRowMapper(WorkTimeEmailObj.class));
			result = call.executeFunction(List.class,criteria.getWf_id(),criteria.getEmail_id());
		
		} catch (Exception ex) {
			logger.error(ex.getMessage(),ex);
			//ex.printStackTrace();
		}
		return result;
	}
	public List<WorkTimeEmailObj> GetRequestListCarlendar(WorkTimeCriteriaObj criteria) {
		List<WorkTimeEmailObj> result = new ArrayList<WorkTimeEmailObj>();
		try{
			SimpleJdbcCall call = new SimpleJdbcCall(jdbcTemplate)
			.withCatalogName("PKG_NOTIFICATION")
			.withProcedureName("SP_CALENDAR")
			.returningResultSet("P_CURSOR", new BeanPropertyRowMapper(WorkTimeEmailObj.class));
			result = call.executeFunction(List.class);
		
		} catch (Exception ex) {
			logger.error(ex.getMessage(),ex);
			//ex.printStackTrace();
		}
		return result;
	}
	public ResultObj UpdateWorkTimeEditTimeMail(WorkTimeCriteriaObj criteria) {
		ResultObj result = new ResultObj();
		try{
			SimpleJdbcCall call = new SimpleJdbcCall(jdbcTemplate)
			.withCatalogName("PKG_WORKTIME")
			.withProcedureName("SP_UPDATE_MAILFLAG");
			SqlParameterSource in = new MapSqlParameterSource()
	        .addValue("P_APPROVE_ID", criteria.getApprover())
			.addValue("P_WF_ID", criteria.getWf_id())
			.addValue("P_EMAIL_ID", criteria.getEmail_id()); 
			Map<String,Object> out = call.execute(in);
			result.success = ((BigDecimal)out.get("P_STATUS")).intValue();
			result.message =(String)out.get("P_MESSAGE");
		
		} catch (Exception ex) {
			result.setSuccess(0);
			result.setMessage(ex.getMessage());
			logger.error(ex.getMessage(),ex);
			//ex.printStackTrace();
		}
		return result;
	}
	
	public List<WorkTimeEmailObj> GetWorkTimeEditTimeRequestListMailApprove(WorkTimeCriteriaObj criteria) {
		List<WorkTimeEmailObj> result = new ArrayList<WorkTimeEmailObj>();
		try{
			SimpleJdbcCall call = new SimpleJdbcCall(jdbcTemplate)
			.withCatalogName("PKG_WORKTIME_EDITTIME")
			.withProcedureName("SP_GET_APPROVE_MAIL")
			.returningResultSet("P_CURSOR", new BeanPropertyRowMapper(WorkTimeEmailObj.class));
			result = call.executeFunction(List.class,criteria.getTrans_id());
		
		} catch (Exception ex) {
			logger.error(ex.getMessage(),ex);
			//ex.printStackTrace();
		}
		return result;
	}
	
	public WorkTimeLeaveObj GetWorkTimeLeavePermiss(WorkTimeCriteriaObj criteria) {
		List<WorkTimeLeaveObj> result = new ArrayList<WorkTimeLeaveObj>();
		try{
			SimpleJdbcCall call = new SimpleJdbcCall(jdbcTemplate)
			.withCatalogName("PKG_WORKTIME_LAEVE")
			.withProcedureName("SP_GET_LEAVE_PERMISS")
			.returningResultSet("P_CURSOR", new BeanPropertyRowMapper(WorkTimeLeaveObj.class));
			result = call.executeFunction(List.class,criteria.getCodempid(),criteria.getLeave_id(),criteria.getStart_date());
		
		} catch (Exception ex) {
			logger.error(ex.getMessage(),ex);
			//ex.printStackTrace();
		}
		return result.get(0);
	}
	
	public ResultObj InsertWorkTimeLeave(WorkTimeCriteriaObj criteria) {
		ResultObj result = new ResultObj();
		try{
			SimpleJdbcCall call = new SimpleJdbcCall(jdbcTemplate)
			.withCatalogName("PKG_WORKTIME_LAEVE")
			.withProcedureName("SP_INSERT_WORKTIME_LEAVE");
			SqlParameterSource in = new MapSqlParameterSource()
			.addValue("P_TRANS_ID", criteria.getTrans_id())
			.addValue("P_CASE", criteria.getSave_case())
	        .addValue("P_EMP_ID", criteria.getCodempid())
	        .addValue("P_COMPANY_ID", criteria.getCompany_id())
	        .addValue("P_CODE_SHIFT", criteria.getCod_shift())
	        .addValue("P_WORK_DATE", criteria.getWork_date())
	        .addValue("P_LEAVE_ID", criteria.getLeave_id())
	        .addValue("P_ISRANGDATE", criteria.getIs_rangdate())
	        .addValue("P_START_FLAG", criteria.getStart_flag())
	        .addValue("P_END_FLAG", criteria.getEnd_flag())
	        .addValue("P_START_DATE", criteria.getStart_date())
	        .addValue("P_END_DATE", criteria.getEnd_date())
	        .addValue("P_REMARK", criteria.getRemark())
	        .addValue("P_FILE_NAME", criteria.getFile_name())	       
	        .addValue("P_UPDATE_USER", criteria.getUpdate_user()); 
			Map<String,Object> out = call.execute(in);
			result.success = ((BigDecimal)out.get("P_STATUS")).intValue();
			result.message =(String)out.get("P_MESSAGE");
		
		} catch (Exception ex) {
			result.setSuccess(0);
			result.setMessage(ex.getMessage());
			logger.error(ex.getMessage(),ex);
			//ex.printStackTrace();
		}
		return result;
	}
	
	public List<WorkTimeObj> GetWorkTimeLeaveApprove(WorkTimeCriteriaObj criteria) {
		List<WorkTimeObj> result = new ArrayList<WorkTimeObj>();
		try{
			SimpleJdbcCall call = new SimpleJdbcCall(jdbcTemplate)
			.withCatalogName("PKG_WORKTIME_LAEVE")
			.withProcedureName("SP_LEAVE_SEARCH_REQUEST")
			.returningResultSet("P_CURSOR", new BeanPropertyRowMapper(WorkTimeObj.class));
			result = call.executeFunction(List.class,criteria.getApprover(),criteria.getCompany_id(),criteria.getCodempid(),criteria.getStart_date(),criteria.getEnd_date(),criteria.getStatus());
		
		} catch (Exception ex) {
			logger.error(ex.getMessage(),ex);
			//ex.printStackTrace();
		}
		return result;
	}
	public ResultObj UpdateWorkTimeLeave(WorkTimeCriteriaObj criteria) {
		ResultObj result = new ResultObj();
		try{
			SimpleJdbcCall call = new SimpleJdbcCall(jdbcTemplate)
			.withCatalogName("PKG_WORKTIME_LAEVE")
			.withProcedureName("SP_LEAVE_UPDATE_REQUEST");
			SqlParameterSource in = new MapSqlParameterSource()
	        .addValue("P_TRANS_ID", criteria.getTrans_id())
	        .addValue("P_REMARK", criteria.getRemark())
	        .addValue("P_APPROVE_STATUS", criteria.getStatus())
	        .addValue("P_UPDATE_USER", criteria.getUpdate_user()); 
			Map<String,Object> out = call.execute(in);
			result.success = ((BigDecimal)out.get("P_STATUS")).intValue();
			result.message =(String)out.get("P_MESSAGE");
		
		} catch (Exception ex) {
			result.setSuccess(0);
			result.setMessage(ex.getMessage());
			logger.error(ex.getMessage(),ex);
			//ex.printStackTrace();
		}
		return result;
	}
	public List<WorkTimeEmailObj> GetWorkTimeLeaveRequestListMailApprove(WorkTimeCriteriaObj criteria) {
		List<WorkTimeEmailObj> result = new ArrayList<WorkTimeEmailObj>();
		try{
			SimpleJdbcCall call = new SimpleJdbcCall(jdbcTemplate)
			.withCatalogName("PKG_WORKTIME_LAEVE")
			.withProcedureName("SP_GET_APPROVE_MAIL")
			.returningResultSet("P_CURSOR", new BeanPropertyRowMapper(WorkTimeEmailObj.class));
			result = call.executeFunction(List.class,criteria.getTrans_id());
		
		} catch (Exception ex) {
			logger.error(ex.getMessage(),ex);
			//ex.printStackTrace();
		}
		return result;
	}
	
	public ResultObj InsertWorkTimeOT(WorkTimeCriteriaObj criteria) {
		ResultObj result = new ResultObj();
		try{
			SimpleJdbcCall call = new SimpleJdbcCall(jdbcTemplate)
			.withCatalogName("PKG_WORKTIME_OT")
			.withProcedureName("SP_INSERT_WORKTIME_OT");
			SqlParameterSource in = new MapSqlParameterSource()
			.addValue("P_TRANS_ID", criteria.getTrans_id())
			.addValue("P_CASE", criteria.getSave_case())
	        .addValue("P_EMP_ID", criteria.getCodempid())
	        .addValue("P_COMPANY_ID", criteria.getCompany_id())
	        .addValue("P_CODE_SHIFT", criteria.getCod_shift())
	        .addValue("P_WORK_DATE", criteria.getWork_date())
	        .addValue("P_START_DATE", criteria.getStart_date())
	        .addValue("P_END_DATE", criteria.getEnd_date())
	        .addValue("P_START_TIME", criteria.getStart_time())
	        .addValue("P_END_TIME", criteria.getEnd_time())
	        .addValue("P_OT_CAUSE", criteria.getOt_cause())
	        .addValue("P_REMARK", criteria.getRemark())       
	        .addValue("P_UPDATE_USER", criteria.getUpdate_user()); 
			Map<String,Object> out = call.execute(in);
			result.success = ((BigDecimal)out.get("P_STATUS")).intValue();
			result.message =(String)out.get("P_MESSAGE");
		
		} catch (Exception ex) {
			result.setSuccess(0);
			result.setMessage(ex.getMessage());
			logger.error(ex.getMessage(),ex);
			//ex.printStackTrace();
		}
		return result;
	}
	public List<WorkTimeObj> GetWorkTimeOTApprove(WorkTimeCriteriaObj criteria) {
		List<WorkTimeObj> result = new ArrayList<WorkTimeObj>();
		try{
			SimpleJdbcCall call = new SimpleJdbcCall(jdbcTemplate)
			.withCatalogName("PKG_WORKTIME_OT")
			.withProcedureName("SP_SEARCH_REQUEST")
			.returningResultSet("P_CURSOR", new BeanPropertyRowMapper(WorkTimeObj.class));
			result = call.executeFunction(List.class,criteria.getApprover(),criteria.getCompany_id(),criteria.getCodempid(),criteria.getStart_date(),criteria.getEnd_date(),criteria.getStatus());
		
		} catch (Exception ex) {
			logger.error(ex.getMessage(),ex);
			//ex.printStackTrace();
		}
		return result;
	}
	public ResultObj UpdateWorkTimeOT(WorkTimeCriteriaObj criteria) {
		ResultObj result = new ResultObj();
		try{
			SimpleJdbcCall call = new SimpleJdbcCall(jdbcTemplate)
			.withCatalogName("PKG_WORKTIME_OT")
			.withProcedureName("SP_UPDATE_REQUEST");
			SqlParameterSource in = new MapSqlParameterSource()
	        .addValue("P_TRANS_ID", criteria.getTrans_id())
	        .addValue("P_REMARK", criteria.getRemark())
	        .addValue("P_APPROVE_STATUS", criteria.getStatus())
	        .addValue("P_UPDATE_USER", criteria.getUpdate_user()); 
			Map<String,Object> out = call.execute(in);
			result.success = ((BigDecimal)out.get("P_STATUS")).intValue();
			result.message =(String)out.get("P_MESSAGE");
		
		} catch (Exception ex) {
			result.setSuccess(0);
			result.setMessage(ex.getMessage());
			logger.error(ex.getMessage(),ex);
			//ex.printStackTrace();
		}
		return result;
	}
	
	public List<WorkTimeEmailObj> GetWorkTimeOTRequestListMailApprove(WorkTimeCriteriaObj criteria) {
		List<WorkTimeEmailObj> result = new ArrayList<WorkTimeEmailObj>();
		try{
			SimpleJdbcCall call = new SimpleJdbcCall(jdbcTemplate)
			.withCatalogName("PKG_WORKTIME_OT")
			.withProcedureName("SP_GET_APPROVE_MAIL")
			.returningResultSet("P_CURSOR", new BeanPropertyRowMapper(WorkTimeEmailObj.class));
			result = call.executeFunction(List.class,criteria.getTrans_id());
		
		} catch (Exception ex) {
			logger.error(ex.getMessage(),ex);
			//ex.printStackTrace();
		}
		return result;
	}
	
	public List<SumaryOtObj> GetSumaryOT(SumaryOtCriteriaObj criteria) {
		List<SumaryOtObj> result = new ArrayList<SumaryOtObj>();
		try{
			SimpleJdbcCall call = new SimpleJdbcCall(jdbcTemplate)
			.withCatalogName("PKG_SUMMARY_OT")
			.withProcedureName("SP_SEARCH")
			.returningResultSet("P_CURSOR", new BeanPropertyRowMapper(SumaryOtObj.class));
			result = call.executeFunction(List.class,criteria.getApprover(),criteria.getCompany_id(),criteria.getCodempid(),criteria.getStart_date(),criteria.getEnd_date());
		
		} catch (Exception ex) {
			logger.error(ex.getMessage(),ex);
			//ex.printStackTrace();
		}
		return result;
	}
	public List<WorkStateObj> GetWorkState(WorkStateCriteriaObj criteria) {
		List<WorkStateObj> result = new ArrayList<WorkStateObj>();
		try{
			SimpleJdbcCall call = new SimpleJdbcCall(jdbcTemplate)
			.withCatalogName("PKG_WORK_STATE")
			.withProcedureName("SP_SEARCH")
			.returningResultSet("P_CURSOR", new BeanPropertyRowMapper(WorkStateObj.class));
			result = call.executeFunction(List.class,criteria.getApprover(),criteria.getCodempid(),criteria.getMonth(),criteria.getYear(),criteria.getSearch_case());
		
		} catch (Exception ex) {
			logger.error(ex.getMessage(),ex);
			//ex.printStackTrace();
		}
		return result;
	}
	
	public List<WorkTimeObj> GetEditTimeList(WorkTimeCriteriaObj criteria) {
		List<WorkTimeObj> result = new ArrayList<WorkTimeObj>();
		try{
			SimpleJdbcCall call = new SimpleJdbcCall(jdbcTemplate)
			.withCatalogName("PKG_WORKTIME_EDITTIME")
			.withProcedureName("SP_GET_REQUEST_LIST")
			.returningResultSet("P_CURSOR", new BeanPropertyRowMapper(WorkTimeObj.class));

			result = call.executeFunction(List.class,criteria.getTrans_id(),criteria.getCodempid(),criteria.getWork_date());
		
		} catch (Exception ex) {
			logger.error(ex.getMessage(),ex);
			//ex.printStackTrace();
		}
		return result;
	}
	
	public List<WorkTimeObj> GetLeaveList(WorkTimeCriteriaObj criteria) {
		List<WorkTimeObj> result = new ArrayList<WorkTimeObj>();
		try{
			SimpleJdbcCall call = new SimpleJdbcCall(jdbcTemplate)
			.withCatalogName("PKG_WORKTIME_LAEVE")
			.withProcedureName("SP_GET_REQUEST_LIST")
			.returningResultSet("P_CURSOR", new BeanPropertyRowMapper(WorkTimeObj.class));

			result = call.executeFunction(List.class,criteria.getCodempid(),criteria.getWork_date());
		
		} catch (Exception ex) {
			logger.error(ex.getMessage(),ex);
			//ex.printStackTrace();
		}
		return result;
	}
	public List<WorkTimeObj> GetCaculateOT(WorkTimeCriteriaObj criteria) {
		List<WorkTimeObj> result = new ArrayList<WorkTimeObj>();
		try{
			SimpleJdbcCall call = new SimpleJdbcCall(jdbcTemplate)
			.withCatalogName("PKG_WORKTIME_OT")
			.withProcedureName("SP_CALCULATE_OT")
			.returningResultSet("P_CURSOR", new BeanPropertyRowMapper(WorkTimeObj.class));

			result = call.executeFunction(List.class,criteria.getCodempid(),criteria.getStart_date(),criteria.getEnd_date(),criteria.getStart_time(),criteria.getEnd_time());
		
		} catch (Exception ex) {
			logger.error(ex.getMessage(),ex);
			//ex.printStackTrace();
		}
		return result;
	}
	public List<WorkTimeObj> GetOTList(WorkTimeCriteriaObj criteria) {
		List<WorkTimeObj> result = new ArrayList<WorkTimeObj>();
		try{
			SimpleJdbcCall call = new SimpleJdbcCall(jdbcTemplate)
			.withCatalogName("PKG_WORKTIME_OT")
			.withProcedureName("SP_GET_REQUEST_LIST")
			.returningResultSet("P_CURSOR", new BeanPropertyRowMapper(WorkTimeObj.class));

			result = call.executeFunction(List.class,criteria.getCodempid(),criteria.getWork_date());
		
		} catch (Exception ex) {
			logger.error(ex.getMessage(),ex);
			//ex.printStackTrace();
		}
		return result;
	}

	public ResultObj InsertWorkOut(WorkOutCriteriaObj criteria) {
		ResultObj result = new ResultObj();
		try{
			
			SimpleJdbcCall call = new SimpleJdbcCall(jdbcTemplate)
			.withCatalogName("PKG_WORKOUT")
			.withProcedureName("SP_INSERT_WORKOUT");
			SqlParameterSource in = new MapSqlParameterSource()
			 .addValue("P_CASE", criteria.getSave_case())
			 .addValue("P_TRANS_ID", criteria.getTrans_id())
	        .addValue("P_EMP_ID", criteria.getCodempid())
	        .addValue("P_DOC_INTRANET",criteria.getDoc_no())
	        .addValue("P_COMPANY_ID",criteria.getCompany_id())
	        .addValue("P_KILO_FLAG",criteria.getKilo_flag())
	        .addValue("P_ALLOW_FLAG",criteria.getAllow_flag())
	        .addValue("P_OBJECTIVE", criteria.getObjective())
	        .addValue("P_PLACE_FLAG", criteria.getPlace_flag())
	        .addValue("P_PLACE", criteria.getPlace())
	        .addValue("P_PRIVATE_FLAG", criteria.getPrivate_flag())
	        .addValue("P_START_PLACE", criteria.getStart_place())
	        .addValue("P_START_DATE", criteria.getStart_date())
	        .addValue("P_START_TIME", criteria.getStart_time())
	        .addValue("P_END_PLACE", criteria.getEnd_place())
	        .addValue("P_END_DATE", criteria.getEnd_date())
	        .addValue("P_END_TIME", criteria.getEnd_time())
	        .addValue("P_UPDATE_USER", criteria.getUpdate_user()); 
			Map<String,Object> out = call.execute(in);
			result.success = ((BigDecimal)out.get("P_STATUS")).intValue();
			result.message =(String)out.get("P_MESSAGE");
			
			
		
		} catch (Exception ex) {
			result.setSuccess(0);
			result.setMessage(ex.getMessage());
			logger.error(ex.getMessage(),ex);
			//ex.printStackTrace();
		}
		return result;
	}
	
	public List<WorkOutObj> GetMemberWorkOut(WorkOutCriteriaObj criteria) {
		List<WorkOutObj> result = new ArrayList<WorkOutObj>();
		try{
			SimpleJdbcCall call = new SimpleJdbcCall(jdbcTemplate)
			.withCatalogName("PKG_WORKOUT")
			.withProcedureName("SP_SEARCH_WORKOUT")
			.returningResultSet("P_CURSOR", new BeanPropertyRowMapper(WorkOutObj.class));

			result = call.executeFunction(List.class,criteria.getApprover(),criteria.getCodempid(),criteria.getStart_date(),criteria.getEnd_date(),criteria.getCompany_id());
		
		} catch (Exception ex) {
			logger.error(ex.getMessage(),ex);
			//ex.printStackTrace();
		}
		return result;
	}
	
	
	
	public ResultObj UpdateWorkOutEdit(WorkOutCriteriaObj criteria) {
		ResultObj result = new ResultObj();
		try{
			SimpleJdbcCall call = new SimpleJdbcCall(jdbcTemplate)
			.withCatalogName("PKG_WORKOUT")
			.withProcedureName("SP_UPDATE_WORKOUT_EDIT");
			SqlParameterSource in = new MapSqlParameterSource()
			//.addValue("P_EMP_ID", criteria.getCodempid())
	      //  .addValue("P_RUNNO_OA_REF",criteria.getRunno_oa_ref())
	       //.addValue("P_COMPANY_ID",criteria.getCompany_id())
	    //  .addValue("P_PSKILO",workout.getKilo_flag())
	    //  .addValue("P_PSALLOW",workout.getAllow_flag())
	      //  .addValue("P_OBJECTIVE", criteria.getObjective())
	       // .addValue("P_PLACEFG", criteria.getPlacefg())
	       // .addValue("P_PLACE", criteria.getPlace())
	       // .addValue("P_PRIVCAR", criteria.getPrivcar())
	       // .addValue("P_GOBEGIN", criteria.getGobegin())
	       // .addValue("P_GODATETIME", criteria.getGodatetime())
	        //.addValue("P_RETBEGIN", criteria.getRetbegin())
	        //.addValue("P_RETDATETIME", criteria.getRetdatetime())
	        .addValue("P_UPDATE_USER", criteria.getUpdate_user()); 
			Map<String,Object> out = call.execute(in);
			result.success = ((BigDecimal)out.get("P_STATUS")).intValue();
			result.message =(String)out.get("P_MESSAGE");
		
			
			
		} catch (Exception ex) {
			result.setSuccess(0);
			result.setMessage(ex.getMessage());
			logger.error(ex.getMessage(),ex);
			//ex.printStackTrace();
		}
		return result;
	}
	
	public ResultObj CancelWorkOutRequest(WorkOutCriteriaObj criteria) {
		ResultObj result = new ResultObj();
		try{
			SimpleJdbcCall call = new SimpleJdbcCall(jdbcTemplate)
			.withCatalogName("PKG_WORKOUT")
			.withProcedureName("SP_CANCEL_BEFORE_APPROVE");
			SqlParameterSource in = new MapSqlParameterSource()
			.addValue("P_EMP_ID", criteria.getCodempid());
	      //  .addValue("P_RUNNO_OA_REF",criteria.getRunno_oa_ref()); 
			Map<String,Object> out = call.execute(in);
			result.success = ((BigDecimal)out.get("P_STATUS")).intValue();
			result.message =(String)out.get("P_MESSAGE");
			result.doc_no = (String)out.get("P_CANCL_NO");
			result.cancel_user = (String)out.get("P_USER_CNO");
		
			
			
		} catch (Exception ex) {
			result.setSuccess(0);
			result.setMessage(ex.getMessage());
			logger.error(ex.getMessage(),ex);
			//ex.printStackTrace();
		}
		return result;
	}
	
	public ResultObj UpdateWorkOut(WorkOutCriteriaObj criteria) {
		ResultObj result = new ResultObj();
		try{
			SimpleJdbcCall call = new SimpleJdbcCall(jdbcTemplate)
			.withCatalogName("PKG_WORKOUT")
			.withProcedureName("SP_UPDATE_WORKOUT");
			SqlParameterSource in = new MapSqlParameterSource()
	        .addValue("P_TRANS_ID", criteria.getTrans_id())
	        .addValue("P_REMARK", criteria.getRemark())
	        .addValue("P_APPROVE_STATUS", criteria.getStatus())
	        .addValue("P_UPDATE_USER", criteria.getUpdate_user()); 
			Map<String,Object> out = call.execute(in);
			result.success = ((BigDecimal)out.get("P_STATUS")).intValue();
			result.message =(String)out.get("P_MESSAGE");
			result.doc_no = (String)out.get("P_APPROVE_INTRA");
		
			
			
		} catch (Exception ex) {
			result.setSuccess(0);
			result.setMessage(ex.getMessage());
			logger.error(ex.getMessage(),ex);
			//ex.printStackTrace();
		}
		return result;
	}
	
	public List<WorkOutObj> GetWorkOutApprove(WorkOutCriteriaObj criteria) {
		List<WorkOutObj> result = new ArrayList<WorkOutObj>();
		try{
			SimpleJdbcCall call = new SimpleJdbcCall(jdbcTemplate)
			.withCatalogName("PKG_WORKOUT")
			.withProcedureName("SP_SEARCH_WORKOUT_APPROVE")
			.returningResultSet("P_CURSOR", new BeanPropertyRowMapper(WorkOutObj.class));
			result = call.executeFunction(List.class,criteria.getApprover(),criteria.getCompany_id(),criteria.getCodempid(),criteria.getStart_date(),criteria.getEnd_date(),criteria.getStatus());
		
		} catch (Exception ex) {
			logger.error(ex.getMessage(),ex);
			//ex.printStackTrace();
		}
		return result;
	}
	
	public ResultObj ValidateWorkOut(WorkOutCriteriaObj criteria) {
		ResultObj result = new ResultObj();
		try{
			SimpleJdbcCall call = new SimpleJdbcCall(jdbcTemplate)
			.withCatalogName("PKG_WORKOUT")
			.withProcedureName("SP_VALIDATE_WORKOUT");
			SqlParameterSource in = new MapSqlParameterSource()
	        .addValue("P_CASE", criteria.getSave_case())
	        .addValue("P_TRANS_ID", criteria.getTrans_id())
	        .addValue("P_EMP_ID", criteria.getCodempid())
	        .addValue("P_START_DATE", criteria.getStart_date())
	        .addValue("P_START_TIME", criteria.getStart_time())
	        .addValue("P_END_DATE", criteria.getEnd_date())
	        .addValue("P_END_TIME", criteria.getEnd_time()); 
			Map<String,Object> out = call.execute(in);
			result.success = ((BigDecimal)out.get("P_STATUS")).intValue();
			result.message =(String)out.get("P_MESSAGE");
			
		} catch (Exception ex) {
			result.setSuccess(0);
			result.setMessage(ex.getMessage());
			logger.error(ex.getMessage(),ex);
			//ex.printStackTrace();
		}
		return result;
	}
	
	public List<ApproveEmailObj> GetListApproveEmail(ApproveEmailCriteriaObj criteria) {
		List<ApproveEmailObj> result = new ArrayList<ApproveEmailObj>();
		try{
			SimpleJdbcCall call = new SimpleJdbcCall(jdbcTemplate)
			.withCatalogName("PKG_NOTIFICATION")
			.withProcedureName("SP_SEARCH_APPROVE")
			.returningResultSet("P_CURSOR", new BeanPropertyRowMapper(ApproveEmailObj.class));

			result = call.executeFunction(List.class,criteria.getEmail_case());
		
		} catch (Exception ex) {
			logger.error(ex.getMessage(),ex);
			//ex.printStackTrace();
		}
		return result;
	}
	public ResultObj UpdateApproveMail(ApproveEmailCriteriaObj criteria) {
		ResultObj result = new ResultObj();
		try{
			SimpleJdbcCall call = new SimpleJdbcCall(jdbcTemplate)
			.withCatalogName("PKG_NOTIFICATION")
			.withProcedureName("SP_UPDATE_APPROVE");
			SqlParameterSource in = new MapSqlParameterSource()
	        .addValue("P_CASE", criteria.getEmail_case())
	        .addValue("P_TRANS_ID", criteria.getTrans_id())
	         .addValue("P_EVENT_ID", criteria.getEvent_id())
	        ; 
			Map<String,Object> out = call.execute(in);
			result.success = ((BigDecimal)out.get("P_STATUS")).intValue();
			result.message =(String)out.get("P_MESSAGE");
		
		} catch (Exception ex) {
			result.setSuccess(0);
			result.setMessage(ex.getMessage());
			logger.error(ex.getMessage(),ex);
			//ex.printStackTrace();
		}
		return result;
	}
	
	public List<ShiftTimeObj> GetShiftTime(ShiftTimeCriteriaObj criteria) {
		List<ShiftTimeObj> result = new ArrayList<ShiftTimeObj>();
		try{
			SimpleJdbcCall call = new SimpleJdbcCall(jdbcTemplate)
			.withCatalogName("PKG_SHIFTTIME")
			.withProcedureName("SP_SEARCH_SHIFTTIME")
			.returningResultSet("P_CURSOR", new BeanPropertyRowMapper(ShiftTimeObj.class));

			result = call.executeFunction(List.class,criteria.getApprover(),criteria.getCodempid(),criteria.getStart_date(),criteria.getEnd_date(),criteria.getCompany_id());
		} catch (Exception ex) {
			logger.error(ex.getMessage(),ex);
			//ex.printStackTrace();
		}
		return result;
	}
	
	public List<ShiftTimeDropdownObj> GetShiftTimeList(ShiftTimeCriteriaObj criteria) {
		List<ShiftTimeDropdownObj> result = new ArrayList<ShiftTimeDropdownObj>();
		try{
			SimpleJdbcCall call = new SimpleJdbcCall(jdbcTemplate)
			.withCatalogName("PKG_SHIFTTIME")
			.withProcedureName("SP_GETSHIFTTIME_ALL")
			.returningResultSet("P_CURSOR", new BeanPropertyRowMapper(ShiftTimeObj.class));

			result = call.executeFunction(List.class,criteria.getApprover(),criteria.getCodempid(),criteria.getStart_date(),criteria.getEnd_date(),criteria.getCompany_id());
		} catch (Exception ex) {
			logger.error(ex.getMessage(),ex);
			//ex.printStackTrace();
		}
		return result;
	}  
	
	public ResultObj UpdateEditShifttime(List<ShiftTimeCriteriaObj> criteria) {
		ResultObj result = new ResultObj();
		try{
			for(int i=0; i<criteria.size(); i++) {
//			System.out.println("codempid : "+ criteria.get(i).getCodempid());
//			System.out.println("dtework : "+ criteria.get(i).getDtework());
//			System.out.println("dtestrtw : "+ criteria.get(i).getDtestrtw_old()+" -> "+ criteria.get(i).getDtestrtw());
//			System.out.println("timstrtw : " + criteria.get(i).getTimstrtw_old()+" -> "+ criteria.get(i).getTimstrtw());
//			System.out.println("dteendw : " + criteria.get(i).getDteendw_old()+" -> "+ criteria.get(i).getDteendw());
//			System.out.println("timendw : " + criteria.get(i).getTimendw_old()+" -> "+ criteria.get(i).getTimendw());
//			System.out.println("codshift : "+ criteria.get(i).getCodshift_old()+ " -> "+ criteria.get(i).getCodshift());
//			System.out.println("typework : "+ criteria.get(i).getTypework_old()+" -> "+ criteria.get(i).getTypework());
//			System.out.println("remark : "+ criteria.get(i).getRemark());
			
			SimpleJdbcCall call = new SimpleJdbcCall(jdbcTemplate)
			.withCatalogName("PKG_SHIFTTIME")
			.withProcedureName("SP_UPDATE_EDITSHIFTTIME");
			SqlParameterSource in = new MapSqlParameterSource()
	        .addValue("P_HEADER", criteria.get(i).getApprover())
	        .addValue("P_EMP_ID", criteria.get(i).getCodempid())
	        .addValue("P_TYPWORK", criteria.get(i).getTypework())
	        .addValue("P_TYPWORK_OLD", criteria.get(i).getTypework_old())
	        .addValue("P_CODSHIFT", criteria.get(i).getCodshift())
	        .addValue("P_CODSHIFT_OLD", criteria.get(i).getCodshift_old())
	        .addValue("P_DTEWORK", criteria.get(i).getDtework())
			.addValue("P_DTESTRTW", criteria.get(i).getDtestrtw())
			.addValue("P_DTESTRTW_OLD", criteria.get(i).getDtestrtw_old())
			.addValue("P_DTEENDW", criteria.get(i).getDteendw())
			.addValue("P_DTEENDW_OLD", criteria.get(i).getDteendw_old())
	        .addValue("P_TIMSTRTW", criteria.get(i).getTimstrtw())
	        .addValue("P_TIMSTRTW_OLD", criteria.get(i).getTimstrtw_old())
	        .addValue("P_TIMENDW", criteria.get(i).getTimendw())
	        .addValue("P_TIMENDW_OLD", criteria.get(i).getTimendw_old())
	        .addValue("P_REMARK", criteria.get(i).getRemark())
	        ; 
			Map<String,Object> out = call.execute(in);
			result.success = ((BigDecimal)out.get("P_STATUS")).intValue();
			result.message =(String)out.get("P_MESSAGE");
			}
		
		} catch (Exception ex) {
			result.setSuccess(0);
			result.setMessage(ex.getMessage());
			logger.error(ex.getMessage(),ex);
			//ex.printStackTrace();
		}
		return result;
	}
}
