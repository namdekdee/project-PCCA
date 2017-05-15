package th.co.pt.pcca.pccaservice.dao.report;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import org.springframework.stereotype.Repository;

import th.co.pt.pcca.pccaservice.entities.report.R01_ReportObj;
import th.co.pt.pcca.pccaservice.entities.report.R02_ReportObj;
import th.co.pt.pcca.pccaservice.entities.util.DropDownCriteriaObj;

@Repository("reportDao")
public class ReportDaoImpl implements ReportDao{
	@Autowired
	private JdbcTemplate jdbcTemplate;
	private  final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	public List<R01_ReportObj> GetReportR01(DropDownCriteriaObj criteria){
		
		List<R01_ReportObj> result = new ArrayList<R01_ReportObj>();
		String sp = "";
		try{
			if("0005".equals(criteria.getGu_id())){
				sp = "SP_GET_REPORT_R01_ADMIN";
			}else if(criteria.getGu_id().equals("0021")){
				sp = "SP_GET_REPORT_R01_ADMIN";
			}else if(criteria.getNumminlvl()>9){
				sp = "SP_MD_GET_REPORT_R01";
			}
			else {
				sp = "SP_GET_REPORT_R01";
			}
			
			SimpleJdbcCall call = new SimpleJdbcCall(jdbcTemplate)
			.withCatalogName("PKG_REPORT")
			.withProcedureName(sp)
			.returningResultSet("P_CURSOR", new BeanPropertyRowMapper(R01_ReportObj.class)); 
			
			if(criteria.getComp7().length()==21){
				criteria.setCompany(criteria.getComp7());
			}else if(criteria.getComp6().length()==21){
				criteria.setCompany(criteria.getComp6().substring(0,18));
			}else if(criteria.getComp5().length()==21){
				criteria.setCompany(criteria.getComp5().substring(0,15));
			}else if(criteria.getComp4().length()==21){
				criteria.setCompany(criteria.getComp4().substring(0,12));
			}
			
//			System.out.println("criteria: " + criteria);
			if(criteria.getNumminlvl()>9){
				result = call.executeFunction(List.class,criteria.getHead_emp_id(),criteria.getEmp_id(),criteria.getStartDate(),criteria.getEndDate(),criteria.getCompany());
			}else{
				result = call.executeFunction(List.class,criteria.getHead_emp_id(),criteria.getEmp_id(),criteria.getStartDate(),criteria.getEndDate(),criteria.getComp1(),criteria.getComp4(),criteria.getComp5(), criteria.getComp6(), criteria.getComp7());
			}
			
		} catch (Exception ex) {
			logger.error(ex.getMessage(),ex);
		}
		return result;
	}
	
	
	public List<R02_ReportObj> GetReportR02(DropDownCriteriaObj criteria){
		List<R02_ReportObj> result = new ArrayList<R02_ReportObj>();
		String sp = "";
		try{
			if("0005".equals(criteria.getGu_id())){
				sp = "SP_GET_REPORT_R02_ADMIN";
			}else if(criteria.getGu_id().equals("0021")){
				sp = "SP_GET_REPORT_R02_ADMIN";
			}else if(criteria.getNumminlvl()>9){
				sp = "SP_MD_GET_REPORT_R02";
			}else {
				sp = "SP_GET_REPORT_R02";
			}
			SimpleJdbcCall call = new SimpleJdbcCall(jdbcTemplate)
			.withCatalogName("PKG_REPORT")
			.withProcedureName(sp)
			.returningResultSet("P_CURSOR", new BeanPropertyRowMapper(R02_ReportObj.class)); 
			
			if(criteria.getComp7().length()==21){
				criteria.setCompany(criteria.getComp7());
			}else if(criteria.getComp6().length()==21){
				criteria.setCompany(criteria.getComp6().substring(0,18));
			}else if(criteria.getComp5().length()==21){
				criteria.setCompany(criteria.getComp5().substring(0,15));
			}else if(criteria.getComp4().length()==21){
				criteria.setCompany(criteria.getComp4().substring(0,12));
			}
			
//			System.out.println("criteria: " + criteria);
			if(criteria.getNumminlvl()>9){
				result = call.executeFunction(List.class,criteria.getHead_emp_id(),criteria.getEmp_id(),criteria.getStartDate(),criteria.getEndDate(),criteria.getCompany());
			}else{
				result = call.executeFunction(List.class,criteria.getHead_emp_id(),criteria.getEmp_id(),criteria.getStartDate(),criteria.getEndDate(),criteria.getComp1(),criteria.getComp4(),criteria.getComp5(), criteria.getComp6(), criteria.getComp7());
			}
			
		} catch (Exception ex) {
			logger.error(ex.getMessage(),ex);
		}
		return result;
	}

}
