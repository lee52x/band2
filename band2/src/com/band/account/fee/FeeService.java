package com.band.account.fee;

import java.util.List;
import java.util.Map;

import com.band.account.Event;

public interface FeeService {
	public List<Event> eventList(Map<String, Object> map);
}