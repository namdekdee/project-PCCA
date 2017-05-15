package th.co.pt.pcca.pccaservice.service.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import th.co.pt.pcca.pccaservice.dao.admin.AdminUnlockReqDAO;
import th.co.pt.pcca.pccaservice.dao.admin.ManageAdminDao;
import th.co.pt.pcca.pccaservice.entities.admin.SetUpManageAdmin;

@Service("ManageAdminService")
public class ManageAdminServiceImp implements ManageAdminService {
	@Autowired
	private ManageAdminDao manageAdminDao;
	
	public List<SetUpManageAdmin> getDataAdmin(){
		return manageAdminDao.getDataAdmin();
	}
}
