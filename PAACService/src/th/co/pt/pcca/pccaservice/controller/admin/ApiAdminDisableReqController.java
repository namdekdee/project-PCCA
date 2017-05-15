package th.co.pt.pcca.pccaservice.controller.admin;

import java.util.List;

import javax.servlet.http.HttpSession;
import javax.xml.ws.http.HTTPException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import th.co.pt.pcca.pccaservice.entities.admin.SetUpRequestCriteriaObject;
import th.co.pt.pcca.pccaservice.entities.admin.SetupRequestObject;
import th.co.pt.pcca.pccaservice.entities.util.ResultObj;
import th.co.pt.pcca.pccaservice.service.admin.AdminDisableReqService;


@Controller
public class ApiAdminDisableReqController {
	
	private Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired
	private AdminDisableReqService adminService;
		
	
	@RequestMapping(value="admin-list-setup-reqs",method=RequestMethod.POST)
	public @ResponseBody List<SetupRequestObject> listSetupReq(@RequestBody SetupRequestObject  criteria,HttpSession session)throws Exception{
		try{			
			return adminService.listSetupReq(criteria);
		}catch(Exception ex){
			logger.error(ex.getMessage(),ex);
			ex.printStackTrace();
			 throw new HTTPException(404);
		}		 
	}
	
	@RequestMapping(value="admin-get-config-request",method=RequestMethod.POST)
	public @ResponseBody SetupRequestObject findSetupReq(@RequestBody SetupRequestObject  criteria,HttpSession session)throws Exception{
		try{			
			return adminService.findSetupReq(criteria);			
		}catch(Exception ex){
			logger.error(ex.getMessage(),ex);
			ex.printStackTrace();
			 throw new HTTPException(404);
		}		 
	}
	
	@RequestMapping(value="admin-add-reqs",method=RequestMethod.POST)
	public @ResponseBody ResultObj addSetupReq(@RequestBody SetupRequestObject  criteria,HttpSession session)throws Exception{
		try{			
			return adminService.addSetupReq(criteria);
		}catch(Exception ex){
			logger.error(ex.getMessage(),ex);
			ex.printStackTrace();
			 throw new HTTPException(404);
		}		 
	}
	
	@RequestMapping(value="admin-delete-reqs",method=RequestMethod.POST)
	public @ResponseBody ResultObj deleteSetupReq(@RequestBody List<SetupRequestObject> criteria,HttpSession session)throws Exception{
		try{			
			return adminService.deleteSetupReq(criteria);
		}catch(Exception ex){
			logger.error(ex.getMessage(),ex);
			ex.printStackTrace();
			 throw new HTTPException(404);
		}		 
	}
	
	@RequestMapping(value="admin-check-reqs",method=RequestMethod.POST)
	public @ResponseBody ResultObj checkSetupReq(@RequestBody SetUpRequestCriteriaObject criteria,HttpSession session)throws Exception{
		try{			
			return adminService.checkSetupReq(criteria);
		}catch(Exception ex){
			logger.error(ex.getMessage(),ex);
			ex.printStackTrace();
			 throw new HTTPException(404);
		}		 
	}
	

}
