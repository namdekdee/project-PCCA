package th.co.pt.pcca.pccaservice.service.report;

import java.util.List;

import th.co.pt.pcca.pccaservice.entities.report.R01_ReportObj;
import th.co.pt.pcca.pccaservice.entities.report.R02_ReportObj;
import th.co.pt.pcca.pccaservice.entities.util.DropDownCriteriaObj;


public interface ReportService {
	List<R01_ReportObj> GetReportR01(DropDownCriteriaObj criteria);
	List<R02_ReportObj> GetReportR02(DropDownCriteriaObj criteria);
	
}
