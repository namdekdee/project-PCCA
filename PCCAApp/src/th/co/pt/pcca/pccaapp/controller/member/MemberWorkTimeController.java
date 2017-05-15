package th.co.pt.pcca.pccaapp.controller.member;

import java.io.File;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;
import javax.xml.ws.http.HTTPException;

import org.apache.commons.io.FilenameUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import th.co.pt.pcca.pccaapp.classobject.CGlobal;
import th.co.pt.pcca.pccaapp.entities.member.MemberObj;
import th.co.pt.pcca.pccaapp.entities.member.WorkTimeCriteriaObj;
import th.co.pt.pcca.pccaapp.entities.member.WorkTimeLeaveObj;
import th.co.pt.pcca.pccaapp.entities.member.WorkTimeObj;
import th.co.pt.pcca.pccaapp.entities.util.ResultObj;
import th.co.pt.pcca.pccaapp.helper.WebUtil;

@Controller
public class MemberWorkTimeController {

	private  final Logger logger = LoggerFactory.getLogger(this.getClass());
	@RequestMapping(value = "/member-worktime", method = RequestMethod.GET)
	public ModelAndView memberhistory()
	{
		return new ModelAndView("member_worktime", null);
	}
	
	@RequestMapping(value = "/member-getmemberworktime", method = RequestMethod.POST)
	public @ResponseBody List<WorkTimeObj> GetWorkTime(@RequestBody WorkTimeCriteriaObj criteria,HttpSession session) {
		try{
			String uri = WebUtil.WebServiceUrl() + "HrisService/member-getworktime";
			RestTemplate restTemplate = new RestTemplate();
			criteria.setApprover(CGlobal.getC_UserInfo(session).getCodempid());
//			criteria.setGuId(CGlobal.getC_UserInfo(session).getGu_id());
			List<WorkTimeObj> result = restTemplate.postForObject(uri, criteria,List.class);
			return result;
		}catch(Exception ex){
			logger.error(ex.getMessage(),ex);
			ex.printStackTrace();
			throw new HTTPException(404);
		}
	}
	
	@RequestMapping(value = "/member-insertworktimeedittime", method = RequestMethod.POST)
	public @ResponseBody ResultObj InsertWorkTimeEditTime(@RequestBody WorkTimeCriteriaObj criteria,HttpSession session) {
		try{
		String uri = WebUtil.WebServiceUrl() + "HrisService/member-insertworktimeedittime";
		RestTemplate restTemplate = new RestTemplate();
		criteria.setUpdate_user(CGlobal.getC_UserInfo(session).getCodempid());
		ResultObj result = restTemplate.postForObject(uri, criteria,ResultObj.class);
		return result;
		}catch(Exception ex){
			logger.error(ex.getMessage(),ex);
			ex.printStackTrace();
			 throw new HTTPException(404);
		}
	}
	
	@RequestMapping(value = "/member-getleavepermiss", method = RequestMethod.POST)
	public @ResponseBody WorkTimeLeaveObj GetWorkTimeLeavePermiss(@RequestBody WorkTimeCriteriaObj criteria,HttpSession session) {
		try{
		String uri = WebUtil.WebServiceUrl() + "HrisService/member-getworktime-leavepermiss";
		RestTemplate restTemplate = new RestTemplate();
		WorkTimeLeaveObj result = restTemplate.postForObject(uri, criteria,WorkTimeLeaveObj.class);
		return result;
		}catch(Exception ex){
			logger.error(ex.getMessage(),ex);
			ex.printStackTrace();
			 throw new HTTPException(404);
		}
	}
	
	@RequestMapping(value = "/member-insertworktimeleave",method = RequestMethod.POST)
	public @ResponseBody ResultObj InsertWorkTimeLeave(@RequestParam("file") MultipartFile multipartFile,
			@RequestParam("emp_id") String emp_id,
			@RequestParam("company_id") String company_id,
			@RequestParam("shift_id") String shift_id,
			@RequestParam("work_date") String work_date,
			@RequestParam("leave_id") String leave_id,
			@RequestParam("is_rangdate") String is_rangdate,
			@RequestParam("start_flag") String start_flag,
			@RequestParam("end_flag") String end_flag,
			@RequestParam("start_date") String start_date,
			@RequestParam("end_date") String end_date,
			@RequestParam("remark") String remark,
			@RequestParam("save_case") String save_case,
			@RequestParam("trans_id") String trans_id,
			HttpSession session) {
		try{
			ResultObj result = new ResultObj();
		DateFormat df = new SimpleDateFormat("yyyMMddHHmmss");
        Date date_now = new Date();
        String file_name ="LV"+df.format(date_now);
        String original_name = multipartFile.getOriginalFilename();
        int check_type =0;
        //int index =original_name.indexOf('.');
        original_name = FilenameUtils.getExtension(original_name); // retu
       // original_name =original_name.substring(index,original_name.length());
        if(original_name.equals("pdf")){
        	check_type++;
        }
        if(original_name.equals("jpg")){
        	check_type++;
        }
        if(original_name.equals("png")){
        	check_type++;
        }
        if(original_name.equals("gif")){
        	check_type++;
        }
        if(original_name.equals("bmp")){
        	check_type++;
        }
        
       
      
        if(check_type >0){
        	 if(multipartFile.getSize()<=2097152){
        file_name =file_name+"."+original_name;
		WorkTimeCriteriaObj criteria = new WorkTimeCriteriaObj();
		String uri = WebUtil.WebServiceUrl() + "HrisService/member-insertworktimeleave";
		RestTemplate restTemplate = new RestTemplate();
		criteria.setUpdate_user(CGlobal.getC_UserInfo(session).getCodempid());
		criteria.setCodempid(emp_id);
		criteria.setCompany_id(company_id);
		criteria.setCod_shift(shift_id);
		criteria.setWork_date(work_date);
		criteria.setLeave_id(leave_id);
		criteria.setIs_rangdate(is_rangdate);
		criteria.setStart_flag(start_flag);
		criteria.setEnd_flag(end_flag);
		criteria.setStart_date(start_date);
		criteria.setEnd_date(end_date);
		criteria.setRemark(remark);
		criteria.setFile_name(file_name);
		criteria.setSave_case(save_case);
		criteria.setTrans_id(trans_id);
		if("1".equals(criteria.getIs_rangdate())){
			if("M".equals(criteria.getStart_flag())){
				criteria.setStart_flag("A");
				
			}
			if( "E".equals(criteria.getEnd_flag())){
				criteria.setEnd_flag("A");
			}
		}
		 result = restTemplate.postForObject(uri, criteria,ResultObj.class);
		
		if(!save_case.equals("C")){
		if(result.success==1){
			
	        String filePath = "/hris/project/hrisapp/LeaveRequest";
	        File upload_dir =new File(filePath);
	        if (!upload_dir.exists()) {
	        	upload_dir.mkdirs();
	        }
	        filePath = "/hris/project/hrisapp/LeaveRequest/"+file_name;
	        File dest = new File(filePath);
	        dest.length();
	        try {
	            multipartFile.transferTo(dest);
	        } catch (IllegalStateException e) {
	            e.printStackTrace();
	        } catch (IOException e) {
	            e.printStackTrace();
	        } 
		}}
        	 }else{
        		 result.success =0;
             	result.message ="ไม่สามารถบันทึกรายการได้  เนื่องจากขนาดไฟล์เกิน 2 MB";
        	 }
        }
        else{
        	result.success =0;
        	result.message ="ไม่สามารถบันทึกรายการได้  เนื่องจากประเภทไฟล์ที่รองรับคือ .pdf, .jpg, .png, .gif, .bmp";
        }
		return result;
		}catch(Exception ex){
			logger.error(ex.getMessage(),ex);
			ex.printStackTrace();
			 throw new HTTPException(404);
		}
	}
	
	@RequestMapping(value = "/member-insertworktimeleave-null",method = RequestMethod.POST)
	public @ResponseBody ResultObj InsertWorkTimeLeaveNull(@RequestParam("emp_id") String emp_id,
			@RequestParam("company_id") String company_id,
			@RequestParam("shift_id") String shift_id,
			@RequestParam("work_date") String work_date,
			@RequestParam("leave_id") String leave_id,
			@RequestParam("is_rangdate") String is_rangdate,
			@RequestParam("start_flag") String start_flag,
			@RequestParam("end_flag") String end_flag,
			@RequestParam("start_date") String start_date,
			@RequestParam("end_date") String end_date,
			@RequestParam("remark") String remark,
			@RequestParam("save_case") String save_case,
			@RequestParam("trans_id") String trans_id,
			HttpSession session) {      
        try{
		WorkTimeCriteriaObj criteria = new WorkTimeCriteriaObj();
		String uri = WebUtil.WebServiceUrl() + "HrisService/member-insertworktimeleave";
		RestTemplate restTemplate = new RestTemplate();
		criteria.setUpdate_user(CGlobal.getC_UserInfo(session).getCodempid());
		criteria.setCodempid(emp_id);
		criteria.setCompany_id(company_id);
		criteria.setCod_shift(shift_id);
		criteria.setWork_date(work_date);
		criteria.setLeave_id(leave_id);
		criteria.setIs_rangdate(is_rangdate);
		criteria.setStart_flag(start_flag);
		criteria.setEnd_flag(end_flag);
		criteria.setStart_date(start_date);
		criteria.setEnd_date(end_date);
		criteria.setRemark(remark);
		criteria.setSave_case(save_case);
		criteria.setTrans_id(trans_id);
		
		if("1".equals(criteria.getIs_rangdate())){
			if("M".equals(criteria.getStart_flag())){
				criteria.setStart_flag("A");
				
			}
			if( "E".equals(criteria.getEnd_flag())){
				criteria.setEnd_flag("A");
			}
		}
		ResultObj result = restTemplate.postForObject(uri, criteria,ResultObj.class);
		return result;
        }catch(Exception ex){
			logger.error(ex.getMessage(),ex);
			ex.printStackTrace();
			 throw new HTTPException(404);
		}
	}
	
	@RequestMapping(value = "/member-insertworktimeot", method = RequestMethod.POST)
	public @ResponseBody ResultObj InsertWorkTimeOT(@RequestBody WorkTimeCriteriaObj criteria,HttpSession session) {
		try{
		String uri = WebUtil.WebServiceUrl() + "HrisService/member-insertworktimeot";
		RestTemplate restTemplate = new RestTemplate();
		criteria.setUpdate_user(CGlobal.getC_UserInfo(session).getCodempid());
		ResultObj result = restTemplate.postForObject(uri, criteria,ResultObj.class);
		return result;
		}catch(Exception ex){
			logger.error(ex.getMessage(),ex);
			ex.printStackTrace();
			 throw new HTTPException(404);
		}
	}
	
	@RequestMapping(value = "/member-getedittimelist", method = RequestMethod.POST)
	public @ResponseBody List<WorkTimeObj> GetEditTimeList(@RequestBody WorkTimeCriteriaObj criteria,HttpSession session) {
		try{
		String uri = WebUtil.WebServiceUrl() + "HrisService/member-getedittimelist";
		RestTemplate restTemplate = new RestTemplate();
		List<WorkTimeObj> result = restTemplate.postForObject(uri, criteria,List.class);
		return result;
		}catch(Exception ex){
			logger.error(ex.getMessage(),ex);
			ex.printStackTrace();
			 throw new HTTPException(404);
		}
	}
	@RequestMapping(value = "/member-getleavelist", method = RequestMethod.POST)
	public @ResponseBody List<WorkTimeObj> GetLeaveList(@RequestBody WorkTimeCriteriaObj criteria,HttpSession session) {
		try{
		String uri = WebUtil.WebServiceUrl() + "HrisService/member-getleavelist";
		RestTemplate restTemplate = new RestTemplate();
		List<WorkTimeObj> result = restTemplate.postForObject(uri, criteria,List.class);
		return result;
		}catch(Exception ex){
			logger.error(ex.getMessage(),ex);
			ex.printStackTrace();
			 throw new HTTPException(404);
		}
	}
	@RequestMapping(value = "/member-getcalculateot", method = RequestMethod.POST)
	public @ResponseBody List<WorkTimeObj> GetCalculateOT(@RequestBody WorkTimeCriteriaObj criteria,HttpSession session) {
		try{
		String uri = WebUtil.WebServiceUrl() + "HrisService/member-getcalculateot";
		RestTemplate restTemplate = new RestTemplate();
		List<WorkTimeObj> result = restTemplate.postForObject(uri, criteria,List.class);
		return result;
		}catch(Exception ex){
			logger.error(ex.getMessage(),ex);
			ex.printStackTrace();
			 throw new HTTPException(404);
		}
	}
}
