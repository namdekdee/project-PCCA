package th.co.pt.pcca.pccaapp.controller.member;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.mortbay.util.ajax.JSON;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;
import org.tempuri.PTWebService;
import org.tempuri.PTWebServiceLocator;
import org.tempuri.PTWebServiceSoap;

import com.google.gson.Gson;

import th.co.pt.pcca.pccaapp.classobject.CGlobal;
import th.co.pt.pcca.pccaapp.entities.member.MemberObj;
import th.co.pt.pcca.pccaapp.entities.member.WorkOutCriteriaObj;
import th.co.pt.pcca.pccaapp.entities.member.WorkOutIntraObj;
import th.co.pt.pcca.pccaapp.entities.member.WorkOutIntranetObj;
import th.co.pt.pcca.pccaapp.entities.member.WorkOutObj;
import th.co.pt.pcca.pccaapp.entities.member.WorkOutResultObj;
import th.co.pt.pcca.pccaapp.entities.member.WorkTimeCriteriaObj;
import th.co.pt.pcca.pccaapp.entities.member.WorkTimeLeaveObj;
import th.co.pt.pcca.pccaapp.entities.member.WorkTimeObj;
import th.co.pt.pcca.pccaapp.entities.util.ResultObj;
import th.co.pt.pcca.pccaapp.helper.WebUtil;

@Controller
public class MemberWorkOutController {

	@RequestMapping(value = "/member-workout", method = RequestMethod.GET)
	public ModelAndView memberhistory()
	{
		return new ModelAndView("member_workout", null);
	}
	
	@RequestMapping(value = "/member-getmemberworkout", method = RequestMethod.POST)
	public @ResponseBody List<WorkOutObj> GetWorkOut(@RequestBody WorkOutCriteriaObj criteria,HttpSession session) {
		
		String uri = WebUtil.WebServiceUrl() + "HrisService/member-getmemberworkout";
		RestTemplate restTemplate = new RestTemplate();
		criteria.setApprover(CGlobal.getC_UserInfo(session).getCodempid());
		List<WorkOutObj> result = restTemplate.postForObject(uri, criteria,List.class);
//		System.out.println(result);
		return result;
	}
	
	@RequestMapping(value = "/member-updateworkoutedit", method = RequestMethod.POST)
	public @ResponseBody ResultObj UpdateWorkOutEdit(@RequestBody WorkOutObj workout,HttpSession session) {
		String uri = WebUtil.WebServiceUrl() + "HrisService/member-updateworkout-edit";
		RestTemplate restTemplate = new RestTemplate();
		ResultObj result = restTemplate.postForObject(uri, workout,ResultObj.class);
		return result;
	}
	
	@RequestMapping(value = "/member-cancelworkoutrequest", method = RequestMethod.POST)
	public @ResponseBody ResultObj CancelWorkOutRequest(@RequestBody WorkOutObj workout,HttpSession session) {
		String uri = WebUtil.WebServiceUrl() + "HrisService/member-cancelworkout-request";
		RestTemplate restTemplate = new RestTemplate();
		ResultObj result = restTemplate.postForObject(uri, workout,ResultObj.class);
		
		
		WorkOutIntraObj obj_cancl = new WorkOutIntraObj();
		obj_cancl.setDoc_no(result.getDoc_no());
		obj_cancl.setCancel_user(result.getCancel_user());
		Gson gson = new Gson();	
		String input =gson.toJson(obj_cancl);
		
		try {
			PTWebService approve_service = new PTWebServiceLocator();
			String result_webser = approve_service.getPTWebServiceSoap().PTHR_WfOutSideCancel(input);
				System.out.println(result_webser);
		
		return result;
		}catch (Exception ex) {
			ex.printStackTrace();
			System.out.println(ex.getMessage());
		}
		ResultObj result1  =new ResultObj();
		return result1;
		
	}
	
	
	
	@RequestMapping(value = "/member-insertworkout", method = RequestMethod.POST)
	public @ResponseBody ResultObj InsertWorkOut(@RequestBody WorkOutCriteriaObj criteria,HttpSession session) {
		
		String place_flag =criteria.getPlace_flag();
		if(place_flag.equals("3")){
			place_flag ="2";	
		}
		WorkOutIntraObj obj_intra = new WorkOutIntraObj();
		obj_intra.setEmp_id(criteria.getCodempid());
		obj_intra.setCompany(criteria.getPlace());
		obj_intra.setObjective(criteria.getObjective());
		obj_intra.setPlace_flag(place_flag);
		obj_intra.setPlace(criteria.getPlace());
		obj_intra.setIsprivate_car(criteria.getPrivate_flag());
		obj_intra.setStart_company(criteria.getStart_place());
		obj_intra.setStart_date(criteria.getStart_date()+" "+criteria.getStart_time());
		obj_intra.setEnd_company(criteria.getEnd_place());
		obj_intra.setEnd_date(criteria.getEnd_date()+" "+criteria.getEnd_time());
		obj_intra.setDay_night(0);
		obj_intra.setDoc_no(criteria.getDoc_no());
		Gson gson = new Gson();	
		String input =gson.toJson(obj_intra);
	
		try {
			String result_webser ="";
			Gson gson1 = new Gson();
			WorkOutResultObj result_intranet = new WorkOutResultObj();
			ResultObj result = new ResultObj();
			PTWebService test_service = new PTWebServiceLocator();
			if(criteria.getSave_case().equals("C")){
				String ref_search = test_service.getPTWebServiceSoap().PTHR_WfOutSideSearch(input);
				WorkOutIntranetObj result_search = gson1.fromJson(ref_search,WorkOutIntranetObj.class);
				if(result_search.getOa_clearfg().equals("N")){
					if(criteria.getStatus().equals("01")){
						result_webser = test_service.getPTWebServiceSoap().PTHR_WfOutSideCancel(input);
						result_intranet = gson1.fromJson(result_webser,WorkOutResultObj.class);
					}else{
						
						String uri = WebUtil.WebServiceUrl() + "HrisService/member-valid-workout";
						RestTemplate restTemplate = new RestTemplate();
						criteria.setUpdate_user(CGlobal.getC_UserInfo(session).getCodempid());
						
						 result = restTemplate.postForObject(uri, criteria,ResultObj.class);
						
						 if(result.getSuccess()==1){
						if(!WebUtil.IsStringEmpty(criteria.getDoc_no())){
							 result_webser = test_service.getPTWebServiceSoap().PTHR_WfOutSideUpdate(input);
						}else{
						 result_webser = test_service.getPTWebServiceSoap().PTHR_WfOutSideInsert(input);
						}
						result_intranet = gson1.fromJson(result_webser,WorkOutResultObj.class);
						 }else{
							 result_webser ="error";
							 result_intranet = new WorkOutResultObj();
							 result_intranet.setSuccess(0);
							 result_intranet.setMessage(result.getMessage());
						 }
					}
					
				}else{
					result_webser ="cancel";
					result_intranet.setSuccess(0);
					result_intranet.setMessage("ไม่สามารถยกเลิกได้ เนื่องจากใบปฏิบัติงานภายนอก ถูกนำไปสรุปค่าใช้จ่ายแล้ว");
				}
				//if(criteria.getStatus().equals("01")){
				 //result_webser = test_service.getPTWebServiceSoap().PTHR_WfOutSideCancel(input);
				//}
				
			}else{
				String uri = WebUtil.WebServiceUrl() + "HrisService/member-valid-workout";
				RestTemplate restTemplate = new RestTemplate();
				criteria.setUpdate_user(CGlobal.getC_UserInfo(session).getCodempid());
				
				 result = restTemplate.postForObject(uri, criteria,ResultObj.class);
				
				 if(result.getSuccess()==1){
				if(!WebUtil.IsStringEmpty(criteria.getDoc_no())){
					 result_webser = test_service.getPTWebServiceSoap().PTHR_WfOutSideUpdate(input);
				}else{
				 result_webser = test_service.getPTWebServiceSoap().PTHR_WfOutSideInsert(input);
				}
				result_intranet = gson1.fromJson(result_webser,WorkOutResultObj.class);
				 }else{
					 result_webser ="error";
					 result_intranet = new WorkOutResultObj();
					 result_intranet.setSuccess(0);
					 result_intranet.setMessage(result.getMessage());
				 }
			}

				
				
				
				if(WebUtil.IsStringEmpty(result_webser)){	
					String uri = WebUtil.WebServiceUrl() + "HrisService/member-insertworkout";
					RestTemplate restTemplate = new RestTemplate();
					criteria.setUpdate_user(CGlobal.getC_UserInfo(session).getCodempid());
					
					 result = restTemplate.postForObject(uri, criteria,ResultObj.class);
				}else{
					if(result_intranet.getSuccess() ==1){			
						String uri = WebUtil.WebServiceUrl() + "HrisService/member-insertworkout";
						RestTemplate restTemplate = new RestTemplate();
						criteria.setDoc_no(result_intranet.getDoc_no());
						criteria.setAllow_flag(result_intranet.getAllow_flag());
						criteria.setKilo_flag(result_intranet.getKilo_flag());
						criteria.setUpdate_user(CGlobal.getC_UserInfo(session).getCodempid());
						
						 result = restTemplate.postForObject(uri, criteria,ResultObj.class);
						}else{
							result.success =0;
							result.message =""+result_intranet.getMessage();
						}
				
				}
				return result;
					
		} catch (Exception ex) {
			ex.printStackTrace();
			System.out.println(ex.getMessage());
		}
		ResultObj result  =new ResultObj();
		return result;
	}
}
		
