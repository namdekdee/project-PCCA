package th.co.pt.pcca.pccaapp.controller.member;

import java.util.List;

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
import th.co.pt.pcca.pccaapp.entities.account.UserMenuObj;
import th.co.pt.pcca.pccaapp.entities.member.MemberObj;
import th.co.pt.pcca.pccaapp.entities.util.DropDownCriteriaObj;
import th.co.pt.pcca.pccaapp.entities.util.DropDownObj;
import th.co.pt.pcca.pccaapp.helper.WebUtil;

@Controller
public class MemberProfileController {

	private  final Logger logger = LoggerFactory.getLogger(this.getClass());
	@RequestMapping(value = "/member-profile", method = RequestMethod.GET)
	public ModelAndView memberhistory()
	{
		return new ModelAndView("member_profile", null);
	}
	
	@RequestMapping(value = "/member-getmemberprofile", method = RequestMethod.POST)
	public @ResponseBody MemberObj GetMemberProfile(@RequestBody MemberObj criteria) {
		try{
		String uri = WebUtil.WebServiceUrl() + "HrisService/member-getmemberprofile";
		RestTemplate restTemplate = new RestTemplate();
		MemberObj result = restTemplate.postForObject(uri, criteria,MemberObj.class);
		return result;
		}catch(Exception ex){
			logger.error(ex.getMessage(),ex);
			ex.printStackTrace();
			 throw new HTTPException(404);
		}
	}
	
}
