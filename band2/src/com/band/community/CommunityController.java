package com.band.community;

import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
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
import com.band.account.NoticeAccount;
import com.band.common.MyUtil;
import com.band.manager.notice.Notice;
import com.band.manager.picture.Picture;

@Controller("community.communityController")
public class CommunityController {
	
	@Autowired
	public MyUtil myUtil;
	
	@Autowired
	public CommunityService service;
	
	@RequestMapping(value="/community/main/{url}", method=RequestMethod.GET)
	public ModelAndView method(
			@PathVariable String url,
			Notice ndto,
			Picture pdto,
			@RequestParam(value="pageNo", defaultValue="1") int current_page
			)throws Exception{
		
		List<Picture> plist=service.listNonMainPicture(url);
		pdto=service.readMainPicture(url);
		
		
		int numPerPage=20;
		int total_page=0;
		int dataCount=0;
		
		Date todate=new Date();
		
		Map<String, Object> map=new HashMap<>();
        map.put("groupURL", url);
        map.put("todate", todate);
        
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

        List<Notice> nlist=service.listCommunityNotice(map);
        Iterator<Notice> it=nlist.iterator();
        int listNum=0;
        int n = 0;
        
        while(it.hasNext()) {
        	Notice dto=it.next();
        	dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
			listNum = dataCount - (start + n - 1);
			dto.setListNum(listNum);
			n++;
        }
        
        // 회계내역 조회
        Map<String, Object> map2=new HashMap<>();
        map2.put("url", url);
        List<NoticeAccount> accountList=service.readNoticeAccount(map2);
   
		
		
		ModelAndView mav=new ModelAndView(".communityLayout");
		mav.addObject("ndto",ndto);
		mav.addObject("pdto",pdto);
		mav.addObject("url", url);
		mav.addObject("plist", plist);
		mav.addObject("nlist",nlist);
		mav.addObject("listNum", listNum);
		mav.addObject("accountList", accountList);
		
		
		return mav;
	}
	
	@RequestMapping(value="/community/accountList/{url}", method=RequestMethod.POST)
	public ModelAndView accountList(
			@PathVariable String url,
			@RequestParam(value="transactionNo") String transactionNo
			) {
		
		String[] tranNo = transactionNo.split(",");
		
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("url", url);
		map.put("transactionNo", Arrays.asList(tranNo));
		
		List<Account> accountList=service.accountList(map);
		
		ModelAndView mav=new ModelAndView("community/layout/accountList");
		mav.addObject("url", url);
		mav.addObject("accountList", accountList);
		return mav;
	}



}
