package com.band.manager.interest;

import java.net.URLDecoder;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.band.common.MyUtil;

@Controller("manager.interest.interestController")
public class InterestController {
	
	@Autowired
	private InterestService service;
	
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping("/manager/interest/{url}")
	public ModelAndView readInterest(
			@PathVariable String url,
			HttpServletRequest req,
			@RequestParam (value="page", defaultValue="1") int current_page,
			@RequestParam (value="searchKey", defaultValue="hashDate") String searchKey,
			@RequestParam (value="searchValue", defaultValue="") String searchValue,
			@RequestParam (value="searchValue2", defaultValue="") String searchValue2
			) throws Exception{
		
		if(req.getMethod().equalsIgnoreCase("GET")){
			searchValue=URLDecoder.decode(searchValue,"utf-8");
			searchValue2=URLDecoder.decode(searchValue,"utf-8");
		}
		
		int numPerPage=20;
		int total_page=0;
		int dataCount=0;
		
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("searchKey", searchKey);
		map.put("searchValue", searchValue);
		map.put("searchValue2", searchValue2);
		dataCount=service.dataCount(map);
		
		if(dataCount!=0){
			total_page=myUtil.pageCount(numPerPage, dataCount);
		}
		
		if(total_page<current_page){
			current_page=total_page;
		}
		
		int start=(current_page-1)*numPerPage+1;
		int end=current_page*numPerPage;
		map.put("start", start);
		map.put("end", end);
		
		List<Interest> list=service.listInterest(map);
		Iterator<Interest> it=list.iterator();
		int listNum=0;
		int n=0;
		
		while(it.hasNext()){
			Interest dto=it.next();
			listNum=start+n;
			dto.setListNum(listNum);
			n++;
		}
		
		
		ModelAndView mav=new ModelAndView(".admin.manager.interest");
		
		mav.addObject("url",url);
		mav.addObject("list", list);
		mav.addObject("pageNo", current_page);
		mav.addObject("listNum", listNum);
		mav.addObject("paging", myUtil.paging(current_page, total_page));
		
		return mav;
	}
	
	
}
