package th.co.pt.pcca.pccaservice.dao.admin;

import java.util.List;

import th.co.pt.pcca.pccaservice.entities.admin.SetupUnlockRequestObject;
import th.co.pt.pcca.pccaservice.entities.util.ResultObj;

public interface AdminUnlockReqDAO {

	List<SetupUnlockRequestObject> listSetupUnlockReq(SetupUnlockRequestObject criteria)throws Exception;

	ResultObj addSetupUnlockReq(SetupUnlockRequestObject criteria)throws Exception;

	ResultObj deleteSetupReq(List<SetupUnlockRequestObject> criteria)throws Exception;

	SetupUnlockRequestObject findSetupUnlockReq(SetupUnlockRequestObject criteria)throws Exception;

}
