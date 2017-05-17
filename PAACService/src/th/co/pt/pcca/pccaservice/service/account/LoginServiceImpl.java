package th.co.pt.pcca.pccaservice.service.account;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import th.co.pt.pcca.pccaservice.classobject.CGlobal;
import th.co.pt.pcca.pccaservice.dao.account.MenuDao;
import th.co.pt.pcca.pccaservice.dao.ca.MenuCaDao;
import th.co.pt.pcca.pccaservice.entities.account.MainMenuObj;
import th.co.pt.pcca.pccaservice.entities.account.MemberAccountObj;
import th.co.pt.pcca.pccaservice.entities.member.MemberObj;

@Service("loginService")
public class LoginServiceImpl implements LoginService {
	@Autowired
	private MenuDao menuDao;
	@Autowired
	private MenuCaDao menuCaDao;

	public Boolean InitMember(String member_no, String password) {
		Boolean success = false;
		MemberObj ref_member = menuDao.GetUserPermiss(member_no, password);
		if (ref_member != null) {
			CGlobal.setC_UserInfo(ref_member);
			CGlobal.C_UserInfo.codempid = member_no;
			// CGlobal.C_UserInfo.password = password;
			MainMenuObj home = new MainMenuObj();
			home.app_path = "home";
			home.app_desc = "หน้าหลัก";
			home.app_head_desc = "";
			home.app_desc_en = "Home";
			home.app_head_desc_en = "";
			MainMenuObj error = new MainMenuObj();
			error.app_path = "error";
			error.app_desc = "error";
			error.app_head_desc = "";
			error.app_desc_en = "Home";
			error.app_head_desc_en = "";
			CGlobal.C_UserInfo.mainmenu.add(home);
			CGlobal.C_UserInfo.mainmenu.add(error);
			success = true;

		} else {
			CGlobal.C_UserInfo = null;
		}
		return success;
	}

	public MemberObj GetUserMenu(String member_no, String password) {
		MemberObj ref_member = menuDao.GetUserPermiss(member_no, password);
		if (ref_member != null) {
			CGlobal.setC_UserInfo(ref_member);
		}
		return ref_member;
	}

	public MemberObj GetMember(String member_no, String password) {
		Boolean success = false;
		MemberObj ref_member = menuDao.GetUserPermiss(member_no, password);

		return ref_member;
	}

	public MemberObj GetMemberCA(String member_no, String password) {
		final Logger logger = LoggerFactory.getLogger(this.getClass());
		logger.info("Login ServiceImpl GetMemberCA");
		Boolean success = false;
		MemberObj ref_member = menuCaDao.GetUserPermiss(member_no, password);

		return ref_member;
	}

	public MemberObj GetMemberPms(String member_no, String password) {
		Boolean success = false;
		MemberObj ref_member = menuDao.GetUserPms(member_no, password);

		return ref_member;
	}

	public MemberAccountObj GetMemberAccount(String member_no, String password) {
		Boolean success = false;
		MemberAccountObj ref_member = menuDao.getMemberAccount(member_no,
				password);

		return ref_member;
	}

}
