package com.band.manager.insertBoard;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller("manager.insertBoard.insertBoardController")
public class InsertBoardController {
	
	@RequestMapping("/admin/manager/insertBoard")
	public ModelAndView readInsertBoard(
			HttpServletRequest req
			) throws Exception{
		
		String cp=req.getContextPath();
		
		ModelAndView mav=new ModelAndView(".admin.manager.insertBoard");
		
		return mav;
		
	}
	
	
}
