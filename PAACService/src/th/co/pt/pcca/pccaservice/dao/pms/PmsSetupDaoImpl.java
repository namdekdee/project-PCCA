package th.co.pt.pcca.pccaservice.dao.pms;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.apache.tomcat.jni.Time;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import th.co.pt.pcca.pccaservice.entities.util.ResultObj;

@Repository("pmsSetupDao")
public class PmsSetupDaoImpl implements PmsSetupDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	private  final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	public List<Map<String, Object>> findEstimateTypeByUserId(String userId) {
		List<Map<String, Object>> result = new ArrayList<>();
		StringBuilder sql = new StringBuilder();
		sql.append("SELECT pft.userid, ");
		sql.append("psy.evlform_type, ");
		sql.append("psy.status, ");
		sql.append("psy.year, ");	
		sql.append("psy.no_period, ");
		sql.append("pft.evl_form_desc, ");
		sql.append("to_char(psy.lastupdate,'dd/mm/yyyy', 'NLS_CALENDAR=''Thai Buddha'' NLS_DATE_LANGUAGE=THAI') as lastupdate, ");
		sql.append("to_char(psy.setkpi_dstr,'dd/mm/yyyy', 'NLS_CALENDAR=''Thai Buddha'' NLS_DATE_LANGUAGE=THAI') as setkpi_dstr, ");
		sql.append("to_char(psy.setkpi_dend,'dd/mm/yyyy', 'NLS_CALENDAR=''Thai Buddha'' NLS_DATE_LANGUAGE=THAI') as setkpi_dend, ");
		sql.append("nvl(to_char(psy.close_date,'dd/mm/yyyy'),'-') as close_date ");
		sql.append("FROM pms_form_type pft ");
		sql.append("JOIN pms_setup_year psy on psy.evlform_type = pft.evlform_type ");
		sql.append("WHERE pft.userid = '"+ userId +"' ");
		sql.append("ORDER BY psy.year ");
		
		result = jdbcTemplate.queryForList(sql.toString());
		
		return result;
	}

	@Override
	public List<Map<String, Object>> findPeriodDetail(String userId, String year) {
		List<Map<String, Object>> result = new ArrayList<>();
		StringBuilder sql = new StringBuilder();
		sql.append("SELECT psp.year, ");
		sql.append("psp.period, ");
		sql.append("pft.evl_form_desc, ");		
		sql.append("nvl(to_char(to_date(psp.eval_month,'MM'),'MONTH','NLS_CALENDAR=''Thai Buddha'' NLS_DATE_LANGUAGE=THAI'),'-') as eval_month, ");
		sql.append("nvl(psp.description,'-') as description, ");
		sql.append("to_char(psp.workdate_dstr,'dd/mm/yyyy', 'NLS_CALENDAR=''Thai Buddha'' NLS_DATE_LANGUAGE=THAI') as workdate_dstr, ");
		sql.append("to_char(psp.workdate_dend,'dd/mm/yyyy', 'NLS_CALENDAR=''Thai Buddha'' NLS_DATE_LANGUAGE=THAI') as workdate_dend, ");
		sql.append("to_char(psp.kpi_dstr_revise,'dd/mm/yyyy', 'NLS_CALENDAR=''Thai Buddha'' NLS_DATE_LANGUAGE=THAI') as kpi_dstr_revise, ");
		sql.append("to_char(psp.kpi_dend_revise,'dd/mm/yyyy', 'NLS_CALENDAR=''Thai Buddha'' NLS_DATE_LANGUAGE=THAI') as kpi_dend_revise, ");
		sql.append("to_char(psp.eva_dstr,'dd/mm/yyyy', 'NLS_CALENDAR=''Thai Buddha'' NLS_DATE_LANGUAGE=THAI') as eva_dstr, ");
		sql.append("to_char(psp.eva_dend,'dd/mm/yyyy', 'NLS_CALENDAR=''Thai Buddha'' NLS_DATE_LANGUAGE=THAI') as eva_dend, ");
		sql.append("psp.process_status, ");
		sql.append("psp.current_flag, ");
		sql.append("psp.userid, ");
		sql.append("to_char(psp.lastupdate,'dd/mm/yyyy', 'NLS_CALENDAR=''Thai Buddha'' NLS_DATE_LANGUAGE=THAI') as lastupdate  ");		
		sql.append("FROM pms_setup_period psp ");
		sql.append("JOIN pms_form_type pft ON psp.evlform_type = pft.evlform_type ");
		sql.append("WHERE psp.userid = '"+ userId +"' and psp.year = '"+ year +"' ");
		result = jdbcTemplate.queryForList(sql.toString());
		
		return result;
	}

	@Override
	public ResultObj insertPeriodDetail(Map<String, Object> obj) {
		ResultObj result = new ResultObj();
		try {
			String sql = "INSERT INTO pms_setup_year"
					+ " (EVLFORM_TYPE,YEAR,NO_PERIOD,SETKPI_DSTR,SETKPI_DEND,CLOSE_DATE,STATUS,USERID,LASTUPDATE)"
					+ " VALUES(?,?,?,to_date(?,?),to_date(?,?),?,?,?,to_date(?,?))";
			jdbcTemplate.update(sql, new Object[] {
				obj.get("EVL_TYPE").toString(),
				obj.get("YEAR"),
				obj.get("PERIOD"),
				obj.get("START_DATE"),"dd/mm/yyyy",
				obj.get("END_DATE"),"dd/mm/yyyy",
				null,
				obj.get("STATUS").toString(),
				obj.get("USER_ID").toString(),
				obj.get("LAST_UPDATE"),"dd/mm/yyyy HH24:MI:SS"
			});
			result.setSuccess(1);
			result.setMessage("SUCCESS");
		} catch (Exception ex) {
			result.setSuccess(0);
			result.setMessage(ex.getMessage());
			logger.error(ex.getMessage(),ex);
		}
		return result;
	}

	@Override
	public ResultObj deletePeriodDetail(List<Map<String, Object>> obj) {
		ResultObj result = new ResultObj();
		try {
			String sql = "DELETE FROM pms_setup_year"
					+ " WHERE userid = ? AND year = ?";
			for (Map<String, Object> map : obj) {
				jdbcTemplate.update(sql, new Object[] {
					map.get("USER_ID"),
					map.get("YEAR")
				});
			}
			
			result.setSuccess(1);
			result.setMessage("SUCCESS");
		} catch (Exception ex) {
			result.setSuccess(0);
			result.setMessage(ex.getMessage());
			logger.error(ex.getMessage(),ex);
		}
		return result;
	}

	@Override
	public ResultObj insertPeriodDetailInYear(Map<String, Object> obj) {
		ResultObj result = new ResultObj();
		try {
			String sql = "INSERT INTO pms_setup_period"
					+ " (EVLFORM_TYPE, YEAR, PERIOD, EVAL_MONTH, DESCRIPTION, WORKDATE_DSTR, WORKDATE_DEND,"
					+ "KPI_DSTR_REVISE, KPI_DEND_REVISE, EVA_DSTR, EVA_DEND, PROCESS_STATUS, CURRENT_FLAG, USERID, LASTUPDATE)"
					+ " VALUES(?, ?, ?, ?, ?, to_date(?,?), to_date(?,?),"
					+ "to_date(?,?), to_date(?,?), to_date(?,?), to_date(?,?), ?, ?, ?,to_date(?,?))";
			jdbcTemplate.update(sql, new Object[] {
				obj.get("EVL_TYPE").toString(),
				obj.get("YEAR"),
				obj.get("PERIOD"),
				null,
				null,
				obj.get("WORK_START"),"dd/mm/yyyy",
				obj.get("WORK_END"),"dd/mm/yyyy",
				obj.get("RESVISE_START"),"dd/mm/yyyy",
				obj.get("RESVISE_END"),"dd/mm/yyyy",
				obj.get("ROUND_START"),"dd/mm/yyyy",
				obj.get("ROUND_END"),"dd/mm/yyyy",
				obj.get("STATUS").toString(),
				obj.get("PROCESS_STATUS").toString(),
				obj.get("USER_ID").toString(),
				obj.get("LAST_UPDATE"),"dd/mm/yyyy HH24:MI:SS"
			});
			result.setSuccess(1);
			result.setMessage("SUCCESS");
		} catch (Exception ex) {
			result.setSuccess(0);
			result.setMessage(ex.getMessage());
			logger.error(ex.getMessage(),ex);
		}
		return result;
	}
	
	@Override
	public ResultObj deletePeriodDetailInYear(Map<String, Object> obj) {
		ResultObj result = new ResultObj();
		try {
			String sql = "DELETE FROM pms_setup_period"
					+ " WHERE userid = ? AND year = ? AND period = ?";
			jdbcTemplate.update(sql, new Object[] {
					obj.get("USER_ID"),
					obj.get("YEAR"),
					obj.get("PERIOD")
			});
			
			result.setSuccess(1);
			result.setMessage("SUCCESS");
		} catch (Exception ex) {
			result.setSuccess(0);
			result.setMessage(ex.getMessage());
			logger.error(ex.getMessage(),ex);
		}
		return result;
	}
	
	@Override
	public ResultObj updatePeriodDetail(Map<String, Object> obj) {
		ResultObj result = new ResultObj();
		try {
			String sql = "UPDATE pms_setup_year"
					+ " SET NO_PERIOD = ?"
					+ " ,SETKPI_DSTR = to_date(?,?), SETKPI_DEND = to_date(?,?)"
					+ " ,STATUS = ? ,USERID = ? ,LASTUPDATE = to_date(?,?)"
					+ " WHERE USERID = ? AND YEAR = ?";
			jdbcTemplate.update(sql, new Object[] {
				obj.get("PERIOD"),
				obj.get("START_DATE"),"dd/mm/yyyy",
				obj.get("END_DATE"),"dd/mm/yyyy",
				obj.get("STATUS").toString(),
				obj.get("USER_ID").toString(),
				obj.get("LAST_UPDATE"),"dd/mm/yyyy HH24:MI:SS",
				obj.get("USER_ID").toString(),
				obj.get("YEAR")
			});
			result.setSuccess(1);
			result.setMessage("SUCCESS");
		} catch (Exception ex) {
			result.setSuccess(0);
			result.setMessage(ex.getMessage());
			logger.error(ex.getMessage(),ex);
		}
		return result;
	}
	
	@Override
	public ResultObj updatePeriodDetailInYear(Map<String, Object> obj) {
		ResultObj result = new ResultObj();
		try {
			String sql = "UPDATE pms_setup_period"
					+ " SET PERIOD = ?, WORKDATE_DSTR = to_date(?,?), WORKDATE_DEND = to_date(?,?)"
					+ " ,KPI_DSTR_REVISE = to_date(?,?), KPI_DEND_REVISE = to_date(?,?)"
					+ " ,EVA_DSTR = to_date(?,?), EVA_DEND = to_date(?,?)"
					+ " ,PROCESS_STATUS = ?, CURRENT_FLAG = ?, USERID = ?, LASTUPDATE = to_date(?,?)"
					+ " WHERE USERID = ? AND PERIOD = ? AND YEAR = ?";
			jdbcTemplate.update(sql, new Object[] {
				obj.get("PERIOD"),
				obj.get("WORK_START"),"dd/mm/yyyy",
				obj.get("WORK_END"),"dd/mm/yyyy",
				obj.get("RESVISE_START"),"dd/mm/yyyy",
				obj.get("RESVISE_END"),"dd/mm/yyyy",
				obj.get("ROUND_START"),"dd/mm/yyyy",
				obj.get("ROUND_END"),"dd/mm/yyyy",
				obj.get("STATUS").toString(),
				obj.get("PROCESS_STATUS").toString(),
				obj.get("USER_ID").toString(),
				obj.get("LAST_UPDATE"),"dd/mm/yyyy HH24:MI:SS",
				obj.get("USER_ID").toString(),
				obj.get("PERIOD"),
				obj.get("YEAR")
			});
			result.setSuccess(1);
			result.setMessage("SUCCESS");
		} catch (Exception ex) {
			result.setSuccess(0);
			result.setMessage(ex.getMessage());
			logger.error(ex.getMessage(),ex);
		}
		return result;
	}

	public List<Map<String, Object>> findEstimateTypeByChangeDropDown(Map<String, Object> obj) {
		List<Map<String, Object>> result = new ArrayList<>();
		String year = obj.get("SELECTED_YEAR").toString().equals("no") ? "": " AND psy.year = "+ obj.get("SELECTED_YEAR").toString();
		String status = obj.get("SELECTED_STATUS").toString().equals("no") ? "": " AND psy.status = '"+ obj.get("SELECTED_STATUS").toString() +"'";
		String txtSql = " AND pft.evlform_type = '"+ obj.get("SELECTED_ESTIMATE").toString() +"'"+year+status;
		StringBuilder sql = new StringBuilder();
		sql.append("SELECT pft.userid, ");
		sql.append("psy.evlform_type, ");
		sql.append("psy.status, ");
		sql.append("psy.year, ");	
		sql.append("psy.no_period, ");
		sql.append("pft.evl_form_desc, ");
		sql.append("to_char(psy.lastupdate,'dd/mm/yyyy', 'NLS_CALENDAR=''Thai Buddha'' NLS_DATE_LANGUAGE=THAI') as lastupdate, ");
		sql.append("to_char(psy.setkpi_dstr,'dd/mm/yyyy', 'NLS_CALENDAR=''Thai Buddha'' NLS_DATE_LANGUAGE=THAI') as setkpi_dstr, ");
		sql.append("to_char(psy.setkpi_dend,'dd/mm/yyyy', 'NLS_CALENDAR=''Thai Buddha'' NLS_DATE_LANGUAGE=THAI') as setkpi_dend, ");
		sql.append("nvl(to_char(psy.close_date,'dd/mm/yyyy'),'-') as close_date ");
		sql.append("FROM pms_form_type pft ");
		sql.append("JOIN pms_setup_year psy on psy.evlform_type = pft.evlform_type ");
		sql.append("WHERE pft.userid = '"+ obj.get("USER_ID") +"'");
		sql.append(txtSql);
		sql.append(" ORDER BY psy.year "); 
		
		result = jdbcTemplate.queryForList(sql.toString());
		
		return result;
	}
}
