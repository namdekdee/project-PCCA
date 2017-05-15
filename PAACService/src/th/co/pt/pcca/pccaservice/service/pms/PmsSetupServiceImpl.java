package th.co.pt.pcca.pccaservice.service.pms;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import th.co.pt.pcca.pccaservice.dao.pms.PmsSetupDao;
import th.co.pt.pcca.pccaservice.entities.util.ResultObj;

@Service("pmsSetupService")
public class PmsSetupServiceImpl implements PmsSetupService {
	@Autowired
	PmsSetupDao pmsSetupDao;
	private  final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Override
	public List<Map<String, Object>> findEstimateTypeByUserId(String userId) {
		List<Map<String, Object>> result = null;
		try {
			result = pmsSetupDao.findEstimateTypeByUserId(userId);
		} catch (Exception e) {
			logger.error(e.getMessage()); 
		}
		return result;
	}

	@Override
	public List<Map<String, Object>> findPeriodDetail(String userId, String year) {
		List<Map<String, Object>> result = null;
		try {
			result = pmsSetupDao.findPeriodDetail(userId, year);
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		return result;
	}

	@Override
	public ResultObj insertPeriodDetail(Map<String, Object> obj) {
		ResultObj result = new ResultObj();
		try {
			result = pmsSetupDao.insertPeriodDetail(obj);
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		return result;
	}

	@Override
	public ResultObj deletePeriodDetail(List<Map<String, Object>> obj) {
		ResultObj result = new ResultObj();
		try {
			result = pmsSetupDao.deletePeriodDetail(obj);
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		return result;
	}
	
	@Override
	public ResultObj insertPeriodDetailInYear(Map<String, Object> obj) {
		ResultObj result = new ResultObj();
		try {
			result = pmsSetupDao.insertPeriodDetailInYear(obj);
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		return result;
	}
	
	@Override
	public ResultObj deletePeriodDetailInYear(Map<String, Object> obj) {
		ResultObj result = new ResultObj();
		try {
			result = pmsSetupDao.deletePeriodDetailInYear(obj);
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		return result;
	}
	
	@Override
	public ResultObj updatePeriodDetail(Map<String, Object> obj) {
		ResultObj result = new ResultObj();
		try {
			result = pmsSetupDao.updatePeriodDetail(obj);
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		return result;
	}
	
	@Override
	public ResultObj updatePeriodDetailInYear(Map<String, Object> obj) {
		ResultObj result = new ResultObj();
		try {
			result = pmsSetupDao.updatePeriodDetailInYear(obj);
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		return result;
	}

	@Override
	public List<Map<String, Object>> findEstimateTypeByChangeDropDown(Map<String, Object> obj) {
		List<Map<String, Object>> result = null;
		try {
			result = pmsSetupDao.findEstimateTypeByChangeDropDown(obj);
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		return result;
	}
}
