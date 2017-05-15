package th.co.pt.pcca.pccaapp.controller.util;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.xml.ws.http.HTTPException;

import org.slf4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import th.co.pt.pcca.pccaapp.classobject.CGlobal;
import th.co.pt.pcca.pccaapp.entities.util.DropDownCriteriaObj;
import th.co.pt.pcca.pccaapp.entities.util.DropDownObj;
import th.co.pt.pcca.pccaapp.helper.WebUtil;

@Controller
public class DropDownUtilController {
	
	@RequestMapping(value = "/util-getmemberfollower", method = RequestMethod.POST)
	public @ResponseBody List<DropDownObj> GetFollwer(HttpSession session) {
		String uri = WebUtil.WebServiceUrl() + "HrisService/util-getmemberfollower";
		DropDownCriteriaObj criteria =new DropDownCriteriaObj();
		criteria.setEmp_id(CGlobal.getC_UserInfo(session).getCodempid());
		criteria.setGu_id(CGlobal.getC_UserInfo(session).getGu_id());
		RestTemplate restTemplate = new RestTemplate();
		List<DropDownObj> result = restTemplate.postForObject(uri, criteria,List.class);
		DropDownObj user_default =new DropDownObj();
		user_default.ddl_value=CGlobal.getC_UserInfo(session).codempid;
		user_default.ddl_text=CGlobal.getC_UserInfo(session).codempid +" "+CGlobal.getC_UserInfo(session).namempt;
		result.add(0, user_default);
		return result;
	}
	
	@RequestMapping(value = "/util-getmemberfollower-all", method = RequestMethod.POST)
	public @ResponseBody List<DropDownObj> GetFollwerAll(HttpSession session) {
		String uri = WebUtil.WebServiceUrl() + "HrisService/util-getmemberfollower";
		DropDownCriteriaObj criteria =new DropDownCriteriaObj();
		criteria.setEmp_id(CGlobal.getC_UserInfo(session).getCodempid());
		criteria.setGu_id(CGlobal.getC_UserInfo(session).getGu_id());
		RestTemplate restTemplate = new RestTemplate();
		List<DropDownObj> result = restTemplate.postForObject(uri, criteria,List.class);
		DropDownObj user_default =new DropDownObj();
		user_default.ddl_value=CGlobal.getC_UserInfo(session).codempid;
		user_default.ddl_text=CGlobal.getC_UserInfo(session).codempid +" "+CGlobal.getC_UserInfo(session).namempt;
		DropDownObj user_all =new DropDownObj();
		user_all.ddl_value="ALL";
		user_all.ddl_text="ทั้งหมด";
		result.add(0, user_all);
		result.add(1, user_default);
		
		return result;
	}
	@RequestMapping(value = "/util-getmemberfollower-company", method = RequestMethod.POST)
	public @ResponseBody List<DropDownObj> GetFollwerAllCompany(@RequestBody DropDownCriteriaObj criteria,HttpSession session) {
		String uri = WebUtil.WebServiceUrl() + "HrisService/util-getmemberfollower";
		criteria.setEmp_id(CGlobal.getC_UserInfo(session).getCodempid());
		criteria.setGu_id(CGlobal.getC_UserInfo(session).getGu_id());
		RestTemplate restTemplate = new RestTemplate();
		List<DropDownObj> result = restTemplate.postForObject(uri, criteria,List.class);
		DropDownObj user_default =new DropDownObj();
		user_default.ddl_value=CGlobal.getC_UserInfo(session).codempid;
		user_default.ddl_text=CGlobal.getC_UserInfo(session).codempid +" "+CGlobal.getC_UserInfo(session).namempt;
		DropDownObj user_all =new DropDownObj();
		user_all.ddl_value="ALL";
		user_all.ddl_text="ทั้งหมด";
		result.add(0, user_all);
//		result.add(1, user_default);
		
		return result;
	}
	
	@RequestMapping(value = "/util-getmemberfollower-shifttime", method = RequestMethod.POST)
	public @ResponseBody List<DropDownObj> GetFollwerShiftime(@RequestBody DropDownCriteriaObj criteria,HttpSession session) {
		String uri = WebUtil.WebServiceUrl() + "HrisService/util-getmemberfollower";
		criteria.setEmp_id(CGlobal.getC_UserInfo(session).getCodempid());
		criteria.setGu_id(CGlobal.getC_UserInfo(session).getGu_id());
		RestTemplate restTemplate = new RestTemplate();
		List<DropDownObj> result = restTemplate.postForObject(uri, criteria,List.class);
//		DropDownObj user_default =new DropDownObj();
//		user_default.ddl_value=CGlobal.getC_UserInfo(session).codempid;
//		user_default.ddl_text=CGlobal.getC_UserInfo(session).codempid +" "+CGlobal.getC_UserInfo(session).namempt;
		DropDownObj user_all =new DropDownObj();
		user_all.ddl_value="ALL";
		user_all.ddl_text="ทั้งหมด";
		result.add(0, user_all);
//		result.add(1, user_default);
		
		return result;
	}
	
	@RequestMapping(value = "/util-getmemberfollower-default", method = RequestMethod.POST)
	public @ResponseBody List<DropDownObj> GetFollwerAllDefault(@RequestBody DropDownCriteriaObj criteria,HttpSession session) {
		List<DropDownObj> result = new ArrayList<DropDownObj>();
		DropDownObj user_default =new DropDownObj();
		user_default.ddl_value=CGlobal.getC_UserInfo(session).codempid;
		user_default.ddl_text=CGlobal.getC_UserInfo(session).codempid +" "+CGlobal.getC_UserInfo(session).namempt;
		DropDownObj user_all =new DropDownObj();
		user_all.ddl_value="ALL";
		user_all.ddl_text="ทั้งหมด";
		result.add(0, user_all);
		result.add(1, user_default);
		
		return result;
	}
	@RequestMapping(value = "/util-getworktimedoctype-all", method = RequestMethod.POST)
	public @ResponseBody List<DropDownObj> GetWorkTimeDocType(@RequestBody DropDownCriteriaObj criteria) {
		String uri = WebUtil.WebServiceUrl() + "HrisService/util-getworktimedoctype";
		RestTemplate restTemplate = new RestTemplate();
		List<DropDownObj> result = restTemplate.postForObject(uri,criteria,List.class);
		DropDownObj user_all =new DropDownObj();
		user_all.ddl_value="ALL";
		user_all.ddl_text="ทั้งหมด";
		result.add(0, user_all);
		return result;
	}
	
	@RequestMapping(value = "/util-getworktimetimecause", method = RequestMethod.POST)
	public @ResponseBody List<DropDownObj> GetWorkTimeTimeCause() {
		String uri = WebUtil.WebServiceUrl() + "HrisService/util-getworktimetimecause";
		RestTemplate restTemplate = new RestTemplate();
		List<DropDownObj> result = restTemplate.postForObject(uri,null,List.class);
		DropDownObj user_all =new DropDownObj();
		user_all.ddl_value="ALL";
		user_all.ddl_text="เลือก";
		result.add(0, user_all);
		return result;
	}
	@RequestMapping(value = "/util-getcompany", method = RequestMethod.POST)
	public @ResponseBody List<DropDownObj> GetCompany(HttpSession session) {
		String uri = WebUtil.WebServiceUrl() + "HrisService/util-getcompany";
		DropDownCriteriaObj criteria =new DropDownCriteriaObj();
		criteria.setEmp_id(CGlobal.getC_UserInfo(session).getCodempid());
		criteria.setGu_id(CGlobal.getC_UserInfo(session).getGu_id());
		RestTemplate restTemplate = new RestTemplate();
		List<DropDownObj> result = restTemplate.postForObject(uri, criteria,List.class);
		DropDownObj user_all =new DropDownObj();
		user_all.ddl_value="select";
		user_all.ddl_text="เลือก";
		result.add(0, user_all);
		
		return result;
	}
	
	@RequestMapping(value = "/util-getcompany2", method = RequestMethod.POST)
	public @ResponseBody List<DropDownObj> GetCompany2(HttpSession session) {
		String uri = WebUtil.WebServiceUrl() + "HrisService/util-getcompany";
		DropDownCriteriaObj criteria =new DropDownCriteriaObj();
		criteria.setEmp_id(CGlobal.getC_UserInfo(session).getCodempid());
		criteria.setGu_id(CGlobal.getC_UserInfo(session).getGu_id());
		RestTemplate restTemplate = new RestTemplate();
		List<DropDownObj> result = restTemplate.postForObject(uri, criteria,List.class);

		if(result.size()>1){
			DropDownObj user_all =new DropDownObj();
			user_all.ddl_value="select";
			user_all.ddl_text="เลือก";
			result.add(0, user_all);
		}
		return result;
	}
	
	@RequestMapping(value = "/util-getdocumentstatus", method = RequestMethod.POST)
	public @ResponseBody List<DropDownObj> GetDocumentStatus() {
		String uri = WebUtil.WebServiceUrl() + "HrisService/util-getdocumentstatus";
		RestTemplate restTemplate = new RestTemplate();
		List<DropDownObj> result = restTemplate.postForObject(uri, null,List.class);
		DropDownObj user_all =new DropDownObj();
		user_all.ddl_value="ALL";
		user_all.ddl_text="ทั้งหมด";
		result.add(0, user_all);
		return result;
	}
	
	@RequestMapping(value = "/report-getcompany", method = RequestMethod.POST)
	public @ResponseBody List<DropDownObj> reportGetCompany(HttpSession session) {
		String uri = WebUtil.WebServiceUrl() + "HrisService/report-getcompany";
		DropDownCriteriaObj criteria =new DropDownCriteriaObj();
		criteria.setEmp_id(CGlobal.getC_UserInfo(session).getCodempid());
		criteria.setGu_id(CGlobal.getC_UserInfo(session).getGu_id());
		criteria.setNumminlvl(CGlobal.getC_UserInfo(session).getNumminlvl());
		RestTemplate restTemplate = new RestTemplate();
		List<DropDownObj> result = restTemplate.postForObject(uri, criteria,List.class);
		DropDownObj user_all =new DropDownObj();
		if(criteria.getNumminlvl()>9){
			user_all.ddl_value="select";
			user_all.ddl_text="เลือก";
			result.add(0, user_all);
		}
		return result;
	}
	
	@RequestMapping(value = "/report-getparty", method = RequestMethod.POST)
	public @ResponseBody List<DropDownObj> reportGetParty(@RequestBody DropDownCriteriaObj criteria,HttpSession session) {
		String uri = WebUtil.WebServiceUrl() + "HrisService/report-getparty";
//		DropDownCriteriaObj criteria =new DropDownCriteriaObj();
		criteria.setEmp_id(CGlobal.getC_UserInfo(session).getCodempid());
		criteria.setCompany(criteria.getCompany());
		criteria.setComp1(criteria.getComp1());
		criteria.setGu_id(CGlobal.getC_UserInfo(session).getGu_id());
		criteria.setNumminlvl(CGlobal.getC_UserInfo(session).getNumminlvl());
		RestTemplate restTemplate = new RestTemplate();
		List<DropDownObj> result = restTemplate.postForObject(uri, criteria,List.class);
		if(criteria.getNumminlvl()>9){
			DropDownObj user_all =new DropDownObj();
			user_all.ddl_value="select";
			user_all.ddl_text="เลือก";
			result.add(0, user_all);
		}   
		System.out.println("get comp4 >> "+result.size());
		return result;
	}
	
	@RequestMapping(value = "/report-getsection", method = RequestMethod.POST)
	public @ResponseBody List<DropDownObj> reportGetSection(@RequestBody DropDownCriteriaObj criteria,HttpSession session) {
		String uri = WebUtil.WebServiceUrl() + "HrisService/report-getsection";
//		DropDownCriteriaObj criteria =new DropDownCriteriaObj();
		criteria.setEmp_id(CGlobal.getC_UserInfo(session).getCodempid());
		criteria.setCompany(criteria.getCompany());
		criteria.setComp1(criteria.getComp1());
		criteria.setComp4(criteria.getComp4());	
		criteria.setGu_id(CGlobal.getC_UserInfo(session).getGu_id());
		criteria.setNumminlvl(CGlobal.getC_UserInfo(session).getNumminlvl());
		RestTemplate restTemplate = new RestTemplate();
		List<DropDownObj> result = restTemplate.postForObject(uri, criteria,List.class);
		if(criteria.getNumminlvl()>9){
			DropDownObj user_all =new DropDownObj();
			user_all.ddl_value="select";
			user_all.ddl_text="เลือก";
			result.add(0, user_all);
		}  
		return result;
	}
	
	@RequestMapping(value = "/report-getdepartment", method = RequestMethod.POST)
	public @ResponseBody List<DropDownObj> reportGetDepartment(@RequestBody DropDownCriteriaObj criteria,HttpSession session) {
		String uri = WebUtil.WebServiceUrl() + "HrisService/report-getdepartment";
		criteria.setEmp_id(CGlobal.getC_UserInfo(session).getCodempid());
		criteria.setCompany(criteria.getCompany());
		criteria.setComp1(criteria.getComp1());
		criteria.setComp4(criteria.getComp4());
		criteria.setComp5(criteria.getComp5());	
		criteria.setGu_id(CGlobal.getC_UserInfo(session).getGu_id());
		criteria.setNumminlvl(CGlobal.getC_UserInfo(session).getNumminlvl());
		RestTemplate restTemplate = new RestTemplate();
		List<DropDownObj> result = restTemplate.postForObject(uri, criteria,List.class);
		if(criteria.getNumminlvl()>9){
			DropDownObj user_all =new DropDownObj();
			user_all.ddl_value="select";
			user_all.ddl_text="เลือก";
			result.add(0, user_all);
		}
		return result;
	}
	
	
	@RequestMapping(value = "/report-getbranch", method = RequestMethod.POST)
	public @ResponseBody List<DropDownObj> reportGetBranch(@RequestBody DropDownCriteriaObj criteria, HttpSession session) {
		String uri = WebUtil.WebServiceUrl() + "HrisService/report-getbranch";
//		DropDownCriteriaObj criteria =new DropDownCriteriaObj();
		criteria.setEmp_id(CGlobal.getC_UserInfo(session).getCodempid());
		criteria.setCompany(criteria.getCompany());
		criteria.setComp1(criteria.getComp1());
		criteria.setComp4(criteria.getComp4());
		criteria.setComp5(criteria.getComp5());	
		criteria.setComp6(criteria.getComp6());	
		criteria.setGu_id(CGlobal.getC_UserInfo(session).getGu_id());
		criteria.setNumminlvl(CGlobal.getC_UserInfo(session).getNumminlvl());
		RestTemplate restTemplate = new RestTemplate();
		List<DropDownObj> result = restTemplate.postForObject(uri, criteria,List.class);
		if(criteria.getNumminlvl()>9){
			DropDownObj user_all =new DropDownObj();
			user_all.ddl_value="select";
			user_all.ddl_text="เลือก";
			result.add(0, user_all);
		}	
		return result;
	}
	
	@RequestMapping(value = "/report-getmemberfollower-company", method = RequestMethod.POST)
	public @ResponseBody List<DropDownObj> reportGetEmp(@RequestBody DropDownCriteriaObj criteria, HttpSession session) {
		String uri = WebUtil.WebServiceUrl() + "HrisService/report-getmemberfollower-company";
//		DropDownCriteriaObj criteria =new DropDownCriteriaObj();
		criteria.setEmp_id(CGlobal.getC_UserInfo(session).getCodempid());
		criteria.setComp1(criteria.getComp1());
		criteria.setComp4(criteria.getComp4());
		criteria.setComp5(criteria.getComp5());	
		criteria.setComp6(criteria.getComp6());
		criteria.setComp7(criteria.getComp7());
		criteria.setGu_id(CGlobal.getC_UserInfo(session).getGu_id());
		criteria.setNumminlvl(CGlobal.getC_UserInfo(session).getNumminlvl());
		String guID = CGlobal.getC_UserInfo(session).getGu_id();
		String comp = CGlobal.getC_UserInfo(session).getCodcomp();
		RestTemplate restTemplate = new RestTemplate();
		List<DropDownObj> result = restTemplate.postForObject(uri, criteria,List.class);
		DropDownObj user_default =new DropDownObj();
		user_default.ddl_value=CGlobal.getC_UserInfo(session).codempid;
		user_default.ddl_text=CGlobal.getC_UserInfo(session).codempid +" "+CGlobal.getC_UserInfo(session).namempt;
		DropDownObj user_all =new DropDownObj();
		user_all.ddl_value="ALL";
		user_all.ddl_text="ทั้งหมด";
		result.add(0, user_all);
		if(!"0005".equals(guID)){
			result.add(1, user_default);
		}
		
		return result;
	}
	
	@RequestMapping(value = "/report-getcompany-R02", method = RequestMethod.POST)
	public @ResponseBody List<DropDownObj> reportGetCompanyR02(HttpSession session) {
		String uri = WebUtil.WebServiceUrl() + "HrisService/report-getcompany";
		DropDownCriteriaObj criteria =new DropDownCriteriaObj();
		criteria.setEmp_id(CGlobal.getC_UserInfo(session).getCodempid());
		criteria.setGu_id(CGlobal.getC_UserInfo(session).getGu_id());		
		criteria.setNumminlvl(CGlobal.getC_UserInfo(session).getNumminlvl());
		RestTemplate restTemplate = new RestTemplate();
		List<DropDownObj> result = restTemplate.postForObject(uri, criteria,List.class);
		
		DropDownObj user_all =new DropDownObj();
		user_all.ddl_value="select";
		user_all.ddl_text="เลือก";
		result.add(0, user_all);
		
		return result;
	}
	
	@RequestMapping(value = "/report-getparty-R02", method = RequestMethod.POST)
	public @ResponseBody List<DropDownObj> reportGetPartyR02(@RequestBody DropDownCriteriaObj criteria,HttpSession session) {
		String uri = WebUtil.WebServiceUrl() + "HrisService/report-getparty";
//		DropDownCriteriaObj criteria =new DropDownCriteriaObj();
		criteria.setEmp_id(CGlobal.getC_UserInfo(session).getCodempid());
		criteria.setComp1(criteria.getComp1());
		criteria.setGu_id(CGlobal.getC_UserInfo(session).getGu_id());
		criteria.setNumminlvl(CGlobal.getC_UserInfo(session).getNumminlvl());
		RestTemplate restTemplate = new RestTemplate();
		List<DropDownObj> result = restTemplate.postForObject(uri, criteria,List.class);
		String guid = CGlobal.getC_UserInfo(session).getGu_id();
		if(guid.equals("0005")||criteria.getNumminlvl()>9){
			DropDownObj user_all =new DropDownObj();
			user_all.ddl_value="000";
			user_all.ddl_text="เลือก";
			result.add(0, user_all);  
		}
		return result;
	}
	
	@RequestMapping(value = "/report-getsection-R02", method = RequestMethod.POST)
	public @ResponseBody List<DropDownObj> reportGetSectionR02(@RequestBody DropDownCriteriaObj criteria,HttpSession session) {
		String uri = WebUtil.WebServiceUrl() + "HrisService/report-getsection";
//		DropDownCriteriaObj criteria =new DropDownCriteriaObj();
		criteria.setEmp_id(CGlobal.getC_UserInfo(session).getCodempid());
		criteria.setComp1(criteria.getComp1());
		criteria.setComp4(criteria.getComp4());	
		criteria.setGu_id(CGlobal.getC_UserInfo(session).getGu_id());
		criteria.setNumminlvl(CGlobal.getC_UserInfo(session).getNumminlvl());
		RestTemplate restTemplate = new RestTemplate();
		List<DropDownObj> result = restTemplate.postForObject(uri, criteria,List.class);
		String guid = CGlobal.getC_UserInfo(session).getGu_id();
		if(guid.equals("0005")||criteria.getNumminlvl()>9){
			DropDownObj user_all =new DropDownObj();
			user_all.ddl_value="000";
			user_all.ddl_text="เลือก";
			result.add(0, user_all);
		}
		return result;
	}
	
	@RequestMapping(value = "/report-getdepartment-R02", method = RequestMethod.POST)
	public @ResponseBody List<DropDownObj> reportGetDepartmentR02(@RequestBody DropDownCriteriaObj criteria,HttpSession session) {
		String uri = WebUtil.WebServiceUrl() + "HrisService/report-getdepartment";
		criteria.setEmp_id(CGlobal.getC_UserInfo(session).getCodempid());
		criteria.setComp1(criteria.getComp1());
		criteria.setComp4(criteria.getComp4());
		criteria.setComp5(criteria.getComp5());	
		criteria.setGu_id(CGlobal.getC_UserInfo(session).getGu_id());
		criteria.setNumminlvl(CGlobal.getC_UserInfo(session).getNumminlvl());
		RestTemplate restTemplate = new RestTemplate();
		List<DropDownObj> result = restTemplate.postForObject(uri, criteria,List.class);
		String guid = CGlobal.getC_UserInfo(session).getGu_id();
		if(guid.equals("0005")||criteria.getNumminlvl()>9){
			DropDownObj user_all =new DropDownObj();
			user_all.ddl_value="000";
			user_all.ddl_text="เลือก";
			result.add(0, user_all);
		}
		return result;
	}
	
	
	@RequestMapping(value = "/report-getbranch-R02", method = RequestMethod.POST)
	public @ResponseBody List<DropDownObj> reportGetBranchR02(@RequestBody DropDownCriteriaObj criteria, HttpSession session) {
		String uri = WebUtil.WebServiceUrl() + "HrisService/report-getbranch";
//		DropDownCriteriaObj criteria =new DropDownCriteriaObj();
		criteria.setEmp_id(CGlobal.getC_UserInfo(session).getCodempid());
		criteria.setComp1(criteria.getComp1());
		criteria.setComp4(criteria.getComp4());
		criteria.setComp5(criteria.getComp5());	
		criteria.setComp6(criteria.getComp6());	
		criteria.setGu_id(CGlobal.getC_UserInfo(session).getGu_id());
		criteria.setNumminlvl(CGlobal.getC_UserInfo(session).getNumminlvl());
		RestTemplate restTemplate = new RestTemplate();
		List<DropDownObj> result = restTemplate.postForObject(uri, criteria,List.class);
		String guid = CGlobal.getC_UserInfo(session).getGu_id();
		if(guid.equals("0005")||criteria.getNumminlvl()>9){
			DropDownObj user_all =new DropDownObj();
			user_all.ddl_value="000";
			user_all.ddl_text="เลือก";
			result.add(0, user_all);
		}
		return result;
	}
	
	@RequestMapping(value = "/report-getmemberfollower-company-R02", method = RequestMethod.POST)
	public @ResponseBody List<DropDownObj> reportGetEmpR02(@RequestBody DropDownCriteriaObj criteria, HttpSession session) {
		String uri = WebUtil.WebServiceUrl() + "HrisService/report-getmemberfollower-company";
//		DropDownCriteriaObj criteria =new DropDownCriteriaObj();
		criteria.setEmp_id(CGlobal.getC_UserInfo(session).getCodempid());
		criteria.setComp1(criteria.getComp1());
		criteria.setComp4(criteria.getComp4());
		criteria.setComp5(criteria.getComp5());	
		criteria.setComp6(criteria.getComp6());
		criteria.setComp7(criteria.getComp7());
		criteria.setGu_id(CGlobal.getC_UserInfo(session).getGu_id());
		criteria.setNumminlvl(CGlobal.getC_UserInfo(session).getNumminlvl());
		String guID = CGlobal.getC_UserInfo(session).getGu_id();
		String comp = CGlobal.getC_UserInfo(session).getCodcomp();
		RestTemplate restTemplate = new RestTemplate();
		List<DropDownObj> result = restTemplate.postForObject(uri, criteria,List.class);
		DropDownObj user_default =new DropDownObj();
		user_default.ddl_value=CGlobal.getC_UserInfo(session).codempid;
		user_default.ddl_text=CGlobal.getC_UserInfo(session).codempid +" "+CGlobal.getC_UserInfo(session).namempt;
		DropDownObj user_all =new DropDownObj();
		user_all.ddl_value="ALL";
		user_all.ddl_text="ทั้งหมด";
		result.add(0, user_all);
		if(!"0005".equals(guID)||criteria.getNumminlvl()>=10){
			result.add(1, user_default);
		}
	
		return result;
	}
	
	 @RequestMapping(value = "/util-workflow-service", method = RequestMethod.POST)
	 public @ResponseBody List<DropDownObj> workFlowService(@RequestBody DropDownCriteriaObj criteria,HttpSession session) throws HTTPException, IOException {
		 try
		 {
			 List<DropDownObj> result = null;
			 String uri = WebUtil.WebServiceUrl() + "HrisService/util-workflow-service";
			 RestTemplate restTemplate = new RestTemplate();
			 criteria.setEmp_id(CGlobal.getC_UserInfo(session).getCodempid());
			 if(session.getAttribute("util-workflow-service")!=null){
				 result = (List<DropDownObj>)session.getAttribute("util-workflow-service");
			 }else{
				 result = restTemplate.postForObject(uri, criteria,List.class);
				 session.setAttribute("util-workflow-service", result); 
			 }
			 return result;
		 }
		 catch(Exception ex)
		 {
			 throw new HTTPException(404);
		 }
	 }
	 
	 @RequestMapping(value = "/util-menu-item", method = RequestMethod.POST)
	 public @ResponseBody List<DropDownObj> findMenuItem(@RequestBody DropDownCriteriaObj criteria,HttpSession session) throws HTTPException, IOException {
		 try
		 {
			 List<DropDownObj> result = null;
			 String uri = WebUtil.WebServiceUrl() + "HrisService/util-menu-item";
			 RestTemplate restTemplate = new RestTemplate();
			 criteria.setEmp_id(CGlobal.getC_UserInfo(session).getCodempid());
			 if(session.getAttribute("util-menu-item")!=null){
				 result = (List<DropDownObj>)session.getAttribute("util-menu-item");
			 }else{				 
				 result = restTemplate.postForObject(uri, criteria,List.class);
				 session.setAttribute("util-menu-item", result); 
			 }
			 return result;
		 }
		 catch(Exception ex)
		 {
			 throw new HTTPException(404);
		 }
	 }
	 
	 @RequestMapping(value = "/util-getalll-member", method = RequestMethod.POST)
	 public @ResponseBody List<DropDownObj> findgetalllmember(@RequestBody DropDownCriteriaObj criteria,HttpSession session) throws HTTPException, IOException {
		 try
		 {
			 List<DropDownObj> result = null;
			 String uri = WebUtil.WebServiceUrl() + "HrisService/util-getalll-member";
			 RestTemplate restTemplate = new RestTemplate();
			 criteria.setEmp_id(CGlobal.getC_UserInfo(session).getCodempid());
			 if(session.getAttribute("util-getalll-member")!=null){
				 result = (List<DropDownObj>)session.getAttribute("util-getalll-member");
			 }else{				 
				 result = restTemplate.postForObject(uri, criteria,List.class);
				 session.setAttribute("util-getalll-member", result); 
			 }
			 return result;
		 }
		 catch(Exception ex)
		 {
			 throw new HTTPException(404);
		 }
	 }
	 
	 
	 @RequestMapping(value = "/report-getEmpBySearch", method = RequestMethod.POST)
		public @ResponseBody List<Map<String , Object>> GetEmpBySearch(@RequestParam String emp) {
		 	Map<String , Object> map = new HashMap<>();
		 	map.put("emp", emp);
			String uri = WebUtil.WebServiceUrl() + "HrisService/report-getEmpBySearch";
			RestTemplate restTemplate = new RestTemplate();
			List<Map<String , Object>> result = restTemplate.postForObject(uri,map,List.class);
//			DropDownObj user_all =new DropDownObj();
//			user_all.ddl_value="ALL";
//			user_all.ddl_text="เลือก";
//			result.add(0, user_all);
			return result;
		}
	 
	 @RequestMapping(value = "/report-getBranchBySearch", method = RequestMethod.POST)
		public @ResponseBody List<Map<String , Object>> GetBranchmpBySearch(@RequestParam String branch) {
		 	Map<String , Object> map = new HashMap<>();
		 	map.put("branch", branch);
			String uri = WebUtil.WebServiceUrl() + "HrisService/report-getBranchBySearch";
			RestTemplate restTemplate = new RestTemplate();
			List<Map<String , Object>> result = restTemplate.postForObject(uri,map,List.class);
//			DropDownObj user_all =new DropDownObj();
//			user_all.ddl_value="ALL";
//			user_all.ddl_text="เลือก";
//			result.add(0, user_all);
			return result;
		}
	 
	 @RequestMapping(value = "/report-getEmpByBranch", method = RequestMethod.POST)
		public @ResponseBody List<Map<String , Object>> GetEmpByBranch(@RequestParam String branch) {
		 	Map<String , Object> map = new HashMap<>();
		 	map.put("branch", branch);
			String uri = WebUtil.WebServiceUrl() + "HrisService/report-getEmpByBranch";
			RestTemplate restTemplate = new RestTemplate();
			List<Map<String , Object>> result = restTemplate.postForObject(uri,map,List.class);
			return result;
		}
}
