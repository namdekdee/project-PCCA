package th.co.pt.pcca.pccaservice.service.admin;

import java.util.List;

import org.springframework.stereotype.Service;

import th.co.pt.pcca.pccaservice.entities.admin.SetUpManageAdmin;


public interface ManageAdminService {
	
	List<SetUpManageAdmin> getDataAdmin();
}
