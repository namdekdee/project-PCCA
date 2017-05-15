package th.co.pt.pcca.pccaservice.dao.ca;

import th.co.pt.pcca.pccaservice.entities.account.MemberAccountObj;
import th.co.pt.pcca.pccaservice.entities.member.MemberObj;

public interface MenuCaDao {
	MemberObj GetUserPermiss(String member_no, String password);
	MemberObj GetUserPms(String member_no, String password);
	MemberAccountObj getMemberAccount(String userId,String password);
}
