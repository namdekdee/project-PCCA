package th.co.pt.pcca.pccaapp.controller.account;

import java.util.ArrayList;
import java.util.EmptyStackException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import th.co.pt.pcca.pccaapp.classobject.CGlobal;
import th.co.pt.pcca.pccaapp.entities.account.UserMenuObj;
import th.co.pt.pcca.pccaapp.entities.member.MemberObj;
import th.co.pt.pcca.pccaapp.entities.util.ResultObj;
import th.co.pt.pcca.pccaapp.service.account.LoginService;
import th.co.pt.pcca.pccaapp.service.account.MenuService;

@Controller
public class MenuController {
	@Autowired
	private MenuService menuService;
	
	@RequestMapping(value = "/getmenu", method = RequestMethod.POST)
	public @ResponseBody UserMenuObj GetMenu(@RequestBody UserMenuObj user_menu,HttpSession session)
	{	
		return menuService.GetMenu(user_menu.strPage,session);
	}
	
	@RequestMapping(value = "/setlang", method = RequestMethod.POST)
	public @ResponseBody UserMenuObj Setlang(@RequestBody UserMenuObj user_menu,HttpSession session)
	{	
	   MemberObj member_info = CGlobal.getC_UserInfo(session);
	   member_info.setLang(user_menu.lang);
		CGlobal.setC_UserInfo(member_info, session);
		return menuService.GetMenu(user_menu.strPage,session);
	}
	
	
	
}
