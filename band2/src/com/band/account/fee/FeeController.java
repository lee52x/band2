package com.band.account.fee;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.band.account.Event;

@Controller("feeController")
public class FeeController {
	
	@Autowired
	private FeeService service;
	
	@RequestMapping(value="/account/fee/{url}", method=RequestMethod.GET)
	public ModelAndView method(
			@PathVariable String url
			) {

		Map<String, Object> map=new HashMap<String, Object>();
		map.put("url", url);
			
		// 일정 리스트
		List<Event> eventList=service.eventList(map);
		
		ModelAndView mav=new ModelAndView(".admin.account.fee.list");
		mav.addObject("url", url);
		mav.addObject("eventList", eventList);
		return mav;
	}
	
}