package th.co.pt.pcca.pccaservice.dao.workflow;

import java.util.List;

import th.co.pt.pcca.pccaservice.entities.workflow.StepWorkFlowCriteriaObj;
import th.co.pt.pcca.pccaservice.entities.workflow.StepWorkFlowTransactionObj;

public interface TransactionDao {
	StepWorkFlowTransactionObj GetStepApprove(StepWorkFlowCriteriaObj criteria);
}
