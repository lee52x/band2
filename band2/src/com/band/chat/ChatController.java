package com.band.chat;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.band.community.CommunityService;
import com.band.main.SessionInfo;
import com.band.manager.insertBoard.InsertBoard;
import com.band.manager.insertBoard.InsertBoardService;
import com.band.manager.picture.Picture;


@Controller("chat.chatController")
public class ChatController {
	
	@Autowired
	private InsertBoardService navService;
	
	@Autowired
	public CommunityService service2;
	
	@RequestMapping(value="/community/chat/{url}")
	public ModelAndView main(
			@PathVariable String url,
			HttpSession session,
			Picture pdto
			
			) {
		
		//대표사진 가져오기
		List<Picture> plist=service2.listNonMainPicture(url);
		pdto=service2.readMainPicture(url);
		
		
		SessionInfo info = (SessionInfo) session.getAttribute("main");

		if (info == null) {
			return new ModelAndView("redirect:/group/"+url);
		}
		
		
		//네비게이션 바 조정하기
		//동적 게시판 이름 가져오기
		Map<String, Object> navMap=new HashMap<>();
		navMap.put("groupURL", url);
				
		List<InsertBoard> navList=navService.listBoard(navMap);
		
		ModelAndView mav=new ModelAndView(".community.chat.chat");
		mav.addObject("subMenu", "5");
		mav.addObject("url",url);
		mav.addObject("navList", navList);
		mav.addObject("pdto",pdto);
		mav.addObject("plist", plist);
		
		return mav;
	}
}
