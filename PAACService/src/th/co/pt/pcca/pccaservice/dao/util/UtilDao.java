package th.co.pt.pcca.pccaservice.dao.util;

import java.util.List;
import java.util.Map;

import th.co.pt.pcca.pccaservice.entities.util.DropDownCriteriaObj;
import th.co.pt.pcca.pccaservice.entities.util.DropDownObj;

public interface UtilDao {
	List<DropDownObj> GetMemberFollower(DropDownCriteriaObj criteria);
	List<DropDownObj> GetWorkTimeDocType(DropDownCriteriaObj criteria);
	List<DropDownObj> GetWorkTimeTimeCause();
	List<DropDownObj> GetCompany(DropDownCriteriaObj criteria);
	List<DropDownObj> GetDocumentStatus();
	
	
	List<DropDownObj> findCompany(DropDownCriteriaObj criteria);
	List<DropDownObj> findParty(DropDownCriteriaObj criteria);
	List<DropDownObj> findSection(DropDownCriteriaObj criteria);
	List<DropDownObj> findDepartment(DropDownCriteriaObj criteria);
	List<DropDownObj> findBranch(DropDownCriteriaObj criteria);
	List<DropDownObj> findEmp(DropDownCriteriaObj criteria);
	List<DropDownObj> findWorkFlowService(DropDownCriteriaObj criteria);
	List<DropDownObj> findMenuItem(DropDownCriteriaObj criteria);
	List<DropDownObj> findAllmember(DropDownCriteriaObj criteria);
	List<Map<String , Object>> getEmpBySearch(Map<String , Object> map);
	List<Map<String , Object>> getBranchBySearch(Map<String , Object> map);
	List<Map<String , Object>> getEmpByBranch(Map<String , Object> map);
}
