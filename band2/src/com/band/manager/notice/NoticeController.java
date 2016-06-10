package com.band.manager.notice;

import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.band.common.MyUtil;

@Controller("manager.notice.noticeController")
public class NoticeController {
	
	@Autowired
	private NoticeService service;
	
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping("/manager/notice/notice/{url}")
	public ModelAndView readNotice(
			HttpServletRequest req,
			@RequestParam(value="page", defaultValue="1") int current_page,
			@RequestParam(value="searchKey", defaultValue="content") String searchKey,
			@RequestParam(value="searchValue", defaultValue="") String searchValue,
			@PathVariable String url
			) throws Exception{
		
		
		if(req.getMethod().equalsIgnoreCase("GET")){
			searchValue=URLDecoder.decode(searchValue, "utf-8");
		}
		
		Calendar cal=Calendar.getInstance();
		String today=cal.get(Calendar.MONTH)+1+"/"+cal.get(Calendar.DATE)+"/"+cal.get(Calendar.YEAR);
		
		
		ModelAndView mav=new ModelAndView(".admin.manager.notice.notice");
		
		mav.addObject("today",today);
		mav.addObject("url",url);
		
		return mav;
	}
	
	@RequestMapping("/manager/notice/list/{url}")
	public ModelAndView listNotice(
			HttpServletRequest req,
			@RequestParam(value="pageNo", defaultValue="1") int current_page,
			@PathVariable String url
			) throws Exception{
		
		
		int numPerPage=20;
		int total_page=0;
		int dataCount=0;
		
		// 전체 페이지 수
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("groupURL", url);
        
        dataCount = service.dataCount(map);
        if(dataCount != 0)
            total_page = myUtil.pageCount(numPerPage, dataCount);

        // 다른 사람이 자료를 삭제하여 전체 페이지수가 변화 된 경우
        if(total_page < current_page) 
            current_page = total_page;

        // 리스트에 출력할 데이터를 가져오기
        int start = (current_page - 1) * numPerPage + 1;
        int end = current_page * numPerPage;
        map.put("start", start);
        map.put("end", end);

        List<Notice> list = service.listNotice(map);
        Iterator<Notice> it=list.iterator();
        int listNum=0;
        int n = 0;
        
        Date todate=new Date();
        SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        long gap;
        
        
        while(it.hasNext()) {
        	Notice dto=it.next();
        	dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
			listNum = dataCount - (start + n - 1);
			dto.setListNum(listNum);
			
			Date endDate=format.parse(dto.getEndDate());
			gap=(endDate.getTime()-todate.getTime())/(60*60*1000);
			if(gap>=0){
				dto.setIsNotice(1);
			}else{
				dto.setIsNotice(0);
			}
			n++;
        }

        ModelAndView mav=new ModelAndView("admin/manager/notice/list");
        mav.addObject("list", list);
        mav.addObject("pageNo", current_page);
        mav.addObject("dataCount", dataCount);
        mav.addObject("listNum", listNum);
        mav.addObject("paging", myUtil.paging(current_page, total_page));
		mav.addObject("url", url);
        
		return mav;
	}
	
	@RequestMapping(value="/manager/notice/created/{url}", method=RequestMethod.POST)
	public ModelAndView submitNotice(
			@PathVariable String url,
			Notice dto
			)throws Exception{
		
		
		dto.setGroupURL(url);
		service.insertNotice(dto);
		
		return new ModelAndView("redirect:/manager/notice/notice/{url}");
		
	}
	
	@RequestMapping(value="/manager/notice/update/{url}", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> updateNotice(
			Notice dto,
			@PathVariable String url
			) throws Exception{
		
		service.updateNotice(dto);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("state", true);
		map.put("url", url);
		
		return map;
	}
	 
	@RequestMapping(value="/manager/notice/delete/{url}")
	@ResponseBody
	public Map<String, Object> deleteNotice(
			@RequestParam("noticeNo") int noticeNo
			,@PathVariable String url
			) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("url", url);
		map.put("noticeNo", noticeNo);
		
		service.deleteNotice(noticeNo);
		
		return map;
	}
	
}
