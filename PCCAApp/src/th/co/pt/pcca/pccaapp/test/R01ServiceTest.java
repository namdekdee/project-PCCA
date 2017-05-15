package th.co.pt.pcca.pccaapp.test;

import java.io.File;
import java.io.IOException;
import java.text.DecimalFormat;
import java.util.List;

import net.sf.jasperreports.engine.JRException;
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

import th.co.pt.pcca.pccaapp.classobject.CGlobal;
import th.co.pt.pcca.pccaapp.entites.report.R01_ReportObj;
import th.co.pt.pcca.pccaapp.entities.util.DropDownCriteriaObj;
import th.co.pt.pcca.pccaapp.helper.WebUtil;
import th.co.pt.pcca.pccaapp.service.report.R01Service;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({
	"test.xml"
})
@WebAppConfiguration
public class R01ServiceTest {
	
	@Autowired
	private R01Service r01Service;
	
	@Test
	public void test_R01() throws Exception {
		System.out.println("Hello");
		
		DropDownCriteriaObj criteria = new DropDownCriteriaObj();
		
//		case 743 101 100 001 024 006 003 000 ไม่แสดงผลรวม OT 
		criteria.setHead_emp_id("588242");
		criteria.setEmp_id("598632");  
		criteria.setComp1("101");
		criteria.setComp4("024");
		criteria.setComp5("006");
		criteria.setComp6("003");
		criteria.setComp7("000");
		criteria.setStartDate("01/02/2017");
		criteria.setEndDate("14/02/2017");
		
//		case 730  102 020 001 006 001 103 006
//		criteria.setHead_emp_id("490050");
//		criteria.setEmp_id("598190");  
//		criteria.setComp1("102");
//		criteria.setComp4("006");
//		criteria.setComp5("001");
//		criteria.setComp6("103");
//		criteria.setComp7("006");
//		criteria.setStartDate("01/01/2017");
//		criteria.setEndDate("31/01/2017");
		
//		574917  530354  101 100 001 024 006 002 000   23/02/2017 case 741  ชั่วโมงปกติไม่ถูกต้อง
//		criteria.setHead_emp_id("574917");
//		criteria.setEmp_id("530354");  
//		criteria.setComp1("101");
//		criteria.setComp4("024");
//		criteria.setComp5("006");
//		criteria.setComp6("002");
//		criteria.setComp7("000");
//		criteria.setStartDate("01/02/2017");
//		criteria.setEndDate("28/02/2017");
		
//		case 739
//		criteria.setHead_emp_id("588242");
//		criteria.setEmp_id("ALL");
//		criteria.setComp1("101");
//		criteria.setComp4("024");
//		criteria.setComp5("006");
//		criteria.setComp6("003");
//		criteria.setComp7("000");
//		criteria.setStartDate("01/02/2016");
//		criteria.setEndDate("07/02/2016");
		
//	case 734
//		criteria.setHead_emp_id("588242");
//		criteria.setEmp_id("598632");  
//		criteria.setComp1("101");
//		criteria.setComp4("024");
//		criteria.setComp5("006");
//		criteria.setComp6("103");
//		criteria.setComp7("000");
//		criteria.setStartDate("01/03/2017");
//		criteria.setEndDate("31/03/2017");
		
//		case 731
//		P_HEADER := '521039';
//		  P_EMP_ID := '576355';
//		  P_START_DATE := '01/03/2017';
//		  P_END_DATE := '31/03/2017';
//		  P_COMP1 := '102';
//		  P_COMP4 := '005';
//		  P_COMP5 := '002';
//		  P_COMP6 := '101';
//		  P_COMP7 := '004';
	
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
		
//		criteria.setHead_emp_id("530958");
//		criteria.setEmp_id("589258");  
//		criteria.setComp1("102");
//		criteria.setComp4("004");
//		criteria.setComp5("002");
//		criteria.setComp6("104");
//		criteria.setComp7("008");
//		criteria.setStartDate("01/01/2017");
//		criteria.setEndDate("31/01/2017");
		
//		case 727
//		criteria.setHead_emp_id("599858");
//		criteria.setEmp_id("587867");  
//		criteria.setComp1("102");
//		criteria.setComp4("002");
//		criteria.setComp5("001");
//		criteria.setComp6("101");
//		criteria.setComp7("007");
//		criteria.setStartDate("09/01/2017");
//		criteria.setEndDate("09/01/2017");
		
//		criteria.setHead_emp_id("566072");
//		criteria.setEmp_id("490157");
//		criteria.setComp1("102");
//		criteria.setComp4("003");
//		criteria.setComp5("001");
//		criteria.setComp6("002");
//		criteria.setComp7("000");
//		criteria.setStartDate("01/03/2015");
//		criteria.setEndDate("31/03/2015");
		
//		criteria.setHead_emp_id("599616");
//		criteria.setEmp_id("531527");
//		criteria.setComp1("101");
//		criteria.setComp4("002");
//		criteria.setComp5("007");
//		criteria.setComp6("001");
//		criteria.setComp7("000");
//		criteria.setStartDate("12/04/2016");
//		criteria.setEndDate("18/04/2016");
		
//		case 725 timin is not null , timout is null , absent 0.5
//		criteria.setHead_emp_id("521039");
//		criteria.setEmp_id("576355");  //102 020 001 005 002 101 004
//		criteria.setComp1("102");
//		criteria.setComp4("005");
//		criteria.setComp5("002");
//		criteria.setComp6("101");
//		criteria.setComp7("004");
//		criteria.setStartDate("01/01/2017");
//		criteria.setEndDate("13/01/2017");
		 
//		case 717 timin is not null , timout is null
//		criteria.setHead_emp_id("520183");
//		criteria.setComp1("101");
//		criteria.setComp4("017");
//		criteria.setComp5("000");
//		criteria.setComp6("000");
//		criteria.setComp7("000");
//		criteria.setEmp_id("000785");
//		criteria.setStartDate("01/04/2016");
//		criteria.setEndDate("30/04/2016");
//		
//		case 714
//		criteria.setHead_emp_id("000081");
//		criteria.setComp1("101");
//		criteria.setComp4("026");
//		criteria.setComp5("001");
//		criteria.setComp6("000");
//		criteria.setComp7("000");
//		criteria.setEmp_id("000797");
//		criteria.setStartDate("01/06/2016");
//		criteria.setEndDate("06/06/2016");
		
//		criteria.setHead_emp_id("599616");
//		criteria.setComp1("101");
//		criteria.setComp4("002");
//		criteria.setComp5("007");
//		criteria.setComp6("001");
//		criteria.setComp7("000");
//		criteria.setEmp_id("531527");
//		criteria.setStartDate("12/04/2016");
//		criteria.setEndDate("18/04/2016");
//		
//		case 715  leave P1, V1
//		criteria.setHead_emp_id("559401");
//		criteria.setEmp_id("562773");
//		criteria.setComp1("101");
//		criteria.setComp4("024");
//		criteria.setComp5("002");
//		criteria.setComp6("000");
//		criteria.setComp7("000");
//		criteria.setStartDate("01/07/2016");
//		criteria.setEndDate("31/07/2016");
		
//		case 716
//		criteria.setHead_emp_id("566072");
//		criteria.setComp1("102");
//		criteria.setComp4("003");
//		criteria.setComp5("001");
//		criteria.setComp6("002");
//		criteria.setComp7("000");
//		criteria.setEmp_id("490157");
//		criteria.setStartDate("20/03/2016");
//		criteria.setEndDate("25/03/2016");
		
//		
//		criteria.setHead_emp_id("520183");
//		criteria.setComp1("101");
//		criteria.setComp4("017");
//		criteria.setComp5("000");
//		criteria.setComp6("000");
//		criteria.setComp7("000");
//		criteria.setEmp_id("000785");
//		criteria.setStartDate("01/04/2016");
//		criteria.setEndDate("30/04/2016");
/* absent */
//		criteria.setHead_emp_id("520648");
//		criteria.setComp1("102");
//		criteria.setComp4("002");
//		criteria.setComp5("001");
//		criteria.setComp6("103");
//		criteria.setComp7("018");
//		criteria.setEmp_id("576631");
//		criteria.setStartDate("01/09/2016");
//		criteria.setEndDate("08/09/2016");
		/* absent */		
//		criteria.setHead_emp_id("520648");
//		criteria.setComp1("102");
//		criteria.setComp4("005");
//		criteria.setComp5("002");
//		criteria.setComp6("101");
//		criteria.setComp7("004");
//		criteria.setEmp_id("531019");
//		criteria.setStartDate("01/10/2016");
//		criteria.setEndDate("31/10/2016");
		
//		criteria.setHead_emp_id("000513");
//		criteria.setComp1("101");
//		criteria.setComp4("019");
//		criteria.setComp5("004");
//		criteria.setComp6("101");
//		criteria.setComp7("001");
//		criteria.setEmp_id("000372");
//		criteria.setStartDate("01/12/2016");
//		criteria.setEndDate("31/12/2016");
		
//		criteria.setHead_emp_id("521039");
//		criteria.setComp1("102");
//		criteria.setComp4("005");
//		criteria.setComp5("002");
//		criteria.setComp6("101");
//		criteria.setComp7("004");
//		criteria.setEmp_id("531019");
//		criteria.setStartDate("01/10/2016");
//		criteria.setEndDate("31/10/2016");
		
		String uri = WebUtil.WebServiceUrl() + "HrisService/report-getDataR01";
		RestTemplate restTemplate = new RestTemplate();
		List<R01_ReportObj> result = restTemplate.postForObject(uri, criteria, List.class);
		
		JasperPrint jasperPrint = r01Service.getReportR01(result, criteria);
		
		FileCopyUtils.copy(JasperExportManager.exportReportToPdf(jasperPrint), new File("/tmp/hris/report/R01.pdf"));
		
		
	
	}
	
}
