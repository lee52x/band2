package com.band.event;

import java.util.List;
import java.util.Map;



public interface EventService {
	public Event readEvent(int eventNo);
	public int insertEvent(Event dto);
	public List<Event> listEvent(Map<String, Object> map);
	public int updateEvent (Event dto);
	public int updateEvent (Map<String, Object> map);
	public int deleteEvent(Map<String, Object> map);
	
	public List<Member> listFriend(Map<String, Object> map);
}
