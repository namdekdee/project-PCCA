package th.co.pt.pcca.pccaservice.controller.admin;

import java.io.IOException;
import java.util.List;

import javax.xml.ws.http.HTTPException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import th.co.pt.pcca.pccaservice.entities.admin.SetUpManageAdmin;
import th.co.pt.pcca.pccaservice.entities.util.DropDownCriteriaObj;
import th.co.pt.pcca.pccaservice.entities.util.DropDownObj;
import th.co.pt.pcca.pccaservice.service.admin.ManageAdminService;

@Controller
public class ApiManageAdminController {
	
	@Autowired
	private ManageAdminService manageAdminService;
	
	@RequestMapping(value = "/getDataAdmin", method = RequestMethod.POST)
    @ResponseBody
    public List<SetUpManageAdmin> getDataAdmin() throws HTTPException, IOException {
	 
	 try
	 {
        return manageAdminService.getDataAdmin();
	 }
	 catch(Exception ex)
	 {
		 throw new HTTPException(404);
	 }
 }
}
