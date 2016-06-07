package com.band.account.state;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.band.account.Account;


@Controller("stateController")
public class StateController {
	
	@Autowired
	private StateService service;
	
	@RequestMapping(value="/account/state/{url}", method=RequestMethod.GET)
	public ModelAndView method(
			@PathVariable String url,
			@RequestParam(value="month", defaultValue="0") int m,
			@RequestParam(value="year", defaultValue="0") int y
			) {

		Calendar cal = Calendar.getInstance();
		// ���� ��¥
		cal.setTime(new Date());
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
		SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd");
		String todate = sdf.format(cal.getTime()); // ���糯¥ ���� ����
		String today = sdf2.format(cal.getTime());

		if (y != 0) {
			cal.set(Calendar.YEAR, y);
			cal.set(Calendar.MONTH, m - 1);
			cal.set(Calendar.DATE, 1);
		}
	
		
		String date = sdf.format(cal.getTime());
		String year = date.substring(0, 4);
		String month = date.substring(5, 7);
		
		cal.add(Calendar.MONTH, -1);
		String pdate = sdf.format(cal.getTime());

		// ���� ��¥�� �ش��ϴ� ������ ���
		String end = date + "-31";
		String start = pdate + "-31";
		
		int tvo = 0;
		if(todate.equals(date)){
			tvo = 1;
		}

		Map<String, Object> map=new HashMap<String, Object>();
		map.put("url", url);
		map.put("start", start);
		map.put("end", end);
		
		// ���� ������ ��¥
		String minDate = service.minDate(map);
		int mvo = 0;
		if(date.equals(minDate)){
			mvo = 1;
		}
		
		List<Account> cateList=service.cateState(map); // ī�װ� �� ����Ʈ
		List<Account> depositList=service.depositState(map); // ���� ����Ʈ
		
		
		// ���ں� ����Ʈ
		Map<String, Object> map2=new HashMap<String, Object>();
		map2.put("url", url);
		
		List<Account> dayList=service.dayState(map2);
		List<Account> eventList=service.eventState(map2);
		
		// ������:�̹���  ����, ����
		Calendar cal2 = Calendar.getInstance();
		cal2.setTime(new Date());
		cal2.add(Calendar.MONTH, -1);
		String predate = sdf.format(cal2.getTime());
		
		Map<String, Object> map3=new HashMap<String, Object>();
		map3.put("url", url);
		map3.put("predate", predate);
		
		Account thisMonthDto=service.listThisMonth(map3);
		Account preMonthDto=service.listPreMonth(map3);
		
		// ���� �ܾ�
		int balance;
		Map<String, Object> map4=new HashMap<String, Object>();
		map4.put("url", url);
		
		balance=service.readBalance(map4);
		
		ModelAndView mav=new ModelAndView(".admin.account.state.list");
		mav.addObject("url", url);
		mav.addObject("cateList", cateList);
		mav.addObject("depositList", depositList);
		mav.addObject("dayList", dayList);
		mav.addObject("eventList", eventList);
		mav.addObject("year", year);
		mav.addObject("month", month);
		mav.addObject("mvo", mvo);
		mav.addObject("tvo", tvo);
		mav.addObject("thisMonthDto", thisMonthDto);
		mav.addObject("preMonthDto", preMonthDto);
		mav.addObject("balance", balance);
		mav.addObject("today", today);
		return mav;
	}
	
}