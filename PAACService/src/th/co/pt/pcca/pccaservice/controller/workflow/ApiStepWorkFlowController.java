package th.co.pt.pcca.pccaservice.controller.workflow;

import java.io.IOException;
import java.util.List;

import javax.xml.ws.http.HTTPException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import th.co.pt.pcca.pccaservice.entities.workflow.StepWorkFlowCriteriaObj;
import th.co.pt.pcca.pccaservice.entities.workflow.StepWorkFlowTransactionObj;
import th.co.pt.pcca.pccaservice.service.workflow.TransactionService;

@Controller
public class ApiStepWorkFlowController {
	@Autowired
	private TransactionService transactionService;
	
	 @RequestMapping(value = "/workflow-getapproverstep", method = RequestMethod.POST)
	    @ResponseBody
	    public StepWorkFlowTransactionObj getApproverStep( @RequestBody StepWorkFlowCriteriaObj criteria) throws HTTPException, IOException {
		 
		 try
		 {
			 StepWorkFlowTransactionObj result =new StepWorkFlowTransactionObj();
			 result =transactionService.GetStepApprove(criteria);
	        return result;
		 }
		 catch(Exception ex)
		 {
			 throw new HTTPException(404);
		 }
	 }
}
