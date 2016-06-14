package com.band.account;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.band.common.FileManager;

@Controller("accountController")
public class AccountController {
	@Autowired
	private AccountService service;
	
	@Autowired
	private FileManager fileManager;
	
	@RequestMapping(value="/account/main/{url}", method=RequestMethod.GET)
	public ModelAndView method(
			@PathVariable String url,
			@RequestParam(value="month", defaultValue="0") int m,
			@RequestParam(value="year", defaultValue="0") int y
			) {
		
		Calendar cal = Calendar.getInstance();
		// 현재 날짜
		cal.setTime(new Date());
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
		SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd");
		String todate = sdf.format(cal.getTime()); // 현재날짜 따로 저장
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

		// 현재 날짜에 해당하는 데이터 출력
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
		
		// 가장 오래된 날짜
		String minDate = service.minDate(map);
		int mvo = 0;
		if(date.equals(minDate)){
			mvo = 1;
		}
		
		List<Account> list=service.listAccount(map);
		
		
		// 지난달:이번달  지출, 수입
		Calendar cal2 = Calendar.getInstance();
		cal2.setTime(new Date());
		cal2.add(Calendar.MONTH, -1);
		String predate = sdf.format(cal2.getTime());
		
		Map<String, Object> map2=new HashMap<String, Object>();
		map2.put("url", url);
		map2.put("predate", predate);
		
		Account thisMonthDto=service.listThisMonth(map2);
		Account preMonthDto=service.listPreMonth(map2);
		
		// 현재 잔액
		int balance;
		Map<String, Object> map3=new HashMap<String, Object>();
		map3.put("url", url);
		
		balance=service.readBalance(map3);
		
		// 일정 리스트
		List<Event> eventList=service.listEvent(map3);
		
		ModelAndView mav=new ModelAndView(".admin.account.money.list");
		mav.addObject("url", url);
		mav.addObject("list", list);
		mav.addObject("year", year);
		mav.addObject("month", month);
		mav.addObject("mvo", mvo);
		mav.addObject("tvo", tvo);
		mav.addObject("thisMonthDto", thisMonthDto);
		mav.addObject("preMonthDto", preMonthDto);
		mav.addObject("balance", balance);
		mav.addObject("today", today);
		mav.addObject("eventList", eventList);
		return mav;
	}
	
	@RequestMapping(value="/account/main/{url}", method=RequestMethod.POST)
	public String accountSubmit(
			@PathVariable String url,
			Account dto
			) throws Exception{
		dto.setUrl(url);
		service.insertAccount(dto);
		
		return "redirect:/account/main/"+url;
	}
	
	@RequestMapping(value="/account/deleteList/{url}", method=RequestMethod.POST)
	public String delete(
			@PathVariable String url,
			@RequestParam String[] table_records,
			@RequestParam String year,
			@RequestParam String month
			) {
		
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("url", url);
		map.put("list", Arrays.asList(table_records));
		
		service.deleteList(map);
		return "redirect:/account/main/"+url+"?year="+year+"&month="+month;
		
	}
	
	@RequestMapping(value="/account/update/{url}", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> update(
			@PathVariable String url,
			@RequestParam String year,
			@RequestParam String month,
			Account dto
			) {
		String state="true";
		
		dto.setUrl(url);
		int result=service.updateAccount(dto);

		if(result==0){
			state="false";
		}
		
		Map<String, Object> model = new HashMap<>(); 
		model.put("state", state);
		return model;

	}
	
	// 엑셀 폼 다운로드
	@RequestMapping(value="/account/download/{url}")
	public void download(
			HttpSession session,
			HttpServletResponse response,
			@PathVariable String url
			) throws Exception{
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + File.separator + "uploads" + File.separator+"file";
		String filename = "excel_upload.xls";
		
		fileManager.doFileDownload(filename, filename, pathname, response);
	}
	
	// 엑셀 파일 업로드
	@RequestMapping(value = "/account/upload/{url}", method = RequestMethod.POST)
	public ModelAndView upload(HttpSession session, @PathVariable String url, Account dto, String bank)
			throws Exception {

		String root = session.getServletContext().getRealPath("/");
		String pathname = root + File.separator + "uploads" + File.separator + "file";

		service.uploadExcel(dto, pathname, bank);

		return new ModelAndView("redirect:/account/main/" + url);

	}
	
	/***************************************************************/
	// 일정, 카테고리, 전체, 지정날짜별 검색
	@RequestMapping(value="/account/searchList/{url}", method=RequestMethod.POST)
	public ModelAndView searchList(
			@PathVariable String url,
			@RequestParam(value="start") String start,
			@RequestParam(value="end") String end
			) {
		
		String year = start.substring(0, 4);
		String month = start.substring(4, 6);
		String day = start.substring(6, 8);
		
		String year2 = end.substring(0, 4);
		String month2 = end.substring(4, 6);
		String day2 = end.substring(6, 8);
		
		start=year+"-"+month+"-"+day;
		end=year2+"-"+month2+"-"+day2;

		Map<String, Object> map=new HashMap<String, Object>();
		map.put("url", url);
		map.put("start", start); 
		map.put("end", end);
		
		List<Account> list=service.listAccount(map);
		
		ModelAndView mav=new ModelAndView("admin/account/money/searchList");
		mav.addObject("url", url);
		mav.addObject("list", list);
		mav.addObject("start", start);
		mav.addObject("end", end);
		return mav;
	}
	
	@RequestMapping(value="/account/allList/{url}", method=RequestMethod.POST)
	public ModelAndView allList(
			@PathVariable String url
			) {
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("url", url);
		
		List<Account> list=service.allListAccount(map);
		
		String all = "전체 입출금 내역";
		
		ModelAndView mav=new ModelAndView("admin/account/money/searchList");
		mav.addObject("url", url);
		mav.addObject("list", list);
		mav.addObject("all", all);
		return mav;
	}
	
	@RequestMapping(value="/account/eventList/{url}", method=RequestMethod.POST)
	public ModelAndView eventList(
			@PathVariable String url,
			@RequestParam(value="event") String event
			) {
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("url", url);
		map.put("event", event);
		
		List<Account> list=service.eventListAccount(map);
		
		ModelAndView mav=new ModelAndView("admin/account/money/searchList");
		mav.addObject("url", url);
		mav.addObject("list", list);
		mav.addObject("event", event);
		return mav;
	}
	
	@RequestMapping(value="/account/cateList/{url}", method=RequestMethod.POST)
	public ModelAndView cateList(
			@PathVariable String url,
			@RequestParam(value="category") String category
			) {
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("url", url);
		map.put("accountName", category);
		
		List<Account> list=service.cateListAccount(map);
		
		ModelAndView mav=new ModelAndView("admin/account/money/searchList");
		mav.addObject("url", url);
		mav.addObject("list", list);
		mav.addObject("category", category);
		return mav;
	}
	/***************************************************************/
	
	@RequestMapping(value="/account/noticeAccount/{url}", method=RequestMethod.POST)
	@ResponseBody
	public ModelAndView noticeAccount(
			@PathVariable String url,
			@RequestParam String transactionNo,
			@RequestParam String listName,
			NoticeAccount dto
			) {
		
		dto.setUrl(url);
		dto.setListName(listName);
		dto.setTransactionNo(transactionNo);
		service.insertNoticeAccount(dto);
		
		return new ModelAndView("redirect:/account/main/"+url);
	}
}