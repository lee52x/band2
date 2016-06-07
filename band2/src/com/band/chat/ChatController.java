package com.band.chat;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.band.main.SessionInfo;

@Controller("chat.chatController")
public class ChatController {
	@RequestMapping(value="/community/chat/{url}")
	public ModelAndView main(
			@PathVariable String url,
			HttpSession session) {
		SessionInfo info = (SessionInfo) session.getAttribute("main");

		if (info == null) {
			return new ModelAndView("redirect:/group/"+url);
		}
		
		ModelAndView mav=new ModelAndView(".community.chat.chat");
		mav.addObject("subMenu", "5");
		mav.addObject("url",url);
		return mav;
	}
}
