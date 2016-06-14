package com.band.manager.insertBoard;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller("manager.insertBoard.insertBoardController")
public class InsertBoardController {
	
	@Autowired
	public InsertBoardService service;
	
	@RequestMapping("/manager/insertBoard/{url}")
	public ModelAndView listBoard(
			HttpServletRequest req,
			@PathVariable String url,
			InsertBoard dto
			) throws Exception{
		
		
		Map<String, Object> map=new HashMap<>();
		map.put("groupURL", url);
		
		List<InsertBoard> list=service.listBoard(map);
		
		ModelAndView mav=new ModelAndView(".admin.manager.insertBoard");

		mav.addObject("list", list);
		mav.addObject("url",url);
		
		return mav;
		
	}
	
	@RequestMapping(value="/manager/insertBoard/delete2/{url}", method=RequestMethod.GET)
	public ModelAndView deleteBoard(
			HttpServletRequest req,
			@PathVariable String url,
			@RequestParam(value="boCateNum") int boCateNum,
			InsertBoard dto
			) throws Exception{
		
		
		Map<String, Object> map=new HashMap<>();
		map.put("groupURL", url);
		map.put("boCateNum", boCateNum);
		
		String state="true";
		
		int result=service.deleteBoard(map);
		
		if(result==0){
			state="false";
		}
		
		
		ModelAndView mav=new ModelAndView(".admin.manager.insertBoard");
		mav.addObject("state",state);
		mav.addObject("url",url);
		
		return mav;
		
	}
	
	@RequestMapping(value="/manager/insertBoard/update/{url}", method=RequestMethod.POST)
	public String updateBoard(
			HttpServletRequest req,
			@PathVariable String url,
			@RequestParam(value="boCateNum") int boCateNum,
			@RequestParam(value="boCateName") String boCateName,
			InsertBoard dto
			) throws Exception{
		
		
		Map<String, Object> map=new HashMap<>();
		map.put("groupURL", url);
		map.put("boCateNum", boCateNum);
		map.put("boCateName", boCateName);
		
		service.updateBoard(map);
		
		return "redirect:/manager/insertBoard/{url}";
		
	}
	
	@RequestMapping(value="/manager/insertBoard/insert/{url}", method=RequestMethod.POST)
	public String insertBoard(
			HttpServletRequest req,
			@PathVariable String url,
			@RequestParam(value="boCateType") String boCateType,
			@RequestParam(value="boCateName") String boCateName,
			InsertBoard dto
			) throws Exception{
		
		
		Map<String, Object> map=new HashMap<>();
		map.put("groupURL", url);
		map.put("boCateType", boCateType);
		map.put("boCateName", boCateName);
		
		service.insertBoard(map);
		
		return "redirect:/manager/insertBoard/{url}";
		
	}
	
	
}
