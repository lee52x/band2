package com.band.member.proceed;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller("manager.proceed.proceedController")
public class ProceedController {
	
	@RequestMapping(value="/admin/member/proceed")
	public ModelAndView proceed(HttpSession session) throws Exception {
		
		String url=(String)session.getAttribute("url");
		
		ModelAndView mav = new ModelAndView(".admin.member.proceedings");
		mav.addObject("url", url);
		return mav;
	}	
}
