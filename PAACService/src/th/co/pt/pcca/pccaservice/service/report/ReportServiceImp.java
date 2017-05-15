package th.co.pt.pcca.pccaservice.service.report;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;







import th.co.pt.pcca.pccaservice.dao.report.ReportDao;
import th.co.pt.pcca.pccaservice.entities.report.R01_ReportObj;
import th.co.pt.pcca.pccaservice.entities.report.R02_ReportObj;
import th.co.pt.pcca.pccaservice.entities.util.DropDownCriteriaObj;


@Service("reportService")
public class ReportServiceImp implements ReportService {
	
	@Autowired
	private ReportDao reportDao;
	
	public List<R01_ReportObj> GetReportR01(DropDownCriteriaObj criteria){
		return reportDao.GetReportR01(criteria);
	}
	
	public List<R02_ReportObj> GetReportR02(DropDownCriteriaObj criteria){
		return reportDao.GetReportR02(criteria);
	}
}
