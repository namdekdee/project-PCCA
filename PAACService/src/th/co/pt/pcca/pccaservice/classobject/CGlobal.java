package th.co.pt.pcca.pccaservice.classobject;

import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import th.co.pt.pcca.pccaservice.entities.member.MemberObj;
import th.co.pt.pcca.pccaservice.helper.WebUtil;

public class CGlobal {
	public static MemberObj C_UserInfo;

	public static MemberObj getC_UserInfo() {
		C_UserInfo=(MemberObj)WebUtil.session().getAttribute("C_UserInfo");
		return C_UserInfo;
	}
	public static void setC_UserInfo(MemberObj c_UserInfo) {
      WebUtil.session().setAttribute("C_UserInfo" , c_UserInfo);
		C_UserInfo = c_UserInfo;
	};
	
}
