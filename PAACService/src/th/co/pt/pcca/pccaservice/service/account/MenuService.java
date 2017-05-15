package th.co.pt.pcca.pccaservice.service.account;

import th.co.pt.pcca.pccaservice.entities.account.UserMenuObj;
import th.co.pt.pcca.pccaservice.entities.member.MemberObj;

public interface MenuService {
	UserMenuObj GetMenu(String strPage);
}
