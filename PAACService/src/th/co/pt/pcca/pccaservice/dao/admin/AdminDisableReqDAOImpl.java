package th.co.pt.pcca.pccaservice.dao.admin;

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

import th.co.pt.pcca.pccaservice.entities.admin.SetUpRequestCriteriaObject;
import th.co.pt.pcca.pccaservice.entities.admin.SetupRequestObject;
import th.co.pt.pcca.pccaservice.entities.util.ResultObj;

@Repository("AdminDisableReqDAO")
public class AdminDisableReqDAOImpl implements AdminDisableReqDAO{

	@Autowired
	private JdbcTemplate jdbcTemplate;
	private  final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Override
	public List<SetupRequestObject> listSetupReq(SetupRequestObject criteria) throws Exception {
		List<SetupRequestObject> result = null;
		try{
			SimpleJdbcCall call = new SimpleJdbcCall(jdbcTemplate)
			.withCatalogName("PKG_ADMIN_DISABLED_REQUEST")
			.withProcedureName("SP_SEARCH_REQUEST")
			.returningResultSet("P_CURSOR", new BeanPropertyRowMapper(SetupRequestObject.class));
			result = call.executeFunction(List.class);
		
		} catch (Exception ex) {
			logger.error(ex.getMessage(),ex);			
		}
		return result;
	}

	@Override
	public ResultObj addSetupReq(SetupRequestObject criteria) throws Exception {
		ResultObj result = new ResultObj();
		try{
			SimpleJdbcCall call = new SimpleJdbcCall(jdbcTemplate)
			.withCatalogName("PKG_ADMIN_DISABLED_REQUEST")
			.withProcedureName("SP_SAVE_DISABLED_REQUEST");
			SqlParameterSource in = new MapSqlParameterSource()
			.addValue("P_MENU_ID", criteria.getMenuId())
			.addValue("P_EMP_ID", criteria.getUpdate_by())	        
	        .addValue("P_WF_ID", criteria.getWfID())
	        .addValue("P_PREV_DAY", criteria.getPrevDay()) 
			.addValue("P_ACTION", criteria.getAction())	
			.addValue("P_REQT_START", criteria.getReqtStart())
			.addValue("P_REQT_END", criteria.getReqtEnd())
			.addValue("P_FLG_REQT", criteria.getFlgReqt());
			Map<String,Object> out = call.execute(in);
			result.success = ((BigDecimal)out.get("P_STATUS")).intValue();
			result.message =(String)out.get("P_MESSAGE");
		
		} catch (Exception ex) {
			result.setSuccess(0);
			result.setMessage(ex.getMessage());
			logger.error(ex.getMessage(),ex);			
		}
		return result;
	}

	@Override
	public ResultObj deleteSetupReq(List<SetupRequestObject> criteria) throws Exception {
		ResultObj result = new ResultObj();
		try{
			if(criteria!=null&& criteria.size()>0){
				criteria.forEach(a -> {
					SimpleJdbcCall call = new SimpleJdbcCall(jdbcTemplate)
					.withCatalogName("PKG_ADMIN_DISABLED_REQUEST")
					.withProcedureName("SP_DELETE_DISABLED_REQUEST");
					SqlParameterSource in = new MapSqlParameterSource()
					.addValue("P_MENU_ID", a.getMenuId())
					.addValue("P_WF_ID", a.getWfID());
					Map<String,Object> out = call.execute(in);
					result.success = ((BigDecimal)out.get("P_STATUS")).intValue();
					result.message =(String)out.get("P_MESSAGE");					
				});
			}
		}catch (Exception ex) {
			result.setSuccess(0);
			result.setMessage(ex.getMessage());
			logger.error(ex.getMessage(),ex);			
		}
		return result;
	}

	@Override
	public SetupRequestObject findSetupReq(SetupRequestObject criteria) throws Exception {
		SetupRequestObject result = null;
		try{
			List<SetupRequestObject> list = new ArrayList<SetupRequestObject>();
			SimpleJdbcCall call = new SimpleJdbcCall(jdbcTemplate)
			.withCatalogName("PKG_ADMIN_DISABLED_REQUEST")
			.withProcedureName("SP_GET_REQUEST")
			.returningResultSet("P_CURSOR", new BeanPropertyRowMapper(SetupRequestObject.class));
			list = call.executeFunction(List.class,criteria.getMenuId(),criteria.getWfID());
			if(list.size()>0)result = list.get(0);
			} catch (Exception ex) {
			logger.error(ex.getMessage(),ex);			
		}
		return result;
	}

	@Override
	public ResultObj checkSetupReq(SetUpRequestCriteriaObject criteria) throws Exception {
		ResultObj result = new ResultObj();
		try{
			SimpleJdbcCall call = new SimpleJdbcCall(jdbcTemplate)
			.withCatalogName("PKG_ADMIN_DISABLED_REQUEST")
			.withProcedureName("SP_CHECK_REQUEST");
			SqlParameterSource in = new MapSqlParameterSource()
			.addValue("P_CODEMPID", criteria.getClass())
			.addValue("P_MENU_ID", criteria.getMenu_ID())	        
	        .addValue("P_WF_ID", criteria.getWfID())
	        .addValue("P_ACTION", criteria.getAction()) 
			.addValue("P_DATE", criteria.getDate())	;			
			Map<String,Object> out = call.execute(in);
			result.success = ((BigDecimal)out.get("P_STATUS")).intValue();
			result.message =(String)out.get("P_MESSAGE");
		
		} catch (Exception ex) {
			result.setSuccess(0);
			result.setMessage(ex.getMessage());
			logger.error(ex.getMessage(),ex);			
		}
		return result;
	}

}
