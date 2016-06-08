package com.band.community.guest;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.band.common.MyUtil;
import com.band.main.SessionInfo;

@Controller("guest.guestController")
public class GuestController {
	@Autowired
	private GuestService service;
	
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping(value="/community/guest/{url}")
	public ModelAndView guest(
			@PathVariable String url
			) {
		ModelAndView mav=new ModelAndView(".community.guest.guest");
		mav.addObject("subMenu", "1");
		return mav;
	}
	
	@RequestMapping(value="/community/guestList/{url}")
	@ResponseBody
	public Map<String, Object>  list(
			@PathVariable String url,
			HttpSession session,
		    @RequestParam(value="pageNo", defaultValue="1") int current_page
			) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("main");
		
		
		int numPerPage=5;
		int dataCount=service.dataCount(url);
		int total_page=myUtil.pageCount(numPerPage, dataCount);
		if(current_page>total_page)
			current_page=total_page;
		
		int start=(current_page-1)*numPerPage+1;
		int end=current_page*numPerPage;
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("start", start);
		map.put("end", end);
		map.put("url", url);
		
		int listNum, n = 0;
		List<Guest> list=service.listGuest(map);
		Iterator<Guest> it=list.iterator();
		while(it.hasNext()) {
			Guest dto=it.next();
			dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
			
			listNum = dataCount - (start + n - 1);
            dto.setListNum(listNum);
            n++;			
		}
		
		// 인수 2개짜리
		String paging = myUtil.paging(current_page, total_page);
		
   	    // 작업 결과를 json으로 전송
		Map<String, Object> model = new HashMap<>(); 
		if(info==null)
			model.put("isLogin", "false");
		else
			model.put("isLogin", "true");
		// 데이터개수
		model.put("total_page", total_page);
		model.put("dataCount", dataCount);
		model.put("pageNo", current_page);
		model.put("paging", paging);
		// 게시물 리스트
		model.put("list", list);
		model.put("url", url);
		
		return model;
	}
	
	@RequestMapping(value="/community/guestCreated/{url}", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object>  createdSubmit(
			@PathVariable String url,
			HttpSession session, Guest dto
			) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("main");
		if(info==null) {
			// 로그인 상태가 아닌것을 json으로 전송
			Map<String, Object> model = new HashMap<>(); 
			model.put("isLogin", "false");
			return model;
		}
		
		// 글을 쓴사람(로그인한 아이디)
		dto.setMemberNo(info.getMemberNo());
		dto.setUserId(info.getUserId());
		dto.setGroupURL(url);
		service.insertGuest(dto);
		
		return list(url,session, 1);
	}
	
	@RequestMapping(value="/community/guestDelete/{url}",
			method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object>  guestDelete(
			@PathVariable String url,
			HttpSession session,
			@RequestParam(value="guestNo") int guestNo,
			@RequestParam(value="pageNo") int pageNo
			) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("main");
		if(info==null) {
	   	    // 로그인 상태가 아닌것을 json으로 전송
			Map<String, Object> model = new HashMap<>(); 
			model.put("isLogin", "false");
			return model;
		}
		Map<String, Object> map=new HashMap<>();
		map.put("guestNo", guestNo);
		map.put("url", url);
		service.deleteGuest(map);
		
		return list(url,session, 1);
	}
}
