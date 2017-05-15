package th.co.pt.pcca.pccaservice.controller.account;

import java.util.ArrayList;
import java.util.EmptyStackException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import th.co.pt.pcca.pccaservice.classobject.CGlobal;
import th.co.pt.pcca.pccaservice.dao.account.MenuDao;
import th.co.pt.pcca.pccaservice.entities.account.UserMenuObj;
import th.co.pt.pcca.pccaservice.entities.member.MemberObj;
import th.co.pt.pcca.pccaservice.entities.util.ResultObj;
import th.co.pt.pcca.pccaservice.service.account.LoginService;
import th.co.pt.pcca.pccaservice.service.account.MenuService;

@Controller
public class MenuController {
	@Autowired
	private MenuService menuService;
	
	@RequestMapping(value = "/getmenu", method = RequestMethod.POST)
	public @ResponseBody UserMenuObj GetMenu(@RequestBody UserMenuObj user_menu)
	{	
		return menuService.GetMenu(user_menu.strPage);
	}
	@RequestMapping(value = "/setlang", method = RequestMethod.POST)
	public @ResponseBody UserMenuObj Setlang(@RequestBody UserMenuObj user_menu)
	{	CGlobal.C_UserInfo.lang =user_menu.lang;
		return menuService.GetMenu(user_menu.strPage);
	}
	
}
