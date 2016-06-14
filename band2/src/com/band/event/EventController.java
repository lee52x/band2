package com.band.event;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;



@Controller("event.eventController")
public class EventController {
	
	@Autowired
	private EventService service;
	
	@RequestMapping(value="/event/list/{url}")
	public ModelAndView list(
			@PathVariable String url) throws Exception{
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("url", url);
		List<Event> list = service.listEvent(map);
		
		// ���� ��¥ ������ �Ѱ��־�, �޷°����ؼ� ������ ǥ�� �ǵ���!
		Calendar cal = Calendar.getInstance();
		String today=String.format("%02d", cal.get(Calendar.MONTH)+1)+"/"+String.format("%02d", cal.get(Calendar.DATE))+"/"+cal.get(Calendar.YEAR);
		
		
		
		ModelAndView mav = new ModelAndView(".admin.event.event");
		mav.addObject("list", list);
		mav.addObject("today", today);
		return mav;
	}
	

	@RequestMapping(value="/event/updateEvent/{url}", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> eventUpdate(
			Event dto) throws Exception{
		service.updateEvent(dto);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("state", true);
		
		return map;
	}
	
		
	@RequestMapping(value="/event/deleteEvent/{url}", method=RequestMethod.POST)
	public ModelAndView eventDelete(
			@PathVariable String url,
			@RequestParam String[] table_records
			){
		
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("url", url);
		map.put("list", Arrays.asList(table_records));
		
		service.deleteEvent(map);	
		ModelAndView mav = new ModelAndView("redirect:/event/"+url);
		return mav;
	}
	
	@RequestMapping(value="/event/updateEventComplete/{url}", method=RequestMethod.POST)
	public ModelAndView eventUpdateComplete(
			@PathVariable String url,
			@RequestParam String[] table_records
			){
		
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("url", url);
		map.put("list", Arrays.asList(table_records));
		
		service.updateEvent(map);
		ModelAndView mav = new ModelAndView("redirect:/event/"+url);
		return mav;
	}
	
	
	@RequestMapping(value="/event/{url}", method=RequestMethod.POST)
	public ModelAndView eventInsert(
			@PathVariable String url, 
			Event dto){

		service.insertEvent(dto);
		
		ModelAndView mav = new ModelAndView("redirect:/event/list/"+url);
		return mav;
	}
	
	
	// ���� ��� ������ ȸ������ ������ֱ�
	@RequestMapping(value="/event/listFriend/{url}")
	public ModelAndView listFriend(@PathVariable String url) throws Exception {			
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("url", url);
		
		List<Member> list=service.listFriend(map);
		
		ModelAndView mav=new ModelAndView("admin/event/listFriend");
		mav.addObject("listFriend", list);
		return mav;
	}
	
	// ������ ȸ���鸸 ����ȸ������ ��Ͻ����ִ� ���
	@RequestMapping(value="/event/insertAttend/{url}", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> attendSubmit(@PathVariable String url, Event dto) throws Exception{
		String state="false";
		
		try {
			for(Integer memberNo : dto.getMemberNos()){
				dto.setMemberNo(memberNo);

				service.insertAttend(dto);
			}
			state="true";
			
		} catch (Exception e) {
		}		
		
		//�۾� ����� JSON���� ����
		Map<String, Object> model= new HashMap<>();
		model.put("url", url);
		model.put("state", state);
		return model;
	}
	
	
	
	
	
	
	
	//-----------------------------------------------------------------------------------------
	//-----------------------------------------------------------------------------------------
	//-----------------------------------------------------------------------------------------
	//-----------------------------------------------------------------------------------------
	

	
	
	
	
	
	// sch.jsp�� ������ִ� ���
	@RequestMapping(value="/event/sch/{url}")
	public String sch(@PathVariable String url) throws Exception{
		return(".admin.event.sch.sch");
	}
	
	// ��ȭ���ڿ� ��� �� ���� �߰� ��
	@RequestMapping(value="/sch/inputForm")
	public String inputForm() throws Exception{
		return "admin/event/sch/inputForm";
	}
	
	// ��ȭ���ڿ� ��� �� �� ���� ��
	@RequestMapping(value="/sch/articleForm")
	public String articleForm() throws Exception{
		return "admin/event/sch/articleForm";
	}
	
	// Ķ������ ���� �̺�Ʈ�� ����ϴ� ���
	@RequestMapping(value="sch/created/{url}", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> created(
			@PathVariable String url,
			Event event) throws Exception{
		
		service.insertEvent(event);
		
		Map<String , Object> model =  new HashMap<>();
		return model;
		
	}
	
	
	// �޷��� ǥ�����ְ�, �� �޷¿� �������� listing ���ִ� ���
	@RequestMapping(value="/sch/month/{url}")
	@ResponseBody
	public Map<String, Object> month(
			@PathVariable String url,
			@RequestParam(value="start") String start,
			@RequestParam(value="end") String end,
			@RequestParam(value="group", defaultValue="all") String group
			) throws Exception {
		

		Map<String, Object> map=new HashMap<String, Object>();
		map.put("group", group);
		map.put("start", start);
		map.put("end", end);
		map.put("url", url);
		
		List<Event> list=service.listMonthSchedule(map);
		
	 	List<ScheduleJSON> listJSON=new ArrayList<>();
	    Iterator<Event> it=list.iterator();
		while(it.hasNext()) {
			Event event=it.next();
			// if(sch.getContent()!=null)
			//   sch.setContent(sch.getContent().replaceAll("\n", "<br>"));
			
			ScheduleJSON dto=new ScheduleJSON();
	    	dto.setId(event.getEventNo());
	    	dto.setTitle(event.getEventName());
	    	//dto.setUserName(event.getUserName());
	    	if(event.getEventType()==1){
	    		dto.setColor("#5bc0de");
	    	} else{
	    		dto.setColor("#169F85");
	    	}
	    	
	    	/*dto.setColor(event.getEventType());*/
	    	/*if(event.getAllDay().equals("true"))
	    	    dto.setAllDay(true);
	    	else
	    		dto.setAllDay(false);*/
	    	
	    	dto.setAllDay(false);
	    	
	    	if(event.getFromTime()!=null && event.getFromTime().length()!=0)
		    	dto.setStart(event.getFromDate()+" " + event.getFromTime());
	    	else
	    		dto.setStart(event.getFromDate());
	    	
	    	if(event.getToTime()!=null && event.getToTime().length()!=0)
	    		dto.setEnd(event.getToDate()+" " + event.getToTime());
	    	else
	    		dto.setEnd(event.getToTime());
	    	dto.setContent(event.getContent());
	    	//dto.setCreated(event.getCreated());
	    	listJSON.add(dto);
		}
		
   	    // �۾� ����� json���� ����
		Map<String, Object> model = new HashMap<>(); 
		//model.put("isLogin", "true");
		model.put("list", listJSON);
		return model;
	}
	
	@RequestMapping(value="/sch/delete/{url}", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> delete(
			@PathVariable String url,
			@RequestParam(value="eventNo") int eventNo
			) throws Exception {
		
		Map<String, Object> map = new HashMap<>();
		map.put("url", url);
		map.put("eventNo", eventNo);
		
		String state="false";
		int result=service.deleteSchedule(map);
		if(result==1)
			state="true";
		
		Map<String, Object> model = new HashMap<>();
		model.put("state", state);
		return model;
	}
	
	
	
	
	
	
	
	// place.jsp�� ������ִ� ���
		@RequestMapping(value="/event/place/{url}")
		public String place(@PathVariable String url) throws Exception{
			return(".admin.event.place.place");
		}
}
