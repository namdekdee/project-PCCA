package th.co.pt.pcca.pccaapp.controller.report;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.text.DecimalFormat;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.export.ooxml.JRXlsxExporter;
import net.sf.jasperreports.export.SimpleExporterInput;
import net.sf.jasperreports.export.SimpleOutputStreamExporterOutput;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import th.co.pt.pcca.pccaapp.classobject.CGlobal;
import th.co.pt.pcca.pccaapp.entites.report.R01_ReportObj;
import th.co.pt.pcca.pccaapp.entites.report.R02_ReportObj;
import th.co.pt.pcca.pccaapp.entities.util.DropDownCriteriaObj;
import th.co.pt.pcca.pccaapp.helper.WebUtil;
import th.co.pt.pcca.pccaapp.service.report.R02Service;


@Controller
public class Report_R02Controller {
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private R02Service r02Service;
	
	@RequestMapping(value = "/reportR02", method = RequestMethod.GET)
	public ModelAndView index() {
		
		return new ModelAndView("reportR02", null); 
		
	}
	
	@RequestMapping(value = "/report-getDataR02-PDF", method = RequestMethod.GET)
	public void getReportR02(@ModelAttribute DropDownCriteriaObj criteria, HttpServletResponse httpResposne, HttpSession session) throws IOException, JRException {
		String uri = WebUtil.WebServiceUrl() + "HrisService/report-getDataR02";
		criteria.setHead_emp_id(CGlobal.getC_UserInfo(session).getCodempid());
		criteria.setGu_id(CGlobal.getC_UserInfo(session).getGu_id());
		criteria.setNumminlvl(CGlobal.getC_UserInfo(session).getNumminlvl());
		RestTemplate restTemplate = new RestTemplate();
		List<R02_ReportObj> result = restTemplate.postForObject(uri, criteria, List.class);
		
		JasperPrint jasperPrint = r02Service.getReportR02(result,criteria);
		
//		httpResposne.setContentType("application/octet-stream");
		httpResposne.setContentType("application/pdf");
		httpResposne.setHeader("Content-Disposition", "attachment;filename=R02.pdf");
		
		FileCopyUtils.copy(JasperExportManager.exportReportToPdf(jasperPrint), httpResposne.getOutputStream());
	}
	
	@RequestMapping(value = "/report-getDataR02-Excel", method = RequestMethod.GET)
	public void getReportR02_Excel(@ModelAttribute DropDownCriteriaObj criteria, HttpServletResponse httpResposne, HttpSession session) throws IOException, JRException {
		String uri = WebUtil.WebServiceUrl() + "HrisService/report-getDataR02";
		criteria.setHead_emp_id(CGlobal.getC_UserInfo(session).getCodempid());
		criteria.setGu_id(CGlobal.getC_UserInfo(session).getGu_id());
		criteria.setNumminlvl(CGlobal.getC_UserInfo(session).getNumminlvl());
		RestTemplate restTemplate = new RestTemplate();
		List<R02_ReportObj> result = restTemplate.postForObject(uri, criteria, List.class);
		
		
		JasperPrint jasperPrint = r02Service.getReportR02(result,criteria);
		ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
		
		JRXlsxExporter exporterXLSXReporter = new JRXlsxExporter();
		exporterXLSXReporter.setExporterInput(new SimpleExporterInput(jasperPrint));
		//exporterXLSXReporter.setExporterOutput(new SimpleOutputStreamExporterOutput("R02.xlsx"));
		exporterXLSXReporter.setExporterOutput(new SimpleOutputStreamExporterOutput(byteArrayOutputStream));
		exporterXLSXReporter.exportReport();
		
		httpResposne.setContentType("application/octet-stream");
		httpResposne.setHeader("Content-Disposition", "attachment;filename=R02.xlsx");
		
		FileCopyUtils.copy(byteArrayOutputStream.toByteArray(), httpResposne.getOutputStream());
	}
}
