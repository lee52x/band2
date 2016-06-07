package com.band.manager.update;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;


@Controller("manager.update.updateController")
public class UpdateController {
	
	@Autowired
	private UpdateService service;
	
	@RequestMapping(value= "/admin/manager/update/{url}", method=RequestMethod.GET)
	public ModelAndView readUpdate(
			HttpServletRequest req,
			@PathVariable String url
			) throws Exception{
		
		Update dto = service.readInfo(url);
		
		ModelAndView mav=new ModelAndView(".admin.manager.update");
		
		mav.addObject("dto", dto);
		mav.addObject("url",url);
		
		return mav;
	}
	
	@RequestMapping(value="/admin/manager/update/{url}", method=RequestMethod.POST)
	public String submitUpdate(
			Update dto,
			@PathVariable String url
			) throws Exception{
		
		dto.setGroupURL(url);
		service.updateInfo(dto);
		
		return "redirect:/admin/manager/update/{url}";
	}
	
	

	
}
