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
			
		// ���� ����Ʈ
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
		// ÷�������� �����ϴ� ���
		
		dto.setSubject("<������>'"+groupName+"'���� ȸ�� ���� �ȳ� ������ �����帳�ϴ�."); // ����
		dto.setContent("[ "+eventName+" ]�� ���� ȸ�� ���� ���� ������ [ "+todate+" ]���� �Դϴ�.<br>"
						+"���� ���� ��Ź�帳�ϴ�.<br>"
						+"<br>"
						+"<br>"
						+"------------------------------------<br>"
						+bankName+" "+accountNumber+"   ������: "+accountHolder+"<br>"
						+"�ݾ�: "+eventFee+"�� <br>"
						+"------------------------------------<br>"
						+"<br>"
						+"��Ÿ �ڼ��� ���ǻ����� �׷��� '"+dto.getSenderName()+"' ("+tel+" / "+dto.getSenderEmail()+")���� ��Ź�帳�ϴ�.<br>"
						+"�����մϴ�."); // ����
		
		boolean b=sender.mailSend(dto);
		String msg;
		if(b){
			msg="���� ���� ����!";
		}else{
			msg="���� ���� ���� �̤�";
		}
		
		Map<String, Object> model = new HashMap<>(); 
		model.put("msg", msg);
		return model;
	}
}