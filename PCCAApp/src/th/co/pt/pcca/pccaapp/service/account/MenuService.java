package th.co.pt.pcca.pccaapp.service.account;

import javax.servlet.http.HttpSession;

import th.co.pt.pcca.pccaapp.entities.account.UserMenuObj;
import th.co.pt.pcca.pccaapp.entities.member.MemberObj;

public interface MenuService {
	UserMenuObj GetMenu(String strPage,HttpSession session);
}
