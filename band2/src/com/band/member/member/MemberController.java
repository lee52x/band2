package com.band.member.member;

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

@Controller("member.member.memberController")
public class MemberController {
	
	@Autowired
	private MemberService service;	
	
	@RequestMapping(value="/admin/member/member/{url}", method=RequestMethod.GET)
	public ModelAndView list(
			@PathVariable String url
			) throws Exception {										
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("url", url);
		
		List<Member> list = service.listMember(map);		
		
		ModelAndView mav = new ModelAndView(".admin.member.member");	
		mav.addObject("list", list);		
		return mav;
	}
	
	@RequestMapping(value="/admin/member/member/{url}", method=RequestMethod.POST)
	public ModelAndView memberInsert(			
			Member dto) throws Exception {			
		service.insertMember(dto);
		
		return new ModelAndView("redirect:/admin/member/member/{url}");		
	}	
	
	@RequestMapping(value="/admin/member/update/{url}", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> memberUpdate(
			Member dto
			) throws Exception {
		service.updateMember(dto);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("state", true);
		
		return map;
	}
	
	@RequestMapping(value="/admin/member/delete/{url}", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> memberDelete(
			@RequestParam("memberNo") int memberNo,
			@PathVariable String url
			) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("url", url);
		map.put("memberNo", memberNo);
		
		service.deleteMember(map);
		
		return map;
	}
}
