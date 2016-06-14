package com.band.group;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller("group.groupController")
public class GroupController {

	@Autowired
	private GroupService service;
	
	@RequestMapping(value="/group/create")
	public ModelAndView groupCreate(
			Group dto
			) throws Exception{
		
		service.insertGroup(dto);
		
		ModelAndView mav=new ModelAndView("main/groupCreate");
		mav.addObject("url", dto.getGroupUrl());
		return mav;
	}
}
