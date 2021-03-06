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
	
	// eventNo 가장 큰 값! (가장 최근에 추가된 값을 가져오기 위한)
	@Override
	public int listEventMax(Event dto){
		int result=0;
		
		try {
			result=dao.getIntValue("event.listEventMax", dto);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}
	
	@Override
	public int insertEvent(Event dto) {
		int result=0;
		int eventNo;
		
		try {
			dao.insertData("event.insertEvent", dto);
			//eventNo 들어가게 하는 방법!!
			/*1. mapper를 새로 짠다. select eventNo 가장 최근 값만 가져오는걸로!
			2. 그 mapper를 실행한다음.
			3. dto.setEventNo(dto) 실행하여 보내준다.*/
			result=1;
			eventNo=listEventMax(dto);
			
			dto.setEventNo(eventNo);
			if(!dto.getMemberNos().isEmpty()){
				for(Integer memberNo : dto.getMemberNos()){
					dto.setMemberNo(memberNo);
					insertAttend(dto);
				}
			}
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}

	
	
    @Override
	public int insertAttend(Event dto){
	int result=0;
		
		try {
			dao.insertData("event.insertAttend", dto);
			
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



	@Override
	public int insertSchedule(Event dto) {
		int result=0;
		
		try {
			result=dao.insertData("event.insertEvent", dto);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}



	@Override
	public List<Event> listMonthSchedule(Map<String, Object> map) {
		List<Event> list = null;
		
		try {
			list=dao.getListData("event.listMonthEvent", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}



	@Override
	public Event readSchedule(int eventNo) {
		Event event=null;
		try {
			event = dao.getReadData("event.readSchdule", eventNo);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return event;
	}



	@Override
	public int deleteSchedule(Map<String, Object> map) {
		int result=0;
		try {
			result=dao.deleteData("event.deleteSchedule", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}



	@Override
	public int MemberCount(Map<String, Object> map) {
		int result=0;
		try {
			result=dao.getIntValue("event.memberCount", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}



	@Override
	public List<Event> AttendList(Map<String, Object> map) {
		List<Event> list=null;
		try {
			list=dao.getListData("event.eventAttendMember", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}
	


	

}
