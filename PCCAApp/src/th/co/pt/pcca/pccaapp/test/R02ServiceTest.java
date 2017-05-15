package th.co.pt.pcca.pccaapp.test;

import java.io.File;
import java.util.List;

import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperPrint;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.client.RestTemplate;

import th.co.pt.pcca.pccaapp.entites.report.R01_ReportObj;
import th.co.pt.pcca.pccaapp.entites.report.R02_ReportObj;
import th.co.pt.pcca.pccaapp.entities.util.DropDownCriteriaObj;
import th.co.pt.pcca.pccaapp.helper.WebUtil;
import th.co.pt.pcca.pccaapp.service.report.R01Service;
import th.co.pt.pcca.pccaapp.service.report.R02Service;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({
	"test.xml"
})
@WebAppConfiguration
public class R02ServiceTest {
	@Autowired
	private R02Service r02Service;
	
	@Test
	public void test_R02() throws Exception {
		System.out.println("Hello");
		
		DropDownCriteriaObj criteria = new DropDownCriteriaObj();
//		case745 OT รวมไม่ถูก
		criteria.setHead_emp_id("588242");
		criteria.setEmp_id("598632");  
		criteria.setComp1("101");
		criteria.setComp4("024");
		criteria.setComp5("006");
		criteria.setComp6("003");
		criteria.setComp7("000");
		criteria.setStartDate("01/02/2017");
		criteria.setEndDate("28/02/2017");
		
//		case 728
//		criteria.setHead_emp_id("541094");
//		criteria.setEmp_id("553006");  
//		criteria.setComp1("102");
//		criteria.setComp4("007");
//		criteria.setComp5("002");
//		criteria.setComp6("102");
//		criteria.setComp7("000");
//		criteria.setStartDate("01/01/2017");
//		criteria.setEndDate("31/01/2017");
//		102 020 001 007 002 102 000
//		case 726
//		criteria.setHead_emp_id("500322");
//		criteria.setEmp_id("587867");  
//		criteria.setComp1("102");
//		criteria.setComp4("002");
//		criteria.setComp5("001");
//		criteria.setComp6("101");
//		criteria.setComp7("007");
//		criteria.setStartDate("01/01/2017");
//		criteria.setEndDate("15/01/2017");
		
//		case 742 588242  598632 101 100 001 024 006 003 000   01 - 31/03/2560   
//		criteria.setHead_emp_id("588242");
//		criteria.setEmp_id("598632");  
//		criteria.setComp1("101");
//		criteria.setComp4("024");
//		criteria.setComp5("006");
//		criteria.setComp6("103");
//		criteria.setComp7("000");
//		criteria.setStartDate("01/03/2017");
//		criteria.setEndDate("31/03/2017");
		
		
//		criteria.setHead_emp_id("588242");
//		criteria.setEmp_id("ALL");
//		criteria.setStartDate("01/01/2016");
//		criteria.setEndDate("30/01/2016");
//		criteria.setComp1("101");
//		criteria.setComp4("024");
//		criteria.setComp5("006");
//		criteria.setComp6("003");
//		criteria.setComp7("000");
//		
		String uri = WebUtil.WebServiceUrl() + "HrisService/report-getDataR02";
		RestTemplate restTemplate = new RestTemplate();
		List<R02_ReportObj> result = restTemplate.postForObject(uri, criteria, List.class);
		 
		JasperPrint jasperPrint = r02Service.getReportR02(result, criteria);
		
	
//		JasperPrint jasperPrint = r02Service.getReportR02();
		
		FileCopyUtils.copy(JasperExportManager.exportReportToPdf(jasperPrint), new File("/tmp/hris/report/R02.pdf"));
	}
}
