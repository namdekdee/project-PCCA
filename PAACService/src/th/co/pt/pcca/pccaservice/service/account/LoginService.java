package th.co.pt.pcca.pccaservice.service.account;

import th.co.pt.pcca.pccaservice.entities.account.MemberAccountObj;
import th.co.pt.pcca.pccaservice.entities.member.MemberObj;

public interface LoginService {
	Boolean InitMember(String member_no,String password);
	MemberObj GetUserMenu(String member_no, String password);
	MemberObj GetMember(String member_no, String password);
	MemberObj GetMemberPms(String member_no, String password);
	MemberAccountObj GetMemberAccount(String member_no, String password);
	
	MemberObj GetMemberCA(String member_no, String password);
}
