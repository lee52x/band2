package com.band.event;

import java.util.Arrays;
import java.util.Calendar;
import java.util.HashMap;
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
	

	@RequestMapping(value="/event/listFriend/{url}")
	public ModelAndView listFriend(@PathVariable String url) throws Exception {			
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("url", url);
		
		List<Member> list=service.listFriend(map);
		
		ModelAndView mav=new ModelAndView("admin/event/listFriend");
		mav.addObject("listFriend", list);
		return mav;
	}
	
	
	@RequestMapping(value="/event/{url}")
	public ModelAndView list(
			@PathVariable String url) throws Exception{
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("url", url);
		List<Event> list = service.listEvent(map);
		
		// 오늘 날짜 정보를 넘겨주어, 달력관련해서 오늘이 표시 되도록!
		Calendar cal = Calendar.getInstance();
		String today=String.format("%02d", cal.get(Calendar.MONTH)+1)+"/"+String.format("%02d", cal.get(Calendar.DATE))+"/"+cal.get(Calendar.YEAR);
		
		
		
		ModelAndView mav = new ModelAndView(".admin.event.event");
		mav.addObject("list", list);
		mav.addObject("today", today);
		return mav;
	}
	
	@RequestMapping(value="/event/{url}", method=RequestMethod.POST)
	public ModelAndView eventInsert(
			@PathVariable String url, 
			Event dto){

		service.insertEvent(dto);
		
		ModelAndView mav = new ModelAndView("redirect:/event/{url}");
		return mav;
	}
	
	
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
		
		//작업 결과를 JSON으로 전송
		Map<String, Object> model= new HashMap<>();
		model.put("url", url);
		model.put("state", state);
		return model;
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
		ModelAndView mav = new ModelAndView("redirect:/event/{url}");
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
		ModelAndView mav = new ModelAndView("redirect:/event/{url}");
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
	
}
