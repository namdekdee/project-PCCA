package th.co.pt.pcca.pccaapp.controller.member;

import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.ws.http.HTTPException;

import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import th.co.pt.pcca.pccaapp.classobject.CGlobal;
import th.co.pt.pcca.pccaapp.entities.member.MemberObj;
import th.co.pt.pcca.pccaapp.entities.member.WorkTimeCriteriaObj;
import th.co.pt.pcca.pccaapp.entities.member.WorkTimeObj;
import th.co.pt.pcca.pccaapp.entities.util.ResultObj;
import th.co.pt.pcca.pccaapp.helper.WebUtil;

import org.springframework.http.MediaType;
import org.springframework.http.HttpHeaders;
import org.springframework.util.FileCopyUtils;

import java.io.File;
import java.io.FileInputStream;
@Controller
public class MemberApproveOtController {
	private  final Logger logger = LoggerFactory.getLogger(this.getClass());
	@RequestMapping(value = "/member-approve-ot", method = RequestMethod.GET)
	public ModelAndView memberhistory()
	{
		return new ModelAndView("member_approve_ot", null);
	}
	
	@RequestMapping(value = "/member-getmemberworktime-ot-approve", method = RequestMethod.POST)
	public @ResponseBody List<WorkTimeObj> GetWorkTimeEditTimeApprove(@RequestBody WorkTimeCriteriaObj criteria,HttpSession session) {
		try{
		criteria.setApprover(CGlobal.getC_UserInfo(session).codempid);
		String uri = WebUtil.WebServiceUrl() + "HrisService/member-getworktime-ot-approve";
		RestTemplate restTemplate = new RestTemplate();
		List<WorkTimeObj> result = restTemplate.postForObject(uri, criteria,List.class);
		return result;
		}catch(Exception ex){
			logger.error(ex.getMessage(),ex);
			ex.printStackTrace();
			 throw new HTTPException(404);
		}
	}
	
	
	
	@RequestMapping(value = "/member-updateworktimeot", method = RequestMethod.POST)
	public @ResponseBody ResultObj UpdateWorkTimeLeave(@RequestBody WorkTimeCriteriaObj criteria,HttpSession session) {
		try{
		criteria.setUpdate_user(CGlobal.getC_UserInfo(session).codempid);
		String uri = WebUtil.WebServiceUrl() + "HrisService/member-updateworktimeot";
		RestTemplate restTemplate = new RestTemplate();
		criteria.setUpdate_user(CGlobal.getC_UserInfo(session).getCodempid());
		ResultObj result = restTemplate.postForObject(uri, criteria,ResultObj.class);
		return result;
		}catch(Exception ex){
			logger.error(ex.getMessage(),ex);
			ex.printStackTrace();
			 throw new HTTPException(404);
		}
	}
}
