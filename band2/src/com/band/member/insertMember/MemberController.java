package com.band.member.insertMember;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.band.main.SessionInfo;

@Controller("member.memberInsert.memberController")
public class MemberController {
	
	@Autowired
	private MemberService service;	
	
	
	@RequestMapping(value="/insertMember/{url}",method=RequestMethod.GET)
	public ModelAndView memberForm(
			@PathVariable String url){
		ModelAndView mav=new ModelAndView(".member");
		mav.addObject("mode","created");
		mav.addObject("url",url);
		return mav;
	}
	
	@RequestMapping(value="/insertMember/{url}", method=RequestMethod.POST)
	public ModelAndView memberSubmit(Member dto,
			@PathVariable String url){

		int result=service.insertMember(dto);
		
		ModelAndView mav=new ModelAndView();
		
		if(result==1) {
			
			StringBuffer sb=new StringBuffer();
			sb.append(dto.getName()+ "님의 회원 가입이 정상적으로 처리되었습니다.<br>");
			sb.append("메인화면으로 이동하여 로그인 하시기 바랍니다.<br>");
			
			mav.setViewName(".mainLogin");
			mav.addObject("message", sb.toString());
			mav.addObject("title", "회원 가입");
		} else {
			mav.setViewName(".member");
			mav.addObject("mode", "created");
			mav.addObject("message", "아이디 중복으로 회원가입이 실패했습니다.");
		}
		return mav;
	}
	
	//회원정보수정시 아이디 비밀번호 다시 묻기
	@RequestMapping(value="/comfimMember/pwd/{url}", method=RequestMethod.GET)
	public ModelAndView pwdForm(
			HttpServletRequest req,
			HttpSession session,
			@PathVariable String url){
		SessionInfo info=(SessionInfo)session.getAttribute("main");
		if(info==null){
			return new ModelAndView("redirect:/member/login");
		}
		String dropout=req.getParameter("dropout");
		
		ModelAndView mav=new ModelAndView(".community.updateMember.pwd");
		if(dropout==null){
			mav.addObject("mode","update");
			
		}else{
			mav.addObject("mode","dropout");
		}
		return mav;
	}
	
	
	@RequestMapping(value="/comfimMember/pwd/{url}",method=RequestMethod.POST)
	public ModelAndView pwdSubmit(
			HttpSession session,
			@RequestParam(value="pwd") String pwd,
			@RequestParam(value="mode") String mode,
			@RequestParam(value="memberNo") int memberNo,
			@PathVariable String url
			){
		SessionInfo info=(SessionInfo)session.getAttribute("main");
		if(info==null){
			return new ModelAndView("redirect:/group/"+url);
		}
		
		Map<String, Object> map=new HashMap<>();
		map.put("memberNo", memberNo);
		map.put("url", url);
		
		Member dto=service.readMember(map);
		
		if(dto==null){
			session.invalidate();
			return new ModelAndView("redirect:/group/"+url);
		}
		
		if(! dto.getPwd().equals(pwd)){
			ModelAndView mav=new ModelAndView(".community.updateMember.pwd");
			if(mode.equals("update")){
				mav.addObject("mode","update");
			}else{
				mav.addObject("mode","dropout");
			}
			
			mav.addObject("url", url);
			mav.addObject("message","패스워드가 일치하지 않습니다");
			return mav;
		}
	
		// 회원정보수정폼
		ModelAndView mav=new ModelAndView(".community.updateMember.member2");
		mav.addObject("dto", dto);
		mav.addObject("mode", "update");
		mav.addObject("url", url);		
		return mav;
	}
	
	
	@RequestMapping(value="/updateMember/{url}",method=RequestMethod.POST)
	public ModelAndView updateSubmit(
			HttpSession session,
			Member dto,
			@PathVariable String url
			){
		SessionInfo info=(SessionInfo)session.getAttribute("main");
		if(info==null){
			return new ModelAndView("redirect:/group/"+url);
		}
		
		dto.setMemberNo(info.getMemberNo());
		service.updateMember(dto);
		
		ModelAndView mav=new ModelAndView(".community.updateMember.complete");
		
		StringBuffer sb=new StringBuffer();
		sb.append(dto.getName()+"님의 회원정보가 정상적으로 변경되었습니다.<br>");
		
		mav.addObject("title","회원 정보 수정");
		mav.addObject("message",sb.toString());
		mav.addObject("mode","update");
		return mav;
	}
	
	
	
	

}
