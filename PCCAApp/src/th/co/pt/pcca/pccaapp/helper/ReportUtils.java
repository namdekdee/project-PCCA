package th.co.pt.pcca.pccaapp.helper;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.Map;
import java.util.Map.Entry;

import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.util.JRLoader;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class ReportUtils {
	
	private static final Logger logger = LoggerFactory.getLogger(ReportUtils.class);
	
	public static InputStream getResourceFile(String path, String fileName) throws FileNotFoundException {
		
		logger.debug("getResourceFile fileName=" + fileName);
		logger.debug("inputPath=" + path);
		InputStream jrxmlFile = null;
		try {
			String fullPath = path + "/" + fileName;
			logger.info("getResourceFile=" + fullPath);
//			jrxmlFile = new FileInputStream(fullPath);
			jrxmlFile = Thread.currentThread().getContextClassLoader().getResourceAsStream(fullPath);
			logger.debug("file=" + jrxmlFile);
		} catch (Exception e) {
			throw new FileNotFoundException("Report Template Not Found.");
		}
		
		return jrxmlFile;
	}
	
	public static JasperPrint exportReport(String reportName, Map<String, Object> params, JRDataSource dataSource) throws IOException, JRException {
		logger.debug("exportReport reportName=" + reportName);
		
		for (Entry<String, Object> e : params.entrySet()) {
			logger.debug("param=" + e.getKey() + ", value=" + e.getValue());
		}
		
		JasperPrint jasperPrint = null;
		InputStream jasperStream = null;
		try {
			jasperStream = getResourceFile("report/jrxml", reportName + ".jasper");
			JasperReport jasperReport = (JasperReport) JRLoader.loadObject(jasperStream);
			jasperPrint = JasperFillManager.fillReport(jasperReport, params, dataSource);
		} catch (JRException e) {
			logger.error(e.getMessage(), e);
			throw e;
		} finally {
			if (jasperStream != null) {
				jasperStream.close();
			}
		}
		
		return jasperPrint;
	}
	
	public static void closeResourceFileInputStream(Map<String, Object> params) {
		for (Object value : params.values()) {
			if (value instanceof InputStream && value != null) {
				try {
					((InputStream) value).close();
				} catch (IOException e) {
					logger.error(e.getMessage(), e);
				}
			}
		}
	}
	
/***********************************************************************************************************/	
/***********************************************************************************************************/
	
	
	
 
}
