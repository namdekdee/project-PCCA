package th.co.pt.pcca.pccaservice.dao.admin;

import java.math.BigDecimal;
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

import th.co.pt.pcca.pccaservice.entities.admin.SetupUnlockRequestObject;
import th.co.pt.pcca.pccaservice.entities.util.ResultObj;

@Repository("AdminUnlockReqDAO")
public class AdminUnlockReqDAOImpl implements AdminUnlockReqDAO{
	@Autowired
	private JdbcTemplate jdbcTemplate;
	private  final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Override
	public List<SetupUnlockRequestObject> listSetupUnlockReq(SetupUnlockRequestObject criteria) throws Exception {
		List<SetupUnlockRequestObject> result = null;
		try{
			SimpleJdbcCall call = new SimpleJdbcCall(jdbcTemplate)
			.withCatalogName("PKG_ADMIN_UNLOCK_REQUEST")
			.withProcedureName("SP_SEARCH_UNLOCK_REQUEST")
			.returningResultSet("P_CURSOR", new BeanPropertyRowMapper(SetupUnlockRequestObject.class));
			result = call.executeFunction(List.class);
		
		} catch (Exception ex) {
			logger.error(ex.getMessage(),ex);			
		}
		return result;
	}

	@Override
	public ResultObj addSetupUnlockReq(SetupUnlockRequestObject criteria) throws Exception {
		ResultObj result = new ResultObj();
		try{
			SimpleJdbcCall call = new SimpleJdbcCall(jdbcTemplate)
			.withCatalogName("PKG_ADMIN_UNLOCK_REQUEST")
			.withProcedureName("SP_SAVE_UNLOCK_REQUEST");
			SqlParameterSource in = new MapSqlParameterSource()
			.addValue("P_TRANS_UNLOCK_ID", criteria.getUnlockId())
			.addValue("P_EMP_ID", criteria.getCodeEmp())	
			.addValue("P_MENU_ID", criteria.getMenuId())
	        .addValue("P_WF_ID", criteria.getWfID())	        
			.addValue("P_ACTION", criteria.getAction())				
			.addValue("P_FLG_UNLOCK", criteria.getFlgUnl())
			.addValue("P_UPDATE_BY", criteria.getUpdate_by());
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
	public ResultObj deleteSetupReq(List<SetupUnlockRequestObject> criteria) throws Exception {
		ResultObj result = new ResultObj();
		try{
			if(criteria!=null&& criteria.size()>0){
				criteria.forEach(a -> {
					SimpleJdbcCall call = new SimpleJdbcCall(jdbcTemplate)
					.withCatalogName("PKG_ADMIN_UNLOCK_REQUEST")
					.withProcedureName("SP_DELETE_UNLOCK_REQUEST");
					SqlParameterSource in = new MapSqlParameterSource()
					.addValue("P_TRANS_UNLOCK_ID", a.getUnlockId());
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
	public SetupUnlockRequestObject findSetupUnlockReq(SetupUnlockRequestObject criteria) throws Exception {
		SetupUnlockRequestObject result = null;
		try{
			List<SetupUnlockRequestObject> list = null;
			SimpleJdbcCall call = new SimpleJdbcCall(jdbcTemplate)
			.withCatalogName("PKG_ADMIN_UNLOCK_REQUEST")
			.withProcedureName("SP_GET_UNLOCK_REQUEST")
			.returningResultSet("P_CURSOR", new BeanPropertyRowMapper(SetupUnlockRequestObject.class));
			list = call.executeFunction(List.class,criteria.unlockId);
			result = list.get(0);
		} catch (Exception ex) {
			logger.error(ex.getMessage(),ex);			
		}
		return result;
	}

}
