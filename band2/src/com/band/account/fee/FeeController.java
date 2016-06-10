package com.band.account.fee;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.band.account.Event;
import com.band.common.MailSender;

@Controller("feeController")
public class FeeController {
	
	@Autowired
	private FeeService service;
	
	@Autowired
	private MailSender sender;
	
	@RequestMapping(value="/account/fee/{url}", method=RequestMethod.GET)
	public ModelAndView method(
			@PathVariable String url
			) {

		Map<String, Object> map=new HashMap<String, Object>();
		map.put("url", url);
			
		// 일정 리스트
		List<Event> eventList=service.eventList(map);
		Event firstDto=service.firstEvent(map);
		int firstEventNo=firstDto.getEventNo();
		
		
		ModelAndView mav=new ModelAndView(".admin.account.fee.list");
		mav.addObject("url", url);
		mav.addObject("eventList", eventList);
		mav.addObject("firstEventNo", firstEventNo);
		return mav;
	}
	
	@RequestMapping(value="/account/loadList/{url}", method=RequestMethod.POST)
	public ModelAndView allList(
			@PathVariable String url,
			@RequestParam(value="eventNo") String eventNo
			) {
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("url", url);
		map.put("eventNo", eventNo);
		
		List<Event> memberList=service.memberList(map);
		Event detailEvent=service.datailEvent(map);
		int ratio=service.feeRatio(map);
		List<Event> mailList=service.readMailMember(map);
		
		
		Map<String, Object> map2=new HashMap<String, Object>();
		map2.put("url", url);
		
		List<Event> leader=service.readLeader(map2);
		
		ModelAndView mav=new ModelAndView("admin/account/fee/memberList");
		mav.addObject("url", url);
		mav.addObject("memberList", memberList);
		mav.addObject("mailList", mailList);
		mav.addObject("detailDto", detailEvent);
		mav.addObject("ratio", ratio);
		mav.addObject("leader", leader);
		return mav;
	}
	
	@RequestMapping(value="/account/updateFee/{url}", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> updateFee(
			@PathVariable String url,
			@RequestParam int memberNo,
			Event dto
			) {
		int result=0;
		String fin="true";
		
		dto.setUrl(url);
		dto.setMemberNo(memberNo);
		
		result=service.updateFee(dto);
		
		if(result==0){
			fin="false";
		}
		
		Map<String, Object> model = new HashMap<>(); 
		model.put("fin", fin);
		return model;
	}
	
	@RequestMapping(value="/account/updateFeeN/{url}", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> updateFeeN(
			@PathVariable String url,
			@RequestParam int memberNo,
			Event dto
			) {
		int result=0;
		String fin="true";
		
		dto.setUrl(url);
		dto.setMemberNo(memberNo);
		
		result=service.updateFeeN(dto);
		
		if(result==0){
			fin="false";
		}
		
		Map<String, Object> model = new HashMap<>(); 
		model.put("fin", fin);
		return model;
	}
	
	
	@RequestMapping(value="/account/mail/{url}", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> mailSubmit(
			Mail dto,
			@RequestParam String todate,@RequestParam String eventFee,
			@RequestParam String eventName,@RequestParam String groupName,
			@RequestParam String bankName,@RequestParam String accountNumber,
			@RequestParam String accountHolder,@RequestParam String tel
			) throws Exception{
		// 첨부파일이 존재하는 경우
		
		dto.setSubject("<누리다>'"+groupName+"'에서 회비 납부 안내 메일을 보내드립니다."); // 제목
		dto.setContent("[ "+eventName+" ]에 대한 회비 납부 마감 기한이 [ "+todate+" ]까지 입니다.<br>"
						+"빠른 납부 부탁드립니다.<br>"
						+"<br>"
						+"<br>"
						+"------------------------------------<br>"
						+bankName+" "+accountNumber+"   예금주: "+accountHolder+"<br>"
						+"금액: "+eventFee+"원 <br>"
						+"------------------------------------<br>"
						+"<br>"
						+"기타 자세한 문의사항은 그룹장 '"+dto.getSenderName()+"' ("+tel+" / "+dto.getSenderEmail()+")으로 부탁드립니다.<br>"
						+"감사합니다."); // 내용
		
		boolean b=sender.mailSend(dto);
		String msg;
		if(b){
			msg="메일 전송 성공!";
		}else{
			msg="메일 전송 실패 ㅜㅜ";
		}
		
		Map<String, Object> model = new HashMap<>(); 
		model.put("msg", msg);
		return model;
	}
}