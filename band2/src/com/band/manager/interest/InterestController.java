package com.band.manager.interest;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller("manager.interest.interestController")
public class InterestController {
	
	@RequestMapping("/admin/manager/interest")
	public ModelAndView readInterest(
			HttpServletRequest req
			) throws Exception{
		
		String cp=req.getContextPath();
		
		ModelAndView mav=new ModelAndView(".admin.manager.interest");
		
		return mav;
	}
	
	
}
