package th.co.pt.pcca.pccaservice.dao.admin;

import java.util.List;

import th.co.pt.pcca.pccaservice.entities.admin.SetUpRequestCriteriaObject;
import th.co.pt.pcca.pccaservice.entities.admin.SetupRequestObject;
import th.co.pt.pcca.pccaservice.entities.util.ResultObj;

public interface AdminDisableReqDAO {

	List<SetupRequestObject> listSetupReq(SetupRequestObject criteria)throws Exception;

	ResultObj addSetupReq(SetupRequestObject criteria)throws Exception;

	ResultObj deleteSetupReq(List<SetupRequestObject> criteria)throws Exception;

	SetupRequestObject findSetupReq(SetupRequestObject criteria)throws Exception;

	ResultObj checkSetupReq(SetUpRequestCriteriaObject criteria)throws Exception;
	

}
