package th.co.pt.pcca.pccaapp.service.account;

import javax.servlet.http.HttpSession;

import th.co.pt.pcca.pccaapp.entities.member.MemberObj;

public interface LoginService {
	Boolean InitMember(MemberObj ref_member,HttpSession session);
}
