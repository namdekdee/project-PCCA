package th.co.pt.pcca.pccaservice.dao.admin;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import org.springframework.stereotype.Repository;

import th.co.pt.pcca.pccaservice.entities.admin.SetUpManageAdmin;
import th.co.pt.pcca.pccaservice.entities.report.R01_ReportObj;
import th.co.pt.pcca.pccaservice.entities.util.DropDownObj;

@Repository("ManageAdminDao")
public class ManageAdminDaoImp implements ManageAdminDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	private  final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	public List<SetUpManageAdmin> getDataAdmin(){
		List<SetUpManageAdmin> result = new ArrayList<SetUpManageAdmin>();
		try{
			
			SimpleJdbcCall call = new SimpleJdbcCall(jdbcTemplate)
			.withCatalogName("PKG_SET_ADMIN")
			.withProcedureName("SP_GET_ADMIN")
			.returningResultSet("P_CURSOR", new BeanPropertyRowMapper(SetUpManageAdmin.class)); 

			result = call.executeFunction(List.class);
			
		} catch (Exception ex) {
			logger.error(ex.getMessage(),ex);
		}
		return result;
	}
}
