package com.band.account.fee;

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

import com.band.account.Account;
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
		Event firstDto=service.firstEvent(map);
		int firstEventNo=firstDto.getEventNo();
		
		
		ModelAndView mav=new ModelAndView(".admin.account.fee.list");
		mav.addObject("url", url);
		mav.addObject("eventList", eventList);
		mav.addObject("firstEventNo", firstEventNo);
		return mav;
	}
	
	@RequestMapping(value="/account/loadList/{url}", method=RequestMethod.POST)
	public ModelAndView allList(
			@PathVariable String url,
			@RequestParam(value="eventNo") String eventNo
			) {
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("url", url);
		map.put("eventNo", eventNo);
		
		List<Event> memberList=service.memberList(map);
		Event detailEvent=service.datailEvent(map);
		int ratio=service.feeRatio(map);
		
		ModelAndView mav=new ModelAndView("admin/account/fee/memberList");
		mav.addObject("url", url);
		mav.addObject("memberList", memberList);
		mav.addObject("detailDto", detailEvent);
		mav.addObject("ratio", ratio);
		return mav;
	}
	
	@RequestMapping(value="/account/updateFee/{url}", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> updateFee(
			@PathVariable String url,
			@RequestParam int memberNo,
			Event dto
			) {
		int result=0;
		String fin="true";
		
		dto.setUrl(url);
		dto.setMemberNo(memberNo);
		
		result=service.updateFee(dto);
		
		if(result==0){
			fin="false";
		}
		
		Map<String, Object> model = new HashMap<>(); 
		model.put("fin", fin);
		return model;
	}
	
	@RequestMapping(value="/account/updateFeeN/{url}", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> updateFeeN(
			@PathVariable String url,
			@RequestParam int memberNo,
			Event dto
			) {
		int result=0;
		String fin="true";
		
		dto.setUrl(url);
		dto.setMemberNo(memberNo);
		
		result=service.updateFeeN(dto);
		
		if(result==0){
			fin="false";
		}
		
		Map<String, Object> model = new HashMap<>(); 
		model.put("fin", fin);
		return model;
	}
}