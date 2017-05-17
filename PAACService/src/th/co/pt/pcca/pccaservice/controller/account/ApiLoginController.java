package th.co.pt.pcca.pccaservice.controller.account;

import java.io.IOException;
import java.util.ArrayList;
import java.util.EmptyStackException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.xml.ws.http.HTTPException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.view.RedirectView;

import th.co.pt.pcca.pccaservice.classobject.CGlobal;
import th.co.pt.pcca.pccaservice.dao.account.MenuDao;
import th.co.pt.pcca.pccaservice.entities.account.MemberAccountObj;
import th.co.pt.pcca.pccaservice.entities.member.MemberObj;
import th.co.pt.pcca.pccaservice.entities.util.ResultObj;
import th.co.pt.pcca.pccaservice.service.account.LoginService;

@Controller
public class ApiLoginController {
	@Autowired
	private LoginService loginService;
	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	@RequestMapping(value = "/account-getmenu", method = RequestMethod.POST)
	@ResponseBody
	public MemberObj updateCustomer(@RequestBody MemberObj user)
			throws HTTPException, IOException {

		try {
			logger.info("strart request account-getmenu >> " + user.codempid);
			return loginService.GetMember(user.codempid, user.password);
		} catch (Exception ex) {
			logger.error(ex.getMessage());
			throw new HTTPException(404);
		}
	}

	@RequestMapping(value = "/account-getmenu-CA", method = RequestMethod.POST)
	@ResponseBody
	public MemberObj updateCustomerCA(@RequestBody MemberObj user)
			throws HTTPException, IOException {

		try {
			logger.info("strart request account-getmenuCA >> " + user.codempid);
			return loginService.GetMemberCA(user.codempid, user.password);
		} catch (Exception ex) {
			logger.error(ex.getMessage());
			throw new HTTPException(404);
		}
	}

	@RequestMapping(value = "/account-getmenu-pms", method = RequestMethod.POST)
	@ResponseBody
	public MemberObj getMenuPms(@RequestBody MemberObj user)
			throws HTTPException, IOException {

		try {
			return loginService.GetMemberPms(user.codempid, user.password);
		} catch (Exception ex) {
			throw new HTTPException(404);
		}
	}

	@RequestMapping(value = "/check-member-account", method = RequestMethod.POST)
	@ResponseBody
	public MemberAccountObj getMemberAccount(@RequestBody MemberObj member)
			throws HTTPException, IOException {
		try {
			return loginService.GetMemberAccount(member.codempid,
					member.password);
		} catch (Exception e) {
			throw new HTTPException(404);
		}
	}

}
