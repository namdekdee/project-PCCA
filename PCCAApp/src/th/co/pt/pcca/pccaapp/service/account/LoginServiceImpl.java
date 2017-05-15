package th.co.pt.pcca.pccaapp.service.account;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import th.co.pt.pcca.pccaapp.classobject.CGlobal;
import th.co.pt.pcca.pccaapp.entities.account.MainMenuObj;
import th.co.pt.pcca.pccaapp.entities.member.MemberObj;
@Repository("loginService")
public class LoginServiceImpl implements LoginService {
	public Boolean InitMember(MemberObj ref_member,HttpSession session) {
		Boolean success = false;
		if(ref_member != null)
		 { 
			
			//CGlobal.setC_UserInfo(ref_member);
            // CGlobal.C_UserInfo.codempid = ref_member.codempid;
            // CGlobal.C_UserInfo.password = ref_member.password;
             MainMenuObj home = new MainMenuObj();
             home.app_path ="home";
             home.app_desc="หน้าแรก";
             home.app_head_desc= "";
             home.app_desc_en="Home";
             home.app_head_desc_en= "";
             MainMenuObj error = new MainMenuObj();
             error.app_path ="error";
             error.app_desc="หน้าแรก";
             error.app_head_desc= "";
             error.app_desc_en="Home";
             error.app_head_desc_en= "";
             ref_member.mainmenu.add(home);
             ref_member.mainmenu.add(error);
             //CGlobal.C_UserInfo.mainmenu.add(home);
             //CGlobal.C_UserInfo.mainmenu.add(error);
             success = true;
             CGlobal.setC_UserInfo(ref_member, session);

         }
         else
         {
        	 CGlobal.setC_UserInfo(null, session);
         }
		
		
		return success;
	}
	
}
