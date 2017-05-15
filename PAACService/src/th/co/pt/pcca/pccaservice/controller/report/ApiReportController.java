package th.co.pt.pcca.pccaservice.controller.report;

import java.io.IOException;
import java.util.List;

import javax.xml.ws.http.HTTPException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import th.co.pt.pcca.pccaservice.entities.report.R01_ReportObj;
import th.co.pt.pcca.pccaservice.entities.report.R02_ReportObj;
import th.co.pt.pcca.pccaservice.entities.util.DropDownCriteriaObj;
import th.co.pt.pcca.pccaservice.entities.util.DropDownObj;
import th.co.pt.pcca.pccaservice.service.report.ReportService;
import th.co.pt.pcca.pccaservice.service.util.UtilService;

@Controller
public class ApiReportController {
	@Autowired
	private ReportService reportService;
	
	 @RequestMapping(value = "/report-getDataR01", method = RequestMethod.POST)
	    @ResponseBody
	    public List<R01_ReportObj> getReportR01( @RequestBody DropDownCriteriaObj criteria) throws HTTPException, IOException {
		 
			 try
			 {
		        return reportService.GetReportR01(criteria);
			 }
			 catch(Exception ex)
			 {
				 throw new HTTPException(404);
			 }
	    }
	    
	    
	    @RequestMapping(value = "/report-getDataR02", method = RequestMethod.POST)
	    @ResponseBody
	    public List<R02_ReportObj> getReportR02( @RequestBody DropDownCriteriaObj criteria) throws HTTPException, IOException {
		 
		 try
		 {
	        return reportService.GetReportR02(criteria);
		 }
		 catch(Exception ex)
		 {
			 throw new HTTPException(404);
		 }
	 }
	    
	    
	    

	 
}
