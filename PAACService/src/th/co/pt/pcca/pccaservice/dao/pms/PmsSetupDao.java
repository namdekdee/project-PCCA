package th.co.pt.pcca.pccaservice.dao.pms;

import java.util.List;
import java.util.Map;

import th.co.pt.pcca.pccaservice.entities.util.ResultObj;

public interface PmsSetupDao {
	List<Map<String,Object>> findEstimateTypeByUserId(String userId);
	List<Map<String, Object>> findPeriodDetail(String userId, String year);
	ResultObj insertPeriodDetail(Map<String, Object> obj);
	ResultObj deletePeriodDetail(List<Map<String, Object>> obj);
	ResultObj insertPeriodDetailInYear(Map<String, Object> obj);
	ResultObj deletePeriodDetailInYear(Map<String, Object> obj);
	ResultObj updatePeriodDetail(Map<String, Object> obj);
	ResultObj updatePeriodDetailInYear(Map<String, Object> obj);
	List<Map<String,Object>> findEstimateTypeByChangeDropDown(Map<String, Object> obj); 
}
