package com.band.event;

import java.util.List;
import java.util.Map;
import com.band.event.Event;



public interface EventService {
	public Event readEvent(int eventNo);
	public int insertEvent(Event dto);
	public int insertAttend(Event dto);
	public List<Event> listEvent(Map<String, Object> map);
	public int listEventMax(Event dto);
	public int updateEvent (Event dto);
	public int updateEvent (Map<String, Object> map);
	public int deleteEvent(Map<String, Object> map);
	public List<Member> listFriend(Map<String, Object> map);
	
	
	public int insertSchedule(Event dto);
	public List<Event> listMonthSchedule(Map<String, Object> map);
	public Event readSchedule(int eventNo);
	public int deleteSchedule(Map<String, Object> map);
}
