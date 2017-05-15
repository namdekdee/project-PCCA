package th.co.pt.pcca.pccaapp.controller.admin;

import java.util.List;

import javax.servlet.http.HttpSession;
import javax.xml.ws.http.HTTPException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import th.co.pt.pcca.pccaapp.classobject.CGlobal;
import th.co.pt.pcca.pccaapp.entites.admin.SetupRequestObject;
import th.co.pt.pcca.pccaapp.entities.util.ResultObj;
import th.co.pt.pcca.pccaapp.helper.WebUtil;


@Controller
public class AdminConfigDisabledRequestController {
	
	private Logger logger = LoggerFactory.getLogger(getClass());
	
	@RequestMapping(value="admin-config-disabled-request",method=RequestMethod.GET)
	public ModelAndView init()
	{
		return new ModelAndView("admin_config_disabled_request", null);
	}
	
	@RequestMapping(value="admin-list-setup-reqs",method=RequestMethod.POST)
	public @ResponseBody List<SetupRequestObject> listSetupReq(@RequestBody SetupRequestObject  criteria,HttpSession session)throws Exception{
		try{			
			String uri = WebUtil.WebServiceUrl() + "HrisService/admin-list-setup-reqs";
			criteria.setUpdate_by(CGlobal.getC_UserInfo(session).codempid);
			RestTemplate restTemplate = new RestTemplate();
			return restTemplate.postForObject(uri, criteria, List.class);
		}catch(Exception ex){
			logger.error(ex.getMessage(),ex);
			ex.printStackTrace();
			 throw new HTTPException(404);
		}		 
	}
	
	@RequestMapping(value="admin-get-config-request",method=RequestMethod.POST)
	public @ResponseBody SetupRequestObject findSetupReq(@RequestBody SetupRequestObject  criteria,HttpSession session)throws Exception{
		try{			
			String uri = WebUtil.WebServiceUrl() + "HrisService/admin-get-config-request";
			criteria.setUpdate_by(CGlobal.getC_UserInfo(session).codempid);
			RestTemplate restTemplate = new RestTemplate();
			return restTemplate.postForObject(uri, criteria, SetupRequestObject.class);
		}catch(Exception ex){
			logger.error(ex.getMessage(),ex);
			ex.printStackTrace();
			 throw new HTTPException(404);
		}		 
	}
	
	@RequestMapping(value="admin-add-reqs",method=RequestMethod.POST)
	public @ResponseBody ResultObj addSetupReq(@RequestBody SetupRequestObject  criteria,HttpSession session)throws Exception{
		try{
			criteria.setUpdate_by(CGlobal.getC_UserInfo(session).codempid);
			String uri = WebUtil.WebServiceUrl() + "HrisService/admin-add-reqs";
			RestTemplate restTemplate = new RestTemplate();
			return restTemplate.postForObject(uri, criteria, ResultObj.class);			
		}catch(Exception ex){
			logger.error(ex.getMessage(),ex);
			ex.printStackTrace();
			 throw new HTTPException(404);
		}		 
	}
	
	@RequestMapping(value="admin-delete-reqs",method=RequestMethod.POST)
	public @ResponseBody ResultObj deleteSetupReq(@RequestBody List<SetupRequestObject> criteria,HttpSession session)throws Exception{
		try{
			criteria.forEach(a -> a.update_by = CGlobal.getC_UserInfo(session).codempid);
			String uri = WebUtil.WebServiceUrl() + "HrisService/admin-delete-reqs";
			RestTemplate restTemplate = new RestTemplate();
			return restTemplate.postForObject(uri, criteria, ResultObj.class);
		}catch(Exception ex){
			logger.error(ex.getMessage(),ex);
			ex.printStackTrace();
			 throw new HTTPException(404);
		}		 
	}
}

