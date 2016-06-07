package com.band.community;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller("community.communityController")
public class CommunityController {
	
	@RequestMapping(value="/community/{url}", method=RequestMethod.GET)
	public ModelAndView method(
			@PathVariable String url
			)throws Exception{
		return new ModelAndView(".communityLayout");
	}
	/*
	@RequestMapping(value="/community/free/{url}", method=RequestMethod.GET)
	public ModelAndView qna(
			@PathVariable String url
			) throws Exception{
		return new ModelAndView(".community.free.free");
	}
	*/
	
//	@RequestMapping(value="/community/created/{url}")
//	public ModelAndView created(
//			@PathVariable String url
//			)throws Exception{
//		return new ModelAndView(".community.free.created");
//		
//	}
//	
	


}
