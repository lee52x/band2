package com.band.manager.picture;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;


@Controller("manager.picture.pictureController")
public class PictureController {
	@Autowired
	private PictureService service;
	
	@RequestMapping(value="/manager/picture/{url}", method=RequestMethod.GET)
	public ModelAndView listPicture(
			@PathVariable String url
			) throws Exception{
		
		
		List<Picture> list=service.listPicture(url);
		int dataCount=service.dataCount(url);
		
		ModelAndView mav=new ModelAndView(".admin.manager.picture");
		
		mav.addObject("list", list);
		mav.addObject("url",url);
		mav.addObject("dataCount", dataCount);
		
		return mav;
	}
	
	@RequestMapping(value="/manager/picture/created/{url}", method=RequestMethod.POST)
	public String createPicture(
			HttpSession session,
			@PathVariable String url,
			Picture dto
			) throws Exception{
		
		String root=session.getServletContext().getRealPath("/");
		String path=root+File.separator+"uploads"+File.separator+"management";
		
		service.insertPicture(dto, path, url);
		
		return "redirect:/manager/picture/{url}";		
	}
	
	@RequestMapping(value="/manager/picture/delete2/{url}", method=RequestMethod.GET)
	public String deletePicture(
			@PathVariable String url,
			HttpSession session
			) throws Exception{
		
		String root = session.getServletContext().getRealPath("/");
		String path = root + File.separator + "uploads" + File.separator + "notice";
		service.deletePicture(url, path);
		
		return "redirect:/manager/picture/{url}";
	}
	
	
	
	
}
