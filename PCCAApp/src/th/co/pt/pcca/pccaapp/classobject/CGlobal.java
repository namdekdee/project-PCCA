package th.co.pt.pcca.pccaapp.classobject;

import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import th.co.pt.pcca.pccaapp.entities.member.MemberObj;
import th.co.pt.pcca.pccaapp.helper.WebUtil;

public class CGlobal {
	private static  MemberObj C_UserInfo;

	public static  MemberObj getC_UserInfo(HttpSession session) {
		C_UserInfo=(MemberObj)session.getAttribute("C_UserInfo");
		return C_UserInfo;
	}

	public static void setC_UserInfo(MemberObj c_UserInfo,HttpSession session) {
		session.setAttribute("C_UserInfo", c_UserInfo);
		//C_UserInfo = c_UserInfo;
	}


	
//	public static MemberObj getC_UserInfo() {
//		C_UserInfo=(MemberObj)WebUtil.session().getAttribute("C_UserInfo");
//		return C_UserInfo;
//	}
//	public static void setC_UserInfo(MemberObj c_UserInfo) {
//      WebUtil.session().setAttribute("C_UserInfo" , c_UserInfo);
//		C_UserInfo = c_UserInfo;
//};
	
}
