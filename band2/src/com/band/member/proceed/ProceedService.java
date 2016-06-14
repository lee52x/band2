package com.band.member.proceed;

import java.util.List;
import java.util.Map;

public interface ProceedService {
	public int insertProceed(Proceed dto, String path);
	public int updateProceed(Proceed dto, String path);
	public int deleteProceed(int proceedNo, String saveFilename, String path);
	
	public Proceed readProceed(int proceedNo);
	public int dataCount(Map<String, Object> map);
	public List<Proceed> proceedList(Map<String, Object> map);	
}
