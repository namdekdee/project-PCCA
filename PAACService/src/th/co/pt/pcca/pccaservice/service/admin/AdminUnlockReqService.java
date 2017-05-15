package th.co.pt.pcca.pccaservice.service.admin;

import java.util.List;

import th.co.pt.pcca.pccaservice.entities.admin.SetupUnlockRequestObject;
import th.co.pt.pcca.pccaservice.entities.util.ResultObj;

public interface AdminUnlockReqService {

	List<SetupUnlockRequestObject> listSetupUnlockReq(SetupUnlockRequestObject criteria)throws Exception;
	
	ResultObj addSetupUnlockReq(SetupUnlockRequestObject criteria)throws Exception;

	ResultObj deleteSetupReq(List<SetupUnlockRequestObject> criteria)throws Exception;

	SetupUnlockRequestObject findSetupUnlockReq(SetupUnlockRequestObject criteria)throws Exception;

	

	

}
