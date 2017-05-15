package th.co.pt.pcca.pccaservice.service.workflow;

import java.util.List;

import th.co.pt.pcca.pccaservice.entities.workflow.*;

public interface TransactionService {
	StepWorkFlowTransactionObj GetStepApprove(StepWorkFlowCriteriaObj criteria);
}
