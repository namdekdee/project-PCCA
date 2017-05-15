package th.co.pt.pcca.pccaservice.dao.util;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.mortbay.log.Log;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import org.springframework.stereotype.Repository;

import th.co.pt.pcca.pccaservice.entities.account.MainMenuObj;
import th.co.pt.pcca.pccaservice.entities.member.MemberObj;
import th.co.pt.pcca.pccaservice.entities.util.DropDownCriteriaObj;
import th.co.pt.pcca.pccaservice.entities.util.DropDownObj;
import th.co.pt.pcca.pccaservice.entities.workflow.StepWorkFlowCriteriaObj;
import th.co.pt.pcca.pccaservice.entities.workflow.StepWorkFlowTransactionObj;
import th.co.pt.pcca.pccaservice.helper.*;

@Repository("utilDao")
public class UtilDaoImpl implements UtilDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	private  final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	public List<DropDownObj> GetMemberFollower(DropDownCriteriaObj criteria) {
		List<DropDownObj> result = new ArrayList<DropDownObj>();
		String sp="SP_GET_MEMBER_FOLLOWER_COMP";
	
		try{
			if(criteria.getGu_id().equals("0021")){
				sp = "SP_GET_MEMBER_FOLLOWER_BRANCH";
			}
			else {
				sp = "SP_GET_MEMBER_FOLLOWER_COMP";
			}
			
			SimpleJdbcCall call = new SimpleJdbcCall(jdbcTemplate)
			.withCatalogName("PKG_SERVICE_UTIL")
			.withProcedureName(sp)
			.returningResultSet("P_CURSOR", new BeanPropertyRowMapper(DropDownObj.class));

			result = call.executeFunction(List.class,criteria.getEmp_id(),criteria.getCompany());
		
			
		} catch (Exception ex) {
			logger.error(ex.getMessage(),ex);
			//ex.printStackTrace();
		}
		return result;
	}
	public List<DropDownObj> GetWorkTimeDocType(DropDownCriteriaObj criteria) {
		List<DropDownObj> result = new ArrayList<DropDownObj>();
		try{
			SimpleJdbcCall call = new SimpleJdbcCall(jdbcTemplate)
			.withCatalogName("PKG_SERVICE_UTIL")
			.withProcedureName("SP_GET_WORKTIME_DOCTYPE_BYUESR")
			.returningResultSet("P_CURSOR", new BeanPropertyRowMapper(DropDownObj.class));

			result = call.executeFunction(List.class,criteria.getEmp_id());
		
			
		} catch (Exception ex) {
			logger.error(ex.getMessage(),ex);
			//ex.printStackTrace();
		}
		return result;
	}
	public List<DropDownObj> GetWorkTimeTimeCause() {
		List<DropDownObj> result = new ArrayList<DropDownObj>();
		try{
			SimpleJdbcCall call = new SimpleJdbcCall(jdbcTemplate)
			.withCatalogName("PKG_SERVICE_UTIL")
			.withProcedureName("SP_GET_WORKTIME_TIMECAUSE")
			.returningResultSet("P_CURSOR", new BeanPropertyRowMapper(DropDownObj.class));

			result = call.executeFunction(List.class);
		
			
		} catch (Exception ex) {
			logger.error(ex.getMessage(),ex);
			//ex.printStackTrace();
		}
		return result;
	}
	public List<DropDownObj> GetCompany(DropDownCriteriaObj criteria) {
		List<DropDownObj> result = new ArrayList<DropDownObj>();
		String sp = "SP_GET_COMPANY";
		try{
			if(criteria.getGu_id().equals("0021")){
				sp = "SP_GET_COMPANY_ADMIN_BRANCH";
			}
			else {
				sp = "SP_GET_COMPANY";
			}
			
			SimpleJdbcCall call = new SimpleJdbcCall(jdbcTemplate)
			.withCatalogName("PKG_SERVICE_UTIL")
			.withProcedureName(sp)
			.returningResultSet("P_CURSOR", new BeanPropertyRowMapper(DropDownObj.class));

			result = call.executeFunction(List.class,criteria.getEmp_id());
		
			
		} catch (Exception ex) {
			logger.error(ex.getMessage(),ex);
			//ex.printStackTrace();
		}
		return result;
	}
	public List<DropDownObj> GetDocumentStatus( ) {
		List<DropDownObj> result = new ArrayList<DropDownObj>();
		try{
			SimpleJdbcCall call = new SimpleJdbcCall(jdbcTemplate)
			.withCatalogName("PKG_SERVICE_UTIL")
			.withProcedureName("SP_DOCUMENT_STATUS_APPROVE")
			.returningResultSet("P_CURSOR", new BeanPropertyRowMapper(DropDownObj.class));

			result = call.executeFunction(List.class);
		
			
		} catch (Exception ex) {
			logger.error(ex.getMessage(),ex);
			//ex.printStackTrace();
		}
		return result;
	}

	/* For Report R01 */
	public List<DropDownObj> findCompany(DropDownCriteriaObj criteria){
		List<DropDownObj> result = new ArrayList<DropDownObj>();
		String sp = "";
		try{
			if(criteria.getGu_id().equals("0005")){
				sp = "SP_GET_ALL_COMPANY";
			}else if(criteria.getGu_id().equals("0021")){
				sp = "SP_ADMIN_GET_COMPANY1";
			}else if(criteria.getNumminlvl()>9){
				sp = "SP_MD_GET_COMPANY1";
			}else {
				sp = "SP_REPORT_GET_COMPANY";
			}
			
			SimpleJdbcCall call = new SimpleJdbcCall(jdbcTemplate)
			.withCatalogName("PKG_SERVICE_UTIL")
			.withProcedureName(sp)
			.returningResultSet("P_CURSOR", new BeanPropertyRowMapper(DropDownObj.class));
//			System.out.println(sp);
			if(criteria.getGu_id().equals("0005")){
				result = call.executeFunction(List.class);
			}else{
				result = call.executeFunction(List.class,criteria.getEmp_id());
			}
	
		} catch (Exception ex) {
			logger.error(ex.getMessage(),ex);
			//ex.printStackTrace();
		}
		return result;
	}
	
	public List<DropDownObj> findParty(DropDownCriteriaObj criteria){
		List<DropDownObj> result = new ArrayList<DropDownObj>();
		String sp = "" ;
		try {
			logger.info("numlvl >> "+criteria.getNumminlvl());
			if(criteria.getGu_id().equals("0005")){ 
				sp = "SP_GET_ALL_COMPANY4";
			}else if(criteria.getGu_id().equals("0021")){
				sp = "SP_ADMIN_GET_COMPANY4";
			}else if(criteria.getNumminlvl()>9){
				sp = "SP_MD_GET_COMPANY4";
			}else{
				sp = "SP_REPORT_GET_COMPANY4";
			}
			
			SimpleJdbcCall call = new SimpleJdbcCall(jdbcTemplate)
			.withCatalogName("PKG_SERVICE_UTIL")
			.withProcedureName(sp)
			.returningResultSet("P_CURSOR", new BeanPropertyRowMapper(DropDownObj.class));
//			System.out.println(sp);
			if(criteria.getGu_id().equals("0005")){
				result = call.executeFunction(List.class,criteria.getComp1());
			}else if(criteria.getGu_id().equals("0021")){
				result = call.executeFunction(List.class,criteria.getEmp_id(),criteria.getComp1());
			}else if(criteria.getNumminlvl()>9){
				result = call.executeFunction(List.class,criteria.getEmp_id(),criteria.getCompany());
			}else {
				result = call.executeFunction(List.class,criteria.getEmp_id(),criteria.getComp1());
			}
//			logger.info("SP >> "+sp);
//			logger.info("emp_id >> "+criteria.getEmp_id()+"  company >> "+criteria.getCompany());
		}catch (Exception e) {
			logger.error(e.getMessage(),e);
		}
//		System.out.println("result comp4 >> "+result.size());
		return result;
	}
	
	public List<DropDownObj> findSection(DropDownCriteriaObj criteria){
		List<DropDownObj> result = new ArrayList<DropDownObj>();
		String sp = "" ;
		try {
			if(criteria.getGu_id().equals("0005")){
				sp = "SP_GET_ALL_COMPANY5";
			}else if(criteria.getGu_id().equals("0021")){
				sp = "SP_ADMIN_GET_COMPANY5";
			}else if(criteria.getNumminlvl()>9){
				sp = "SP_MD_GET_COMPANY5";
			}else {
				sp = "SP_REPORT_GET_COMPANY5";
			}
			SimpleJdbcCall call = new SimpleJdbcCall(jdbcTemplate)
			.withCatalogName("PKG_SERVICE_UTIL")
			.withProcedureName(sp)
			.returningResultSet("P_CURSOR", new BeanPropertyRowMapper(DropDownObj.class));
			
			if(criteria.getGu_id().equals("0005")){
				result = call.executeFunction(List.class,criteria.getComp1(),criteria.getComp4());
			}else if(criteria.getGu_id().equals("0021")){
				result = call.executeFunction(List.class,criteria.getEmp_id(),criteria.getComp4());
			}else if(criteria.getNumminlvl()>9){
				result = call.executeFunction(List.class,criteria.getEmp_id(),criteria.getCompany(),criteria.getNumminlvl());
			}else{
				result = call.executeFunction(List.class,criteria.getEmp_id(),criteria.getComp1(),criteria.getComp4());
			}
			
		}catch (Exception e) {
			logger.error(e.getMessage(),e);
		}
		
		return result;
	}
	
	
	
	public List<DropDownObj> findDepartment(DropDownCriteriaObj criteria){
		List<DropDownObj> result = new ArrayList<DropDownObj>();
		String sp = "" ;
		try {
			if(criteria.getGu_id().equals("0005")){ 
				sp = "SP_GET_ALL_COMPANY6";
			}else if(criteria.getGu_id().equals("0021")){
				sp = "SP_ADMIN_GET_COMPANY6";
			}else if(criteria.getNumminlvl()>9){
				sp = "SP_MD_GET_COMPANY6";
			}else{
				sp = "SP_REPORT_GET_COMPANY6";
			}
			SimpleJdbcCall call = new SimpleJdbcCall(jdbcTemplate)
			.withCatalogName("PKG_SERVICE_UTIL")
			.withProcedureName(sp)
			.returningResultSet("P_CURSOR", new BeanPropertyRowMapper(DropDownObj.class));
			
			if(criteria.getGu_id().equals("0005")){
				result = call.executeFunction(List.class,criteria.getComp1(),criteria.getComp4(),criteria.getComp5());
			}else if(criteria.getGu_id().equals("0021")){
				result = call.executeFunction(List.class,criteria.getEmp_id(),criteria.getComp5());
			}else if(criteria.getNumminlvl()>9){
				result = call.executeFunction(List.class,criteria.getEmp_id(),criteria.getCompany(),criteria.getNumminlvl());
			}else{ 
				result = call.executeFunction(List.class,criteria.getEmp_id(),criteria.getComp1(),criteria.getComp4(),criteria.getComp5());
			}
			
		}catch (Exception e) {
			logger.error(e.getMessage(),e);
		}
		return result;
	}
	
	public List<DropDownObj> findBranch(DropDownCriteriaObj criteria){
		List<DropDownObj> result = new ArrayList<DropDownObj>();
		String sp = "";
		try {
			if(criteria.getGu_id().equals("0005")){ 
				sp = "SP_GET_ALL_COMPANY7";
			}else if(criteria.getGu_id().equals("0021")){
				sp = "SP_ADMIN_GET_COMPANY7";
			}else if(criteria.getNumminlvl()>9){
				sp = "SP_MD_GET_COMPANY7";
			}else{ 
				sp = "SP_REPORT_GET_COMPANY7";
			}
			
			SimpleJdbcCall call = new SimpleJdbcCall(jdbcTemplate)
			.withCatalogName("PKG_SERVICE_UTIL")
			.withProcedureName(sp)
			.returningResultSet("P_CURSOR", new BeanPropertyRowMapper(DropDownObj.class));
			
			if(criteria.getGu_id().equals("0005")){
				result = call.executeFunction(List.class,criteria.getComp1(),criteria.getComp4(),criteria.getComp5(), criteria.getComp6());
			}else if(criteria.getGu_id().equals("0021")){
				result = call.executeFunction(List.class,criteria.getEmp_id(),criteria.getComp6());
			}else if(criteria.getNumminlvl()>9){
				result = call.executeFunction(List.class,criteria.getEmp_id(),criteria.getCompany(),criteria.getNumminlvl());
			}else{ 
				result = call.executeFunction(List.class,criteria.getEmp_id(),criteria.getComp1(),criteria.getComp4(),criteria.getComp5(),criteria.getComp6());
			}
		}catch (Exception e) {
			logger.error(e.getMessage(),e);
		}
		return result;
	}
	
	public List<DropDownObj> findEmp(DropDownCriteriaObj criteria){
		List<DropDownObj> result = new ArrayList<DropDownObj>();
		String sp = "";
		try {
			if(criteria.getGu_id().equals("0005")){ 
				sp = "SP_GET_ALL_CODEMPID";
			}else if(criteria.getGu_id().equals("0021")){
				sp = "SP_GET_ALL_CODEMPID";
			}else if(criteria.getNumminlvl()>9){
				sp = "SP_MD_GET_MEMBER_FOLLOWER";
			}else{ 
				sp = "SP_GET_MEMBER_FOLLOWER_COMP2";
			}
			
			SimpleJdbcCall call = new SimpleJdbcCall(jdbcTemplate)
			.withCatalogName("PKG_SERVICE_UTIL")
			.withProcedureName(sp)
			.returningResultSet("P_CURSOR", new BeanPropertyRowMapper(DropDownObj.class));
			
			
			if("0005".equals(criteria.getGu_id())){
				result = call.executeFunction(List.class,criteria.getComp1(),criteria.getComp4(),criteria.getComp5(), criteria.getComp6(), criteria.getComp7());
			}else if(criteria.getGu_id().equals("0021")){
				result = call.executeFunction(List.class,criteria.getComp1(),criteria.getComp4(),criteria.getComp5(), criteria.getComp6(), criteria.getComp7());
			}else if(criteria.getNumminlvl()>9){
				result = call.executeFunction(List.class, criteria.getCompany());
			}else{ 
				result = call.executeFunction(List.class,criteria.getEmp_id(),criteria.getComp1(),criteria.getComp4(),criteria.getComp5(), criteria.getComp6(), criteria.getComp7());
//				
			}
			

		}catch (Exception e) {
			logger.error(e.getMessage(),e);
		}
		return result;
	}
	@Override
	public List<DropDownObj> findWorkFlowService(DropDownCriteriaObj criteria) {
		List<DropDownObj> result = new ArrayList<DropDownObj>();
		String sp = "";
		try {
			
			SimpleJdbcCall call = new SimpleJdbcCall(jdbcTemplate)
			.withCatalogName("PKG_SERVICE_UTIL")
			.withProcedureName("SP_GET_WORKFLOW_SERVICE_IHR")
			.returningResultSet("P_CURSOR", new BeanPropertyRowMapper(DropDownObj.class));			
			result = call.executeFunction(List.class);

		}catch (Exception e) {
			logger.error(e.getMessage(),e);
		}
		return result;
	}
	@Override
	public List<DropDownObj> findMenuItem(DropDownCriteriaObj criteria) {
		List<DropDownObj> result = new ArrayList<DropDownObj>();
		String sp = "";
		try {
			
			SimpleJdbcCall call = new SimpleJdbcCall(jdbcTemplate)
			.withCatalogName("PKG_SERVICE_UTIL")
			.withProcedureName("SP_GET_MENU_ITEM")
			.returningResultSet("P_CURSOR", new BeanPropertyRowMapper(DropDownObj.class));			
			result = call.executeFunction(List.class,criteria.getComp1());

		}catch (Exception e) {
			logger.error(e.getMessage(),e);
		}
		return result;
	}
	@Override
	public List<DropDownObj> findAllmember(DropDownCriteriaObj criteria) {
		List<DropDownObj> result = new ArrayList<DropDownObj>();
		String sp = "";
		try {
			
			SimpleJdbcCall call = new SimpleJdbcCall(jdbcTemplate)
			.withCatalogName("PKG_SERVICE_UTIL")
			.withProcedureName("SP_GET_ALL_MEMBER")
			.returningResultSet("P_CURSOR", new BeanPropertyRowMapper(DropDownObj.class));			
			result = call.executeFunction(List.class);

		}catch (Exception e) {
			logger.error(e.getMessage(),e);
		}
		return result;
	}
	
	@Override
	public List<Map<String , Object>> getEmpBySearch(Map<String , Object> map){
//		List<DropDownObj> result = new ArrayList<DropDownObj>();
		List<Map<String , Object>> result = new ArrayList<>();
		try {
			StringBuffer sql = new StringBuffer();
			boolean chkNumberic = isNumeric(map.get("emp").toString()) ;
			if(chkNumberic){
				sql = new StringBuffer();
				sql.append("select a.CODEMPID as ddl_value,a.CODEMPID||' '||a.namempt as ddl_text ");
				sql.append("from hris_profile_v a ");
				sql.append("where codempid  like '"+map.get("emp")+"%' ");
				sql.append("order by a.CODEMPID ");
				result =  jdbcTemplate.queryForList(sql.toString());
			}else{
				sql = new StringBuffer();
				sql.append("select a.CODEMPID as ddl_value,a.CODEMPID||' '||a.namempt as ddl_text ");
				sql.append("from hris_profile_v a ");
				sql.append("where namempt like '%"+map.get("emp")+"%' ");
				sql.append("order by a.CODEMPID ");
				result =  jdbcTemplate.queryForList(sql.toString());
			}
		}catch (Exception e) {
			logger.error(e.getMessage(),e);
		}
		
		return result;
	}
	
	@Override
	public List<Map<String , Object>> getBranchBySearch(Map<String , Object> map){
		List<Map<String , Object>> result = new ArrayList<>();
		try {
			StringBuffer sql = new StringBuffer();
			sql = new StringBuffer();
			sql.append("select a.codcompany as ddl_value, a.namethai as ddl_text ");
			sql.append("from hris_org_v a ");
			sql.append("where namethai like '%"+map.get("branch")+"%' ");
			sql.append("and a.companylevel>4" );
			sql.append("order by a.codcompany ");
			result =  jdbcTemplate.queryForList(sql.toString());
		}catch (Exception e) {
			logger.error(e.getMessage(),e);
		}
		
		return result;
	}
	
	@Override
	public List<Map<String , Object>> getEmpByBranch(Map<String , Object> map){
		List<Map<String , Object>> result = new ArrayList<>();
		try {
			StringBuffer sql = new StringBuffer();
			sql = new StringBuffer();
			sql.append("select a.CODEMPID as ddl_value,a.CODEMPID||' '||a.namempt as ddl_text ");
			sql.append("from hris_profile_v a ");
			sql.append("where a.codcomp ='"+map.get("branch")+"' ");
			sql.append("order by a.codempid ");
			
			result =  jdbcTemplate.queryForList(sql.toString());
		}catch (Exception e) {
			logger.error(e.getMessage(),e);
		}
		
		return result;
	}
	
	public static boolean isNumeric(String str)  
	{  
	  try  
	  {  
	    double d = Double.parseDouble(str);  
	  }  
	  catch(NumberFormatException nfe)  
	  {  
	    return false;  
	  }  
	  return true;  
	}
}
