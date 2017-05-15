package th.co.pt.pcca.pccaservice.controller.util;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.xml.ws.http.HTTPException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import th.co.pt.pcca.pccaservice.entities.util.DropDownCriteriaObj;
import th.co.pt.pcca.pccaservice.entities.util.DropDownObj;
import th.co.pt.pcca.pccaservice.entities.workflow.StepWorkFlowCriteriaObj;
import th.co.pt.pcca.pccaservice.entities.workflow.StepWorkFlowTransactionObj;
import th.co.pt.pcca.pccaservice.service.util.UtilService;
import th.co.pt.pcca.pccaservice.service.workflow.TransactionService;

@Controller
public class ApiUtilController {
	@Autowired
	private UtilService utilService;
	
	 @RequestMapping(value = "/util-getmemberfollower", method = RequestMethod.POST)
	    @ResponseBody
	    public List<DropDownObj> getMemberFollower( @RequestBody DropDownCriteriaObj criteria) throws HTTPException, IOException {
		 
		 try
		 {
	        return utilService.GetMemberFollower(criteria);
		 }
		 catch(Exception ex)
		 {
			 throw new HTTPException(404);
		 }
	 }
	 @RequestMapping(value = "/util-getworktimedoctype", method = RequestMethod.POST)
	    @ResponseBody
	    public List<DropDownObj> getWorkTimeDocType(@RequestBody DropDownCriteriaObj criteria) throws HTTPException, IOException {
		 
		 try
		 {
	        return utilService.GetWorkTimeDocType(criteria);
		 }
		 catch(Exception ex)
		 {
			 throw new HTTPException(404);
		 }
	 }
	 
	 @RequestMapping(value = "/util-getworktimetimecause", method = RequestMethod.POST)
	    @ResponseBody
	    public List<DropDownObj> getWorkTimeTimeCause( ) throws HTTPException, IOException {
		 
		 try
		 {
	        return utilService.GetWorkTimeTimeCause();
		 }
		 catch(Exception ex)
		 {
			 throw new HTTPException(404);
		 }
	 }
	 @RequestMapping(value = "/util-getcompany", method = RequestMethod.POST)
	    @ResponseBody
	    public List<DropDownObj> getCompany( @RequestBody DropDownCriteriaObj criteria) throws HTTPException, IOException {
		 
		 try
		 {
	        return utilService.GetCompany(criteria);
		 }
		 catch(Exception ex)
		 {
			 throw new HTTPException(404);
		 }
	 }
	 @RequestMapping(value = "/util-getdocumentstatus", method = RequestMethod.POST)
	    @ResponseBody
	    public List<DropDownObj> getDocumentStatus( ) throws HTTPException, IOException {
		 
		 try
		 {
	        return utilService.GetDocumentStatus();
		 }
		 catch(Exception ex)
		 {
			 throw new HTTPException(404);
		 }
	 }
	 	 
	 @RequestMapping(value = "/report-getcompany", method = RequestMethod.POST)
	    @ResponseBody
	    public List<DropDownObj> reportGetCompany( @RequestBody DropDownCriteriaObj criteria) throws HTTPException, IOException {
		 
		 try
		 {
	        return utilService.findCompany(criteria);
		 }
		 catch(Exception ex)
		 {
			 throw new HTTPException(404);
		 }
	 }
	 
	 @RequestMapping(value = "/report-getparty", method = RequestMethod.POST)
	    @ResponseBody
	    public List<DropDownObj> reportGetParty( @RequestBody DropDownCriteriaObj criteria) throws HTTPException, IOException {
		 
		 try
		 {
	        return utilService.findParty(criteria);
		 }
		 catch(Exception ex)
		 {
			 throw new HTTPException(404);
		 }
	 }
	 
	 @RequestMapping(value = "/report-getsection", method = RequestMethod.POST)
	    @ResponseBody
	    public List<DropDownObj> reportGetSection( @RequestBody DropDownCriteriaObj criteria) throws HTTPException, IOException {
		 
		 try
		 {
	        return utilService.findSection(criteria);
		 }
		 catch(Exception ex)
		 {
			 throw new HTTPException(404);
		 }
	 }
	 
	 @RequestMapping(value = "/report-getdepartment", method = RequestMethod.POST)
	    @ResponseBody
	    public List<DropDownObj> reportGetDepartment( @RequestBody DropDownCriteriaObj criteria) throws HTTPException, IOException {
		 
		 try
		 {
	        return utilService.findDepartment(criteria);
		 }
		 catch(Exception ex)
		 {
			 throw new HTTPException(404);
		 }
	 }
	 
	 @RequestMapping(value = "/report-getbranch", method = RequestMethod.POST)
	    @ResponseBody
	    public List<DropDownObj> reportGetBranch( @RequestBody DropDownCriteriaObj criteria) throws HTTPException, IOException {
		 
		 try
		 {
	        return utilService.findBranch(criteria);
		 }
		 catch(Exception ex)
		 {
			 throw new HTTPException(404);
		 }
	 }
	 
	 @RequestMapping(value = "/report-getmemberfollower-company", method = RequestMethod.POST)
	    @ResponseBody
	    public List<DropDownObj> reportGetMember( @RequestBody DropDownCriteriaObj criteria) throws HTTPException, IOException {
		 
		 try
		 {
//			 return utilService.GetMemberFollower(criteria);
			 return utilService.findEmp(criteria);
		 }
		 catch(Exception ex)
		 {
			 throw new HTTPException(404);
		 }
	 }
	 
	 @RequestMapping(value = "/util-workflow-service", method = RequestMethod.POST)
	    @ResponseBody
	    public List<DropDownObj> findWorkFlowService( @RequestBody DropDownCriteriaObj criteria) throws HTTPException, IOException {
		 try
		 {
			 return utilService.findWorkFlowService(criteria);
		 }
		 catch(Exception ex)
		 {
			 throw new HTTPException(404);
		 }
	 }
	 
	 @RequestMapping(value = "/util-menu-item", method = RequestMethod.POST)
	    @ResponseBody
	    public List<DropDownObj> findMenuItem( @RequestBody DropDownCriteriaObj criteria) throws HTTPException, IOException {
		 try
		 {
			 return utilService.findMenuItem(criteria);
		 }
		 catch(Exception ex)
		 {
			 throw new HTTPException(404);
		 }
	 }
	 
	 @RequestMapping(value = "/util-getalll-member", method = RequestMethod.POST)
	    @ResponseBody
	    public List<DropDownObj> findAllmember( @RequestBody DropDownCriteriaObj criteria) throws HTTPException, IOException {
		 try
		 {
			 return utilService.findAllmember(criteria);
		 }
		 catch(Exception ex)
		 {
			 throw new HTTPException(404);
		 }
	 }
	 
	 @RequestMapping(value = "/report-getEmpBySearch", method = RequestMethod.POST)
	    @ResponseBody
	    public List<Map<String , Object>> getEmpBySearch( @RequestBody Map<String , Object> map) throws HTTPException, IOException {
		 try
		 { 
			 return utilService.getEmpBySearch(map);
		 }
		 catch(Exception ex)
		 {
			 throw new HTTPException(404);
		 }
	 }
	 
	 @RequestMapping(value = "/report-getBranchBySearch", method = RequestMethod.POST)
	    @ResponseBody
	    public List<Map<String , Object>> getBranchBySearch( @RequestBody Map<String , Object> map) throws HTTPException, IOException {
		 try
		 { 
			 return utilService.getBranchBySearch(map);
		 }
		 catch(Exception ex)
		 {
			 throw new HTTPException(404);
		 }
	 }
	 
	 @RequestMapping(value = "/report-getEmpByBranch", method = RequestMethod.POST)
	    @ResponseBody
	    public List<Map<String , Object>> getEmpByBranch( @RequestBody Map<String , Object> map) throws HTTPException, IOException {
		 try
		 { 
			 return utilService.getEmpByBranch(map);
		 }
		 catch(Exception ex)
		 {
			 throw new HTTPException(404);
		 }
	 }

}
