package th.co.pt.pcca.pccaapp.controller.member;

import java.util.List;

import javax.servlet.http.HttpSession;

import oracle.sql.ARRAY;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;
import org.tempuri.PTWebService;
import org.tempuri.PTWebServiceLocator;

import com.google.gson.Gson;

import th.co.pt.pcca.pccaapp.classobject.CGlobal;
import th.co.pt.pcca.pccaapp.entities.member.WorkOutCriteriaObj;
import th.co.pt.pcca.pccaapp.entities.member.WorkOutIntraObj;
import th.co.pt.pcca.pccaapp.entities.member.WorkOutIntranetObj;
import th.co.pt.pcca.pccaapp.entities.member.WorkOutObj;
import th.co.pt.pcca.pccaapp.entities.util.ResultObj;
import th.co.pt.pcca.pccaapp.helper.WebUtil;


@Controller
public class MemberApproveWorkOutController {
	@RequestMapping(value = "/member-approve-workout", method = RequestMethod.GET)
	public ModelAndView memberhistory()
	{
		return new ModelAndView("member_approve_workout", null);
	}
	
	@RequestMapping(value = "/member-getmemberworkout-approve", method = RequestMethod.POST)
	public @ResponseBody List<WorkOutObj> GetWorkOutApprove(@RequestBody WorkOutCriteriaObj criteria,HttpSession session) {
		criteria.setApprover(CGlobal.getC_UserInfo(session).codempid);
		String uri = WebUtil.WebServiceUrl() + "HrisService/member-getworkout-approve";
	RestTemplate restTemplate = new RestTemplate();
	List<WorkOutObj> result = restTemplate.postForObject(uri, criteria,List.class);
		
		return result;
	}
	
	
	@RequestMapping(value = "/member-updateworkout", method = RequestMethod.POST)
	public @ResponseBody ResultObj UpdateWorkOut(@RequestBody WorkOutObj workout,HttpSession session) {
		ResultObj result = new ResultObj();
		try {
	
		workout.setUpdate_user(CGlobal.getC_UserInfo(session).codempid);
		String uri = WebUtil.WebServiceUrl() + "HrisService/member-updateworkout";
		RestTemplate restTemplate = new RestTemplate();
		workout.setUpdate_user(CGlobal.getC_UserInfo(session).getCodempid());
		 result = restTemplate.postForObject(uri, workout,ResultObj.class);
		if(!WebUtil.IsStringEmpty(result.getDoc_no())){
			String approver_status ="";
			if(workout.getStatus().equals("08")){
				approver_status ="A";
			}else{
				approver_status ="N";
			}
		String[] list_doc = result.getDoc_no().split(",");
		for(int i=0;i<list_doc.length;i++){
			
			String doc_data = list_doc[i];
			//String check = doc_no.substring(0,1);
			//doc_no =doc_no.substring(1,doc_no.length());
			String[] list_doc_data = doc_data.split("\\|");
			String check =list_doc_data[0];
			String emp_id =list_doc_data[1];
			String doc_no = list_doc_data[2];
			
			WorkOutIntraObj obj_appro = new WorkOutIntraObj();
			obj_appro.setDoc_no(doc_no);
			obj_appro.setEmp_id(emp_id);
			obj_appro.setApprove_flag(approver_status);
			obj_appro.setApprove_user(workout.getUpdate_user());
			if(check.equals("C")){
				obj_appro.setCancel_flag("C");
			}
			
			Gson gson = new Gson();	
				String input =gson.toJson(obj_appro);
				PTWebService approve_service = new PTWebServiceLocator();
				String result_webser = approve_service.getPTWebServiceSoap().PTHR_WfOutSideApprove(input);
				if(check.equals("C")){
					Gson gson1 = new Gson();
					String ref_search = approve_service.getPTWebServiceSoap().PTHR_WfOutSideSearch(input);
					WorkOutIntranetObj result_search = gson1.fromJson(ref_search,WorkOutIntranetObj.class);
					if(result_search.getOa_clearfg().equals("N")){
					approve_service.getPTWebServiceSoap().PTHR_WfOutSideCancel(input);
					}else{
						result.success=0;
						result.message ="ไม่สามารถยกเลิกได้  OA_CLEARFG ไม่เท่ากับ N";
					}
				}
				
				System.out.println(result_webser);
		}
		
				
		
		}
		
		}catch (Exception ex) {
			result.success=0;
			result.message= ex.getMessage();
			ex.printStackTrace();
			System.out.println(ex.getMessage());
		}
		return result;
		
	}
	
	
	
}
