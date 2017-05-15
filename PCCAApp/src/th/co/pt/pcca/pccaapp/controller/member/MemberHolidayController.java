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
import th.co.pt.pcca.pccaapp.entities.member.*;
import th.co.pt.pcca.pccaapp.helper.WebUtil;

@Controller
public class MemberHolidayController {
	private  final Logger logger = LoggerFactory.getLogger(this.getClass());
	@RequestMapping(value = "/member-holiday", method = RequestMethod.GET)
	public ModelAndView memberhistory()
	{
		return new ModelAndView("member_holiday", null);
	}
	
	@RequestMapping(value = "/member-getholiday", method = RequestMethod.POST)
	public @ResponseBody List<HolidayObj> GetHoliday(@RequestBody MemberObj criteria,HttpSession session) {
		try{
		criteria.codempid = CGlobal.getC_UserInfo(session).getCodempid();
		String uri = WebUtil.WebServiceUrl() + "HrisService/member-getholiday";
		RestTemplate restTemplate = new RestTemplate();
		List<HolidayObj> result = restTemplate.postForObject(uri, criteria,List.class);
		return result;
		}catch(Exception ex){
			logger.error(ex.getMessage(),ex);
			ex.printStackTrace();
			 throw new HTTPException(404);
		}
	}
	
}
