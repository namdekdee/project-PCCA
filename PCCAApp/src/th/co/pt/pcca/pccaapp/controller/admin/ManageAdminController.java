package th.co.pt.pcca.pccaapp.controller.admin;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import th.co.pt.pcca.pccaapp.classobject.CGlobal;
import th.co.pt.pcca.pccaapp.entites.admin.SetUpManageAdmin;
import th.co.pt.pcca.pccaapp.helper.WebUtil;

@Controller
public class ManageAdminController {
	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	@RequestMapping(value = "/manageAdmin", method = RequestMethod.GET)
	public ModelAndView index() {
		System.out.println("first in come!!!");
		return new ModelAndView("manageAdmin", null); 
		
	}
	
	@RequestMapping(value = "/getDataAdmin", method = RequestMethod.POST)
	public @ResponseBody List<SetUpManageAdmin> GetDataAdmin() {
		String uri = WebUtil.WebServiceUrl() + "HrisService/getDataAdmin";
		SetUpManageAdmin setUpAdmin =new SetUpManageAdmin();
		RestTemplate restTemplate = new RestTemplate();
		List<SetUpManageAdmin> result = restTemplate.postForObject(uri,setUpAdmin,List.class);

		return result;
	}
}
