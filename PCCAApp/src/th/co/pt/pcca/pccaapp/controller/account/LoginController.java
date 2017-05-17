package th.co.pt.pcca.pccaapp.controller.account;

import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.xml.ws.http.HTTPException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import th.co.pt.pcca.pccaapp.entities.member.MemberObj;
import th.co.pt.pcca.pccaapp.entities.util.ResultObj;
import th.co.pt.pcca.pccaapp.entities.workflow.StepWorkFlowCriteriaObj;
import th.co.pt.pcca.pccaapp.entities.workflow.StepWorkFlowTransactionObj;
import th.co.pt.pcca.pccaapp.helper.WebUtil;
import th.co.pt.pcca.pccaapp.service.account.LoginService;

@Controller
public class LoginController {
	@Autowired
	private LoginService loginService;

	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	@RequestMapping(value = "/welcome", method = RequestMethod.GET)
	public ModelAndView index() {

		return new ModelAndView("account_login", null);
	}

	@RequestMapping(value = "/home", method = RequestMethod.GET)
	public ModelAndView home() {
		return new ModelAndView("home_default", null);
	}

	@RequestMapping(value = "/welcome_back", method = RequestMethod.GET)
	public ModelAndView login(HttpServletRequest httpRequest) {
		try {
			String uri = WebUtil.WebServiceUrl()
					+ "PCCAService/account-getmenu";
			logger.info("uri login >> " + uri);

			String cookie_name = "";
			String member_no = "";
			for (Cookie c : httpRequest.getCookies()) {
				if (c.getName().equals("uid")) {
					member_no = c.getValue();
				}
				cookie_name += "|" + c.getName() + ":" + c.getValue();
			}

			System.out.println(cookie_name);
			logger.info("cookie_name >> " + cookie_name);
			MemberObj data = new MemberObj();
			data.codempid = member_no;
			data.password = "";
			RestTemplate restTemplate = new RestTemplate();
			MemberObj member_data = restTemplate.postForObject(uri, data,
					MemberObj.class);
			// Result result = restTemplate.getForObject(uri, Result.class);
			ResultObj result = new ResultObj();
			if (member_data != null) {
				if (!WebUtil.IsStringEmpty(member_data.codempid)) {
					if (loginService.InitMember(member_data,
							httpRequest.getSession())) {
						logger.info("login success >> " + member_data.codempid);
						result.success = 1;
						result.message = "login success";
						// return new ModelAndView("home", null);
						return new ModelAndView(new RedirectView(
								httpRequest.getContextPath() + "/"
										+ member_data.getPage_default()));
					} else {
						result.success = 0;
						result.message = "login error";
						throw new HTTPException(403);
					}
				} else {
					result.success = 0;
					result.message = "login error";
					throw new HTTPException(403);
				}
			} else {
				result.success = 0;
				result.message = "login error";
				// throw new HTTPException(403);
				return new ModelAndView(
						new RedirectView(WebUtil.SsoLogOutUrl()));
			}
		} catch (Exception ex) {
			return new ModelAndView(new RedirectView(WebUtil.SsoLogOutUrl()));
		}
		// return result;
	}

	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public @ResponseBody ResultObj login(@RequestBody MemberObj member,
			HttpServletRequest httpRequest) {
		ResultObj result = new ResultObj();
		try {
			logger.info("Start login");
			String uri = WebUtil.WebServiceUrl()
					+ "HrisService/account-getmenu";
			MemberObj data = new MemberObj();
			data.codempid = member.codempid;
			data.password = member.password;
			RestTemplate restTemplate = new RestTemplate();
			MemberObj member_data = restTemplate.postForObject(uri, data,
					MemberObj.class);
			// Result result = restTemplate.getForObject(uri, Result.class);

			if (member_data != null) {
				if (!WebUtil.IsStringEmpty(member_data.codempid)) {
					if (loginService.InitMember(member_data,
							httpRequest.getSession())) {
						result.success = 1;
						result.message = "login success";
						result.setDefault_page(member_data.getPage_default());
					} else {
						result.success = 0;
						result.message = "login error";
					}
				} else {
					result.success = 0;
					result.message = "login error";
				}
			} else {
				result.success = 0;
				result.message = "login error";
			}
			logger.info("login success");
			return result;
		} catch (Exception ex) {
			logger.error(ex.getMessage(), ex);
			ex.printStackTrace();
			result.success = 0;
			result.message = "login error";
			return result;
		}
	}

	@RequestMapping(value = "/test-getapprove", method = RequestMethod.GET)
	public @ResponseBody List<StepWorkFlowTransactionObj> testGetApprove() {

		String uri = WebUtil.WebServiceUrl()
				+ "HrisService/workflow-getapproverstep";

		StepWorkFlowCriteriaObj data = new StepWorkFlowCriteriaObj();
		data.service_id = "001";
		data.company_id = "000";
		data.emp_id = "595234";
		data.seq_no = "0004";
		RestTemplate restTemplate = new RestTemplate();
		List<StepWorkFlowTransactionObj> member_data = restTemplate
				.postForObject(uri, data, List.class);
		return member_data;
	}

	@RequestMapping(value = "/loginCA", method = RequestMethod.POST)
	public @ResponseBody ResultObj loginCA(@RequestBody MemberObj member,
			HttpServletRequest httpRequest) {
		ResultObj result = new ResultObj();
		try {
			logger.info("Start loginCA");
			String uri = WebUtil.WebServiceUrl()
					+ "HrisService/account-getmenu-CA";
			MemberObj data = new MemberObj();
			data.codempid = member.codempid;
			data.password = member.password;
			RestTemplate restTemplate = new RestTemplate();
			MemberObj member_data = restTemplate.postForObject(uri, data,
					MemberObj.class);
			// Result result = restTemplate.getForObject(uri, Result.class);

			if (member_data != null) {
				if (!WebUtil.IsStringEmpty(member_data.codempid)) {
					if (loginService.InitMember(member_data,
							httpRequest.getSession())) {
						result.success = 1;
						result.message = "login success";
						result.setDefault_page(member_data.getPage_default());
					} else {
						result.success = 0;
						result.message = "login error";
					}
				} else {
					result.success = 0;
					result.message = "login error";
				}
			} else {
				result.success = 0;
				result.message = "login error";
			}
			logger.info("login success");
			return result;
		} catch (Exception ex) {
			logger.error(ex.getMessage(), ex);
			ex.printStackTrace();
			result.success = 0;
			result.message = "login error";
			return result;
		}
	}

}
