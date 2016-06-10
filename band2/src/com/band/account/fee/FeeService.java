package com.band.account.fee;

import java.util.List;
import java.util.Map;

import com.band.account.Event;

public interface FeeService {
	public List<Event> eventList(Map<String, Object> map);
	public List<Event> memberList(Map<String, Object> map);
	
	public Event firstEvent(Map<String, Object> map);
	public Event datailEvent(Map<String, Object> map);
	public int feeRatio(Map<String, Object> map);
	
	public int updateFee(Event dto);
	public int updateFeeN(Event dto);
	
	public List<Event> readMailMember(Map<String, Object> map);
	public List<Event> readLeader(Map<String, Object> map);
}