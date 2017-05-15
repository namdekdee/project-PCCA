package th.co.pt.pcca.pccaservice.entities.workflow;

import java.util.List;

public class StepWorkFlowTransactionObj {
	public String transactionId;
	public String serviceId;
	public String workflowId;
	public String empidRequest;
	public List<ApproverWorkFlowObj> workflowApprover;
	public String getTransactionId() {
		return transactionId;
	}
	public void setTransactionId(String transactionId) {
		this.transactionId = transactionId;
	}
	public String getServiceId() {
		return serviceId;
	}
	public void setServiceId(String serviceId) {
		this.serviceId = serviceId;
	}
	public String getWorkflowId() {
		return workflowId;
	}
	public void setWorkflowId(String workflowId) {
		this.workflowId = workflowId;
	}
	public String getEmpidRequest() {
		return empidRequest;
	}
	public void setEmpidRequest(String empidRequest) {
		this.empidRequest = empidRequest;
	}
	public List<ApproverWorkFlowObj> getWorkflowApprover() {
		return workflowApprover;
	}
	public void setWorkflowApprover(List<ApproverWorkFlowObj> workflowApprover) {
		this.workflowApprover = workflowApprover;
	}
	
	
	
}
