package th.co.pt.pcca.pccaservice.service.workflow;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import th.co.pt.pcca.pccaservice.classobject.CGlobal;
import th.co.pt.pcca.pccaservice.dao.account.MenuDao;
import th.co.pt.pcca.pccaservice.dao.workflow.TransactionDao;
import th.co.pt.pcca.pccaservice.entities.account.MainMenuObj;
import th.co.pt.pcca.pccaservice.entities.member.MemberObj;
import th.co.pt.pcca.pccaservice.entities.workflow.StepWorkFlowCriteriaObj;
import th.co.pt.pcca.pccaservice.entities.workflow.StepWorkFlowTransactionObj;
import th.co.pt.pcca.pccaservice.service.account.LoginService;
@Service("transactionService")
public class TransactionServiceImpl implements TransactionService {
	@Autowired
	private TransactionDao tranDao;
	
	public StepWorkFlowTransactionObj GetStepApprove(StepWorkFlowCriteriaObj criteria) {
		return tranDao.GetStepApprove(criteria);
	}

}
