package com.band.main;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.band.community.CommunityService;
import com.band.group.Group;
import com.band.manager.picture.Picture;

@Controller("main.mainController")
public class MainController {
	@Autowired
	private MainService service;
	
	@Autowired
	public CommunityService service2;
	
	@RequestMapping(value="/", method=RequestMethod.GET)
	public ModelAndView method() throws Exception {
		return new ModelAndView(".mainLayout");
	}

	   @RequestMapping(value="/group/{url}",method=RequestMethod.GET)
	   public ModelAndView loginForm(
	         @PathVariable String url,
	         Picture pdto,
	         Group dto
	         )throws Exception{
		   
		   //대표사진 가져오기
		   pdto=service2.readMainPicture(url);
		   
	      ModelAndView mav=new ModelAndView(".mainLogin");
	         mav.addObject("url", url);
	         mav.addObject("pdto",pdto);
	         mav.addObject("dto", dto);
	      return mav;
	   }
	   
	   @RequestMapping(value="/group/{url}",method=RequestMethod.POST)
	   public ModelAndView loginSubmit(
	         @PathVariable String url,
	         HttpSession session,
	         @RequestParam("userId") String userId,
	         @RequestParam("userPwd") String userPwd,
	         Picture pdto

	         )throws Exception{
	      
		  //대표사진 가져오기
		  pdto=service2.readMainPicture(url);
		   
		  Map<String, Object> map=new HashMap<>();
		  map.put("userId", userId);
		  map.put("url", url);
		  
	      Main dto=service.readMember(map);
	      
	      if(dto==null || (! dto.getPwd().equals(userPwd))||(!dto.getUserId().equals(userId))) {
				ModelAndView mav=new ModelAndView(".mainLogin");
				mav.addObject("message", "아이디 또는 패스워드가 일치하지 않습니다.");
				mav.addObject("pdto",pdto);
				return mav;
			}
	      SessionInfo info=new SessionInfo();
	      info.setUserId(userId);
	      info.setMemberNo(dto.getMemberNo());
	      info.setUserName(dto.getName());
	      info.setGrade(dto.getGrade());
	      info.setGroupName(dto.getGroupName());
	      
	      
	      session.setAttribute("main", info);
	      session.setAttribute("url", url);

	      if(dto.getGrade()==1||dto.getGrade()==2&&dto.getGroupURL().equals(url)){
	    	  return new ModelAndView("redirect:/account/main/"+url);
	       }else if(dto.getGrade()==3||dto.getGrade()==4||dto.getGrade()==5&&dto.getGroupURL().equals(url)){
	    	  return new ModelAndView("redirect:/community/main/"+url);
	       }else{
	    	   ModelAndView mav=new ModelAndView(".mainLogin");
	    	   mav.addObject("message","해당 사이트에 접근 권한이 없습니다.");
	    	   mav.addObject("pdto",pdto);
	    	   return mav;
	       }
	   }
	   

}
