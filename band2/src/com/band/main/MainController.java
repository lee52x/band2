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

import com.band.photo.Photo;

@Controller("main.mainController")
public class MainController {
	@Autowired
	private MainService service;
	
	@RequestMapping(value="/", method=RequestMethod.GET)
	public ModelAndView method() throws Exception {
		return new ModelAndView(".mainLayout");
	}

	   @RequestMapping(value="/group/{url}",method=RequestMethod.GET)
	   public ModelAndView loginForm(
	         @PathVariable String url
	         )throws Exception{
	      ModelAndView mav=new ModelAndView(".mainLogin");
	         mav.addObject("url", url);
	      return mav;
	   }
	   
	   @RequestMapping(value="/group/{url}",method=RequestMethod.POST)
	   public String loginSubmit(
	         @PathVariable String url,
	         HttpSession session,
	         @RequestParam("userId") String userId,
	         @RequestParam("userPwd") String userPwd

	         )throws Exception{
	      
		  Map<String, Object> map=new HashMap<>();
		  map.put("userId", userId);
		  map.put("url", url);
		  
	      Main dto=service.readMember(map);
	      
	      SessionInfo info=new SessionInfo();
	      info.setUserId(userId);
	      info.setMemberNo(dto.getMemberNo());
	      info.setUserName(dto.getName());
	      
	      session.setAttribute("main", info);
	      session.setAttribute("url", url);

	      if(dto.getGrade()==1||dto.getGrade()==2){
	    	  return "redirect:/account/main/"+url;
	       }else{
	    	  return "redirect:/community/main/"+url;
	       }
	   }
	   

}
