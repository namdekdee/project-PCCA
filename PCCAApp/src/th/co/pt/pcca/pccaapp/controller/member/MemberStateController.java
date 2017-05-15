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

import th.co.pt.pcca.pccaapp.classobject.CGlobal;
import th.co.pt.pcca.pccaapp.entities.member.SumaryOtCriteriaObj;
import th.co.pt.pcca.pccaapp.entities.member.SumaryOtObj;
import th.co.pt.pcca.pccaapp.entities.member.WorkStateCriteriaObj;
import th.co.pt.pcca.pccaapp.entities.member.WorkStateObj;
import th.co.pt.pcca.pccaapp.helper.WebUtil;

@Controller
public class MemberStateController {

	private  final Logger logger = LoggerFactory.getLogger(this.getClass());
	@RequestMapping(value = "/member-state", method = RequestMethod.GET)
	public ModelAndView memberhistory()
	{
		return new ModelAndView("member_state", null);
	}
	@RequestMapping(value = "/member-getstate", method = RequestMethod.POST)
	public @ResponseBody List<WorkStateObj> GetWorkTime(@RequestBody WorkStateCriteriaObj criteria,HttpSession session) {

		try{
		criteria.setApprover(CGlobal.getC_UserInfo(session).getCodempid());
		String uri = WebUtil.WebServiceUrl() + "HrisService/member-getworkstate";
		RestTemplate restTemplate = new RestTemplate();
		List<WorkStateObj> result = restTemplate.postForObject(uri, criteria,List.class);
		return result;
		}catch(Exception ex){
			logger.error(ex.getMessage(),ex);
			ex.printStackTrace();
			 throw new HTTPException(404);
		}
	}
}
