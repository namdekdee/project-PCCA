package th.co.pt.pcca.pccaservice.service.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import th.co.pt.pcca.pccaservice.dao.admin.AdminDisableReqDAO;
import th.co.pt.pcca.pccaservice.entities.admin.SetUpRequestCriteriaObject;
import th.co.pt.pcca.pccaservice.entities.admin.SetupRequestObject;
import th.co.pt.pcca.pccaservice.entities.util.ResultObj;

@Service("AdminDisableReqService")
public class AdminDisableReqServiceImpl implements AdminDisableReqService {

	@Autowired
	private AdminDisableReqDAO adminDisableReqDAO;

	@Override
	public List<SetupRequestObject> listSetupReq(SetupRequestObject criteria)
			throws Exception {
		return adminDisableReqDAO.listSetupReq(criteria);
	}

	@Override
	public ResultObj addSetupReq(SetupRequestObject criteria) throws Exception {
		return adminDisableReqDAO.addSetupReq(criteria);
	}

	@Override
	public ResultObj deleteSetupReq(List<SetupRequestObject> criteria)
			throws Exception {
		return adminDisableReqDAO.deleteSetupReq(criteria);
	}

	@Override
	public SetupRequestObject findSetupReq(SetupRequestObject criteria)
			throws Exception {
		return adminDisableReqDAO.findSetupReq(criteria);
	}

	@Override
	public ResultObj checkSetupReq(SetUpRequestCriteriaObject criteria)
			throws Exception {
		return adminDisableReqDAO.checkSetupReq(criteria);
	}

}
