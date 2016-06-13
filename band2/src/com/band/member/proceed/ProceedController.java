package com.band.member.proceed;

import java.io.File;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
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

import com.band.common.MyUtil;

@Controller("manager.proceed.proceedController")
public class ProceedController {
	@Autowired
	private ProceedService service;
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping(value="/member/insertProceed/{url}", method=RequestMethod.POST)
	public ModelAndView proceedInsert(			
			HttpSession session,
			Proceed dto,
			@PathVariable String url
			) throws Exception {
		String root = session.getServletContext().getRealPath("/");
		String path = root + File.separator + "uploads" + File.separator + "photo";
		
		ModelAndView mav = new ModelAndView("redirect:/member/proceedList/{url}");
		mav.addObject("mode", "created");
		mav.addObject("url", url);
		service.insertProceed(dto, path);
		
		return mav;		
	}	
	
	@RequestMapping(value="/member/proceedList/{url}")
	public ModelAndView proceedList(HttpSession session, 
			HttpServletRequest req,
			@RequestParam(value="page", defaultValue="1") int current_page,
			@RequestParam(value="searchKey", defaultValue="subject") String searchKey,
			@RequestParam(value="searchValue", defaultValue="") String searchValue			
			) throws Exception {
		
		String cp = req.getContextPath();
		String url=(String)session.getAttribute("url");
		
		int numPerPage = 10;
		int total_page;
		int dataCount;
		
		if(req.getMethod().equalsIgnoreCase("GET")) { // GET 방식인 경우
			searchValue = URLDecoder.decode(searchValue, "utf-8");
		}
		
		// 전체 페이지 수
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("searchKey", searchKey);
		map.put("searchValue", searchValue);
		
		dataCount = service.dataCount(map);
		total_page = myUtil.pageCount(numPerPage, dataCount);
		
		if(total_page < current_page)
			current_page = total_page;
		
		int start = (current_page - 1) * numPerPage + 1;
		int end = current_page * numPerPage;
		
		map.put("start", start);
		map.put("end", end);
		
		List<Proceed> list = service.proceedList(map);
		
		// 글번호 만들기
		int proceedNo, n = 0;
		Iterator<Proceed> it = list.iterator();
		while(it.hasNext()) {
			Proceed data = it.next();
			proceedNo = dataCount - (start + n - 1);
			data.setProceedNo(proceedNo);
			n++;
		}
		
		String params = "";
		String urlList = cp + "/member/proceedList/{url}";
		String urlArticle = cp + "/member/article?page=" + current_page;
		if(searchValue.length() != 0) {
			params = "searchKey=" + searchKey + "&searchValue=" + URLEncoder.encode(searchValue, "utf-8");
		}
		
		if(params.length() != 0) {
			urlList = cp + "/member/proceedList?" + params;
			urlArticle = cp + "/member/article?page=" + current_page + "&" + params;
		}
		
		ModelAndView mav = new ModelAndView(".admin.member.proceedings");
		mav.addObject("url", url);
		
		mav.addObject("list", list);
		mav.addObject("dataCount", dataCount);
		mav.addObject("total_page", total_page);
		mav.addObject("urlArticle", urlArticle);
		mav.addObject("page", current_page);
		mav.addObject("paging", myUtil.paging(current_page, total_page, urlList));
		
		return mav;
	}
}
