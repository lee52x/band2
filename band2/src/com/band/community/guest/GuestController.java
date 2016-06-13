package com.band.community.guest;

import java.io.File;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.band.common.FileManager;
import com.band.common.MyUtil;
import com.band.community.board.BoardService;
import com.band.community.board.Reply;
import com.band.main.SessionInfo;

@Controller("community.guestController")
public class GuestController {
	@Autowired
	private GuestService service;
	@Autowired
	private MyUtil myUtil;
	
	@Autowired
	private FileManager fileManager;
	
	
	@RequestMapping(value="/guestBoard/list/{url}", method=RequestMethod.GET)
	public ModelAndView list(
			@PathVariable String url
			)throws Exception{
		ModelAndView mav=new ModelAndView(".community.guest.guest");
		mav.addObject("url", url);
		return mav;
		
	}
	
	
	@RequestMapping(value="/guestBoard/created/{url}" , method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> createdSubmit(
			HttpServletResponse resp,
			HttpSession session,
			Guest dto,
			@PathVariable String url
			)throws Exception{
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+File.separator+"uploads"+File.separator+"guest";
		
		SessionInfo info=(SessionInfo)session.getAttribute("main");
		
		String state="true";
		if(info==null) { // 로그인이 되지 않는 경우
			state="loginFail";
		} else {
			dto.setName(info.getUserName());
			dto.setMemberNo(info.getMemberNo());
					
			int result=service.insertGuest(dto,pathname);
			if(result==0)
				state="false";
		}
	
		Map<String, Object> model=new HashMap<>();
		model.put("state", state);
		return model;
	}
	
	
	@RequestMapping(value="/guestBoard/delete/{url}", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> delete(
			HttpSession session,
			@RequestParam(value="guestNo") int guestNo,
			@RequestParam(value="imageFilename") String imageFilename,
			Guest dto,
			@PathVariable String url
			)throws Exception{
		
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+File.separator+"uploads"+File.separator+"guest";
		
		
		//자료 삭제
		
		int result=service.deleteGuest(guestNo, pathname, imageFilename);
		
		String state="true";
		if(result==0)
			state="false";
		
		
		Map<String, Object> model=new HashMap<>();
		
		model.put("state", state);
		return model;
	}
	
	
	
	//방명록 리스트
	@RequestMapping(value="/guestBoard/listGuest/{url}")
	public ModelAndView listGuest(
			@RequestParam(value="pageNo",defaultValue="1") int current_page,
			@PathVariable String url,
			HttpSession session
		
			
			) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("main");
		
		
		
		//리스트에 출력할 데이터
		Map<String, Object> map=new HashMap<String , Object>();
		map.put("url", url);
	
		
		List<Guest> list=service.listGuest(map);

		ModelAndView mav=new ModelAndView("community/guest/guestList");
		//jsp로 넘길 데이터	
		mav.addObject("url",url);
		mav.addObject("list",list);
		mav.addObject("pageNo",current_page);
		
		
		

		return mav;
}
	
	//좋아요 추가
	@RequestMapping(value="/guestBoard/guestLike/{url}", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> guestLike(
			HttpSession session,
			Guest dto,
			@PathVariable String url
			)throws Exception{
		SessionInfo info=(SessionInfo)session.getAttribute("main");
		
		String state="true";
		if(info==null){
			state="loginFail";
		}else{
			dto.setMemberNo(info.getMemberNo());
			
			int result=service.insertGuestLike(dto);
			if(result==0)
				state="false";
		}
		//작업 결과를 json으로 전송
		Map<String, Object> model=new HashMap<>();
		model.put("state", state);
		return model;
	}
	
	//좋아요 개수
	
	@RequestMapping(value="/guestBoard/countLike/{url}",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> countLike(
			@RequestParam(value="guestNo") int guestNo,
			@PathVariable String url
			)throws Exception{
		
		int likeCount=0;
		Map<String, Object> map=service.guestCountLike(guestNo);
		if(map!=null){
			likeCount=((BigDecimal)map.get("LIKECOUNT")).intValue();
		}
		//작업결과를 JSON으로 전송
		Map<String, Object> model=new HashMap<>();
		model.put("likeCount", likeCount);
	
		return model;
		
	}
	
	
	// 댓글 및 리플별 답글 추가
		@RequestMapping(value="/guestBoard/createdReply/{url}",
				method=RequestMethod.POST)
		@ResponseBody
		public Map<String, Object>  createdReply(
				HttpSession session,
				GuestReply dto,
				@PathVariable String url
				) throws Exception {
		
			SessionInfo info=(SessionInfo) session.getAttribute("main");
			
			String state="true";
			if(info==null) { // 로그인이 되지 않는 경우
				state="loginFail";
			} else {
				dto.setMemberNo(info.getMemberNo());
				int result=service.insertReply(dto);
				if(result==0)
					state="false";
			}
			
	   	    // 작업 결과를 json으로 전송
			Map<String, Object> model = new HashMap<>(); 
			model.put("state", state);
			return model;
		}
	
		
	
	

		
	}
	

	