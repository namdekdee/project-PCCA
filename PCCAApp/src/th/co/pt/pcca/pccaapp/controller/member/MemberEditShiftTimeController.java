package th.co.pt.pcca.pccaapp.controller.member;

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

import com.sun.org.apache.regexp.internal.RESyntaxException;

import th.co.pt.pcca.pccaapp.classobject.CGlobal;
import th.co.pt.pcca.pccaapp.entities.member.MemberObj;
import th.co.pt.pcca.pccaapp.entities.member.ShiftTimeCriteriaObj;
import th.co.pt.pcca.pccaapp.entities.member.ShiftTimeDropdownObj;
import th.co.pt.pcca.pccaapp.entities.member.ShiftTimeObj;
import th.co.pt.pcca.pccaapp.entities.member.WorkTimeCriteriaObj;
import th.co.pt.pcca.pccaapp.entities.member.WorkTimeObj;
import th.co.pt.pcca.pccaapp.entities.util.ResultObj;
import th.co.pt.pcca.pccaapp.helper.WebUtil;

@Controller
public class MemberEditShiftTimeController {
	private  final Logger logger = LoggerFactory.getLogger(this.getClass());
	@RequestMapping(value = "/member-edit-shifttime", method = RequestMethod.GET)
	public ModelAndView memberhistory()
	{
		return new ModelAndView("member_edit_shifttime", null);
	}
	
	@RequestMapping(value = "/member-getmember-shifttime", method = RequestMethod.POST)
	public @ResponseBody List<ShiftTimeObj> GetShiftTime(@RequestBody ShiftTimeCriteriaObj criteria,HttpSession session) {
		try{
		String uri = WebUtil.WebServiceUrl() + "HrisService/member-getmember-shifttime";
		RestTemplate restTemplate = new RestTemplate();
		criteria.setApprover(CGlobal.getC_UserInfo(session).getCodempid());
		List<ShiftTimeObj> result = restTemplate.postForObject(uri, criteria,List.class);
		
		return result;
		}catch(Exception ex){
			logger.error(ex.getMessage(),ex);
			ex.printStackTrace();
			 throw new HTTPException(404);
		} 
	}
	
	@RequestMapping(value = "/member-getlist-shifttime", method = RequestMethod.POST)
	public @ResponseBody List<ShiftTimeDropdownObj> GetShiftTimeList(@RequestBody ShiftTimeCriteriaObj criteria,HttpSession session) {
		try{
		String uri = WebUtil.WebServiceUrl() + "HrisService/member-getshifttimelist";
		RestTemplate restTemplate = new RestTemplate();
		criteria.setApprover(CGlobal.getC_UserInfo(session).getCodempid());
		List<ShiftTimeDropdownObj> result = restTemplate.postForObject(uri, criteria,List.class);
	
		return result;
		}catch(Exception ex){
			logger.error(ex.getMessage(),ex);
			ex.printStackTrace();
			 throw new HTTPException(404);
		} 
	}
	
	@RequestMapping(value = "/member-update-editshifttime", method = RequestMethod.POST)
	public @ResponseBody ResultObj UpdateEditShiftTime(@RequestBody List<ShiftTimeCriteriaObj> criteria,HttpSession session) {
		try{
//		System.out.println("MemberEditShifttime");
		String uri = WebUtil.WebServiceUrl() + "HrisService/member-update-editshifttime";
		RestTemplate restTemplate = new RestTemplate();
		for(int i=0; i<criteria.size(); i++) {
			criteria.get(i).setApprover(CGlobal.getC_UserInfo(session).getCodempid());
		}
	    ResultObj result = restTemplate.postForObject(uri, criteria, ResultObj.class);
		return result;
		}catch(Exception ex){
			logger.error(ex.getMessage(),ex);
			ex.printStackTrace();
			 throw new HTTPException(404);
		}
	}
}
