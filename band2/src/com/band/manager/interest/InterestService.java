package com.band.manager.interest;

import java.util.List;
import java.util.Map;

public interface InterestService {
	
	public List<Interest> listInterest(Map<String, Object> map);
	public int dataCount(Map<String, Object> map);
	
}
