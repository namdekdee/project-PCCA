package th.co.pt.pcca.pcca.controller.pms;

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

import th.co.pt.pcca.pccaservice.entities.util.ResultObj;
import th.co.pt.pcca.pccaservice.service.pms.PmsSetupService;

@Controller
public class ApiPmsSetupController {

	@Autowired
	PmsSetupService pmsSetupService;
	
	@RequestMapping(value = "/pms-getEstimateType" , method = RequestMethod.POST)
	@ResponseBody
	public List<Map<String, Object>> getEstimateType(@RequestBody String userId) throws HTTPException, IOException {		 
		 try {
			 
	        return pmsSetupService.findEstimateTypeByUserId(userId);
		 } catch (Exception ex) {
			 throw new HTTPException(404);
		 }
	}
	
	@RequestMapping(value = "/pms-getPeriodDetail" , method = RequestMethod.POST)
	@ResponseBody
	public List<Map<String, Object>> getPeriodDetail(@RequestBody Map<String,Object> map) throws HTTPException, IOException {		 
		 try {
			 
	        return pmsSetupService.findPeriodDetail(map.get("userId").toString(), map.get("year").toString());
		 } catch (Exception ex) {
			 throw new HTTPException(404);
		 }
	}
	
	@RequestMapping(value = "/pms-insertPeriodDetail" , method = RequestMethod.POST)
	@ResponseBody
	public ResultObj insertPeriodDetail(@RequestBody Map<String,Object> map) throws HTTPException, IOException {		 
		 try {
			 
	        return pmsSetupService.insertPeriodDetail(map);
		 } catch (Exception ex) {
			 throw new HTTPException(404);
		 }
	}
	
	@RequestMapping(value = "/pms-deletePeriodDetail" , method = RequestMethod.POST)
	@ResponseBody
	public ResultObj deletePeriodDetail(@RequestBody List<Map<String,Object>> list) throws HTTPException, IOException {		 
		 try {
			 
	        return pmsSetupService.deletePeriodDetail(list);
		 } catch (Exception ex) {
			 throw new HTTPException(404);
		 }
	}
	
	@RequestMapping(value = "/pms-insertPeriodDetailInYear" , method = RequestMethod.POST)
	@ResponseBody
	public ResultObj insertPeriodDetailInYear(@RequestBody Map<String,Object> map) throws HTTPException, IOException {		 
		 try {
			 
	        return pmsSetupService.insertPeriodDetailInYear(map);
		 } catch (Exception ex) {
			 throw new HTTPException(404);
		 }
	}
	
	@RequestMapping(value = "/pms-deletePeriodDetailInYear" , method = RequestMethod.POST)
	@ResponseBody
	public ResultObj deletePeriodDetailInYear(@RequestBody Map<String,Object> obj) throws HTTPException, IOException {		 
		 try {
			 
	        return pmsSetupService.deletePeriodDetailInYear(obj);
		 } catch (Exception ex) {
			 throw new HTTPException(404);
		 }
	}
	
	@RequestMapping(value = "/pms-updatePeriodDetail" , method = RequestMethod.POST)
	@ResponseBody
	public ResultObj updatePeriodDetail(@RequestBody Map<String,Object> map) throws HTTPException, IOException {		 
		 try {
			 
	        return pmsSetupService.updatePeriodDetail(map);
		 } catch (Exception ex) {
			 throw new HTTPException(404);
		 }
	}
	
	@RequestMapping(value = "/pms-updatePeriodDetailInYear" , method = RequestMethod.POST)
	@ResponseBody
	public ResultObj updatePeriodDetailInYear(@RequestBody Map<String,Object> map) throws HTTPException, IOException {		 
		 try {
			 
	        return pmsSetupService.updatePeriodDetailInYear(map);
		 } catch (Exception ex) {
			 throw new HTTPException(404);
		 }
	}
	
	@RequestMapping(value = "/pms-get-dropdown-selected" , method = RequestMethod.POST)
	@ResponseBody
	public List<Map<String, Object>> getSetupYear(@RequestBody Map<String,Object> map) throws HTTPException, IOException {		 
		 try { 
			 
	        return pmsSetupService.findEstimateTypeByChangeDropDown(map);
		 } catch (Exception ex) {
			 throw new HTTPException(404);
		 }
	}
}
