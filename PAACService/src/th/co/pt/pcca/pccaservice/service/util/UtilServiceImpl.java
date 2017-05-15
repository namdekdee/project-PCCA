package th.co.pt.pcca.pccaservice.service.util;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import th.co.pt.pcca.pccaservice.dao.util.UtilDao;
import th.co.pt.pcca.pccaservice.entities.util.DropDownCriteriaObj;
import th.co.pt.pcca.pccaservice.entities.util.DropDownObj;
@Service("utilService")
public class UtilServiceImpl implements UtilService {
	@Autowired
	private UtilDao utilDao;
	
	public List<DropDownObj> GetMemberFollower(DropDownCriteriaObj criteria) {
		return utilDao.GetMemberFollower(criteria);
	}
	public List<DropDownObj> GetWorkTimeDocType(DropDownCriteriaObj criteria) {
		return utilDao.GetWorkTimeDocType(criteria);
	}
	public List<DropDownObj> GetWorkTimeTimeCause() {
		return utilDao.GetWorkTimeTimeCause();
	}
	public List<DropDownObj> GetCompany(DropDownCriteriaObj criteria) {
		return utilDao.GetCompany(criteria);
	}
	public List<DropDownObj> GetDocumentStatus() {
		return utilDao.GetDocumentStatus();
	}
	
	
	public List<DropDownObj> findCompany(DropDownCriteriaObj criteria){
		return utilDao.findCompany(criteria);
	}
	
	public List<DropDownObj> findParty(DropDownCriteriaObj criteria){
		return utilDao.findParty(criteria);
	}
	public List<DropDownObj> findSection(DropDownCriteriaObj criteria){
		return utilDao.findSection(criteria);
	}
	public List<DropDownObj> findDepartment(DropDownCriteriaObj criteria){
		return utilDao.findDepartment(criteria);
	}
	public List<DropDownObj> findBranch(DropDownCriteriaObj criteria){
		return utilDao.findBranch(criteria);
	}
	public List<DropDownObj> findEmp(DropDownCriteriaObj criteria){
		return utilDao.findEmp(criteria);
	}
	@Override
	public List<DropDownObj> findWorkFlowService(DropDownCriteriaObj criteria) {
		return utilDao.findWorkFlowService(criteria);
	}
	@Override
	public List<DropDownObj> findMenuItem(DropDownCriteriaObj criteria) {
		return utilDao.findMenuItem(criteria);
	}
	@Override
	public List<DropDownObj> findAllmember(DropDownCriteriaObj criteria) {
		return utilDao.findAllmember(criteria);
	}
	@Override
	public List<Map<String , Object>> getEmpBySearch(Map<String , Object> map){
		return utilDao.getEmpBySearch(map);
	}
	@Override
	public List<Map<String , Object>> getBranchBySearch(Map<String , Object> map){
		return utilDao.getBranchBySearch(map);
	}
	
	@Override
	public List<Map<String , Object>> getEmpByBranch(Map<String , Object> map){
		return utilDao.getEmpByBranch(map);
	}
}
