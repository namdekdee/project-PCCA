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
import th.co.pt.pcca.pccaapp.entites.admin.SetupUnlockRequestObject;
import th.co.pt.pcca.pccaapp.entities.util.ResultObj;
import th.co.pt.pcca.pccaapp.helper.WebUtil;


@Controller
public class AdminConfigUnlockRequestController {
	
	private Logger logger = LoggerFactory.getLogger(getClass());
	
	@RequestMapping(value="admin-config-unlock-request",method=RequestMethod.GET)
	public ModelAndView init(){	
		return new ModelAndView("admin_config_unlock_request", null);
	}
	
	@RequestMapping(value="admin-list-unlock-reqs",method=RequestMethod.POST)
	public @ResponseBody List<SetupUnlockRequestObject> listSetupUnlockReq(@RequestBody SetupUnlockRequestObject  criteria,HttpSession session)throws Exception{
		try{			
			String uri = WebUtil.WebServiceUrl() + "HrisService/admin-list-unlock-reqs";
			criteria.setUpdate_by(CGlobal.getC_UserInfo(session).codempid);
			RestTemplate restTemplate = new RestTemplate();
			return restTemplate.postForObject(uri, criteria, List.class);
		}catch(Exception ex){
			logger.error(ex.getMessage(),ex);
			ex.printStackTrace();
			 throw new HTTPException(404);
		}				 
	}
	
	@RequestMapping(value="admin-get-unlock-reqs",method=RequestMethod.POST)
	public @ResponseBody SetupUnlockRequestObject findSetupUnlockReq(@RequestBody SetupUnlockRequestObject  criteria,HttpSession session)throws Exception{
		try{			
			String uri = WebUtil.WebServiceUrl() + "HrisService/admin-get-unlock-reqs";
			criteria.setUpdate_by(CGlobal.getC_UserInfo(session).codempid);
			RestTemplate restTemplate = new RestTemplate();
			return restTemplate.postForObject(uri, criteria, SetupUnlockRequestObject.class);
		}catch(Exception ex){
			logger.error(ex.getMessage(),ex);
			ex.printStackTrace();
			 throw new HTTPException(404);
		}				 
	}
	
	@RequestMapping(value="admin-add-unlock-reqs",method=RequestMethod.POST)
	public @ResponseBody ResultObj addSetupUnlockReq(@RequestBody SetupUnlockRequestObject  criteria,HttpSession session)throws Exception{
		try{
			criteria.setUpdate_by(CGlobal.getC_UserInfo(session).codempid);
			String uri = WebUtil.WebServiceUrl() + "HrisService/admin-add-unlock-reqs";
			RestTemplate restTemplate = new RestTemplate();
			return restTemplate.postForObject(uri, criteria, ResultObj.class);			
		}catch(Exception ex){
			logger.error(ex.getMessage(),ex);
			ex.printStackTrace();
			 throw new HTTPException(404);
		}		 
	}
	
	@RequestMapping(value="admin-delete-unlock-reqs",method=RequestMethod.POST)
	public @ResponseBody ResultObj deleteSetupReq(@RequestBody List<SetupUnlockRequestObject> criteria,HttpSession session)throws Exception{
		try{
			criteria.forEach(a -> a.update_by = CGlobal.getC_UserInfo(session).codempid);
			String uri = WebUtil.WebServiceUrl() + "HrisService/admin-delete-unlock-reqs";
			RestTemplate restTemplate = new RestTemplate();
			return restTemplate.postForObject(uri, criteria, ResultObj.class);
		}catch(Exception ex){
			logger.error(ex.getMessage(),ex);
			ex.printStackTrace();
			throw new HTTPException(404);
		}		 
	}
}
