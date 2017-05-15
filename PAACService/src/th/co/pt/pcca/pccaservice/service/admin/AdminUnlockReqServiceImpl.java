package th.co.pt.pcca.pccaservice.service.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import th.co.pt.pcca.pccaservice.dao.admin.AdminUnlockReqDAO;
import th.co.pt.pcca.pccaservice.entities.admin.SetupRequestObject;
import th.co.pt.pcca.pccaservice.entities.admin.SetupUnlockRequestObject;
import th.co.pt.pcca.pccaservice.entities.util.ResultObj;

@Service("AdminUnlockReqService")
public class AdminUnlockReqServiceImpl implements AdminUnlockReqService{
	
	@Autowired
	private AdminUnlockReqDAO adminUnlockReqDAO;
	@Override
	public List<SetupUnlockRequestObject> listSetupUnlockReq(SetupUnlockRequestObject criteria) throws Exception {
		return adminUnlockReqDAO.listSetupUnlockReq(criteria);
	}

	@Override
	public ResultObj addSetupUnlockReq(SetupUnlockRequestObject criteria) throws Exception {
		return adminUnlockReqDAO.addSetupUnlockReq(criteria);
	}

	@Override
	public ResultObj deleteSetupReq(List<SetupUnlockRequestObject> criteria) throws Exception {
		return adminUnlockReqDAO.deleteSetupReq(criteria);
	}

	@Override
	public SetupUnlockRequestObject findSetupUnlockReq(SetupUnlockRequestObject criteria) throws Exception {		
		return adminUnlockReqDAO.findSetupUnlockReq(criteria);
	}

	

}
