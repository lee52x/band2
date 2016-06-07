package com.band.event;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.band.common.dao.CommonDAO;

@Service("event.register.registerService")
public class EventServiceImpl implements EventService{
	
	@Autowired
	private CommonDAO dao;
	
	
	@Override
	public List<Member> listFriend(Map<String, Object> map) {
		List<Member> list=null;
		
		try {
			list=dao.getListData("event.listFriend", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}
	
	@Override
	public Event readEvent(int eventNo) {
		Event dto = null;
		try {
			dto=dao.getReadData("event.readEvent", eventNo);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return dto;
	}
	
	@Override
	public int insertEvent(Event dto) {
		int result=0;
		
		try {
			dao.insertData("event.insertEvent", dto);
			result=1;
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}


	

	@Override
	public int updateEvent(Event dto) {
		int result=0;
		
		try {
			result=dao.updateData("event.updateEvent", dto);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}
	
	@Override
	public int updateEvent(Map<String, Object> map) {
		int result=0;
		
		try {
			result=dao.updateData("event.updateEventComplete", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}

	@Override
	public int deleteEvent(Map<String, Object> map) {
		int result=0;
		
		try {
			dao.deleteData("event.deleteEvent", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}

	@Override
	public List<Event> listEvent(Map<String, Object> map) {
		List<Event> list = null;
		try {
			list=dao.getListData("event.listEvent",map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}	
		return list;
	}


	

}
