package com.band.member.stats;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.band.member.member.Member;

@Controller("member.stats.statsController")
public class StatsController {
	
	@Autowired
	private StatsService service;
	
	@RequestMapping(value="/member/stats/{url}")
	public ModelAndView stats(
			@PathVariable String url
			) throws Exception {
				
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("url", url);		
		
		int totalMember = service.totalMember(map);
		int communityMember = service.communityMember(map);
		int recentJoinMember = service.recentJoinMember(map);
		String firstDay = service.firstday();
		String today = service.today();
		String foundationDay = service.foundationDay(map);
		int cntFoundationDay = service.countFoundationDay(map);
		List<Member> list = service.listJoinMember(map);
		List<Member> birth = service.listBirthMember(map);
				
		ModelAndView mav = new ModelAndView(".admin.member.stats");
		mav.addObject("total", totalMember);
		mav.addObject("community", communityMember);
		mav.addObject("recentJoin", recentJoinMember);
		mav.addObject("first", firstDay);
		mav.addObject("today", today);
		mav.addObject("foundation", foundationDay);
		mav.addObject("cntFoundation", cntFoundationDay);
		mav.addObject("list", list);
		mav.addObject("birthList", birth);
		return mav;
	}
}
