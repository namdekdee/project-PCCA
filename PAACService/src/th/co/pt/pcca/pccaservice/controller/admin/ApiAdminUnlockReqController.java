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

import th.co.pt.pcca.pccaservice.entities.admin.SetupUnlockRequestObject;
import th.co.pt.pcca.pccaservice.entities.util.ResultObj;
import th.co.pt.pcca.pccaservice.service.admin.AdminUnlockReqService;


@Controller
public class ApiAdminUnlockReqController {
	
	private Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	private AdminUnlockReqService adminService;
		
	
	@RequestMapping(value="admin-list-unlock-reqs",method=RequestMethod.POST)
	public @ResponseBody List<SetupUnlockRequestObject> listSetupUnlockReq(@RequestBody SetupUnlockRequestObject  criteria,HttpSession session)throws Exception{
		try{			
			return adminService.listSetupUnlockReq(criteria);
		}catch(Exception ex){
			logger.error(ex.getMessage(),ex);
			ex.printStackTrace();
			 throw new HTTPException(404);
		}		 
	}
	
	@RequestMapping(value="admin-get-unlock-reqs",method=RequestMethod.POST)
	public @ResponseBody SetupUnlockRequestObject findSetupUnlockReq(@RequestBody SetupUnlockRequestObject  criteria,HttpSession session)throws Exception{
		try{	
			return adminService.findSetupUnlockReq(criteria);
		}catch(Exception ex){
			logger.error(ex.getMessage(),ex);
			ex.printStackTrace();
			 throw new HTTPException(404);
		}				 
	}
	
	@RequestMapping(value="admin-add-unlock-reqs",method=RequestMethod.POST)
	public @ResponseBody ResultObj addSetupUnlockReq(@RequestBody SetupUnlockRequestObject  criteria,HttpSession session)throws Exception{
		try{			
			return adminService.addSetupUnlockReq(criteria);
		}catch(Exception ex){
			logger.error(ex.getMessage(),ex);
			ex.printStackTrace();
			 throw new HTTPException(404);
		}		 
	}
	
	@RequestMapping(value="admin-delete-unlock-reqs",method=RequestMethod.POST)
	public @ResponseBody ResultObj deleteSetupReq(@RequestBody List<SetupUnlockRequestObject> criteria,HttpSession session)throws Exception{
		try{			
			return adminService.deleteSetupReq(criteria);
		}catch(Exception ex){
			logger.error(ex.getMessage(),ex);
			ex.printStackTrace();
			throw new HTTPException(404);
		}		 
	}
}
