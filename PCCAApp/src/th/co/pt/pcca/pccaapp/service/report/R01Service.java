package th.co.pt.pcca.pccaapp.service.report;

import java.io.IOException;
import java.text.DecimalFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.jasperreports.engine.JREmptyDataSource;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import th.co.pt.pcca.pccaapp.entites.report.R01_ReportObj;
import th.co.pt.pcca.pccaapp.entities.util.DropDownCriteriaObj;
import th.co.pt.pcca.pccaapp.helper.ReportUtils;

@Service("r01Service")
public class R01Service {
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	public JasperPrint getReportR01(List<R01_ReportObj> list, DropDownCriteriaObj criteria) {
		
		Map<String, Object> params = new HashMap<String, Object>();
		String[] formatDate = criteria.getStartDate().split("/");
		params.put("printBy", criteria.getHead_emp_id());
		
		formatDate[2] =String.valueOf((Integer.parseInt(formatDate[2])+543)); 
		criteria.setStartDate(formatDate[0]+"/"+formatDate[1]+"/"+formatDate[2]);
		params.put("startDate", criteria.getStartDate());
		
		formatDate = criteria.getEndDate().split("/");
		formatDate[2] =String.valueOf((Integer.parseInt(formatDate[2])+543)); 
		criteria.setEndDate(formatDate[0]+"/"+formatDate[1]+"/"+formatDate[2]);
		params.put("endDate", criteria.getEndDate());
		
		JasperPrint jasperPrint = null;
		try {
			jasperPrint = ReportUtils.exportReport("R01", params, new JRBeanCollectionDataSource(list, false));
		} catch (IOException e) {
			logger.error(e.getMessage(), e);
		} catch (JRException e) {
			logger.error(e.getMessage(), e);
		}
		
		return jasperPrint;
	}
	
	
	
	
}
