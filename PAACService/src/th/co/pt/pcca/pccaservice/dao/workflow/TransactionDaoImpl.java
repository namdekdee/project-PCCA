package th.co.pt.pcca.pccaservice.dao.workflow;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import org.springframework.stereotype.Repository;

import th.co.pt.pcca.pccaservice.entities.account.MainMenuObj;
import th.co.pt.pcca.pccaservice.entities.member.MemberObj;
import th.co.pt.pcca.pccaservice.entities.workflow.ApproverWorkFlowObj;
import th.co.pt.pcca.pccaservice.entities.workflow.StepWorkFlowCriteriaObj;
import th.co.pt.pcca.pccaservice.entities.workflow.StepWorkFlowTransactionObj;
import th.co.pt.pcca.pccaservice.helper.*;

@Repository("transactionDao")
public class TransactionDaoImpl implements TransactionDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	private  final Logger logger = LoggerFactory.getLogger(this.getClass());
	public StepWorkFlowTransactionObj GetStepApprove(StepWorkFlowCriteriaObj criteria) {
		StepWorkFlowTransactionObj result = new StepWorkFlowTransactionObj();
		try{
			SimpleJdbcCall call = new SimpleJdbcCall(jdbcTemplate)
			.withCatalogName("PKG_SERVICE_WORKFLOW")
			.withProcedureName("SP_GETAPPROVER")
			.returningResultSet("P_CURSOR", new BeanPropertyRowMapper(ApproverWorkFlowObj.class));
			result.setWorkflowApprover(call.executeFunction(List.class,criteria.getTransactionId(),criteria.getServiceId(),criteria.getWorkflowId(),criteria.getEmpidRequest()));
		    result.setTransactionId(criteria.getTransactionId());
		    result.setServiceId(criteria.getServiceId());
		    result.setWorkflowId(criteria.getWorkflowId());
		    result.setEmpidRequest(criteria.getEmpidRequest());
			
		} catch (Exception ex) {
			logger.error(ex.getMessage(),ex);
			//ex.printStackTrace();
		}
		return result;
	}

}
