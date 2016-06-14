package com.band.photo;

import java.io.File;
import java.math.BigDecimal;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.band.common.MyUtil;
import com.band.community.CommunityService;
import com.band.main.SessionInfo;
import com.band.manager.insertBoard.InsertBoard;
import com.band.manager.insertBoard.InsertBoardService;
import com.band.manager.picture.Picture;

@Controller("photo.photoController")
public class PhotoController {
	@Autowired
	private PhotoService service;
	@Autowired
	private MyUtil myUtil;
	
	@Autowired
	private InsertBoardService navService;
	
	@Autowired
	public CommunityService service2;

	@RequestMapping(value="/photoBoard/list/{boCateNum}/{url}")
	public ModelAndView list(
			@PathVariable String url,
			HttpServletRequest req,
			@RequestParam(value="page", defaultValue="1") int current_page,
			@RequestParam(value="searchKey", defaultValue="subject") String searchKey,
			@RequestParam(value="searchValue", defaultValue="") String searchValue,
			@PathVariable String boCateNum,
			Picture pdto
			) throws Exception{

		//��ǥ���� ��������
		List<Picture> plist=service2.listNonMainPicture(url);
		pdto=service2.readMainPicture(url);
		
		
		String cp = req.getContextPath();

		int numPerPage = 6;
		int total_page;
		int dataCount;

		if(req.getMethod().equalsIgnoreCase("GET")) { // GET ����� ���
			searchValue = URLDecoder.decode(searchValue, "utf-8");
		}
		
        // ��ü ������ ��
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("searchKey", searchKey);
        map.put("searchValue", searchValue);
        map.put("url", url);

		dataCount = service.dataCount(map);
		total_page = myUtil.pageCount(numPerPage, dataCount);

		if (total_page < current_page)
			current_page = total_page;

		int start = (current_page - 1) * numPerPage + 1;
		int end = current_page * numPerPage;

		map.put("start", start);
		map.put("end", end);
		map.put("url", url);

		List<Photo> list = service.listPhoto(map);

		// �۹�ȣ �����
		int listNum, n = 0;
		Iterator<Photo> it = list.iterator();
		while (it.hasNext()) {
			Photo data = it.next();
			listNum = dataCount - (start + n - 1);
			data.setListNum(listNum);
			
			n++;
		}

        String params = "";
        String urlList = cp+"/photoBoard/list/"+boCateNum+"/"+url;
        String urlArticle = cp+"/photoBoard/photoArticle/"+boCateNum+"/"+url+"?page=" + current_page;
        if(searchValue.length()!=0) {
        	params = "searchKey=" +searchKey + 
        	             "&searchValue=" + URLEncoder.encode(searchValue, "utf-8");	
        }
        
        if(params.length()!=0) {
            urlList = cp+"/photoBoard/list/"+boCateNum+"/"+url+"?" + params;
            urlArticle = cp+"/photoBoard/photoArticle"+boCateNum+"/"+url+"?page=" + current_page + "&"+ params;
        }
        
		//�׺���̼� �� �����ϱ�
		//���� �Խ��� �̸� ��������
		Map<String, Object> navMap=new HashMap<>();
		navMap.put("groupURL", url);
		navMap.put("boCateNum", boCateNum);
				
		String boardName=navService.readName(navMap);
		List<InsertBoard> navList=navService.listBoard(navMap);

		
        
		
		ModelAndView mav=new ModelAndView(".community.photo.list");
		mav.addObject("subMenu", "3");
		
		mav.addObject("url",url);
		mav.addObject("list", list);
		mav.addObject("dataCount", dataCount);
		mav.addObject("total_page", total_page);
		mav.addObject("urlArticle", urlArticle);
		mav.addObject("page", current_page);
		mav.addObject("paging",
				myUtil.paging(current_page, total_page, urlList));
		mav.addObject("boardName",boardName);
		mav.addObject("navList", navList);
		mav.addObject("pdto",pdto);
		mav.addObject("plist", plist);
		mav.addObject("boCateNum", boCateNum);
		
		return mav;
	}

	@RequestMapping(value="/photoBoard/photoCreated/{boCateNum}/{url}", 
			method=RequestMethod.GET)
	public ModelAndView createdForm(
			@PathVariable String url,
			HttpSession session,
			@PathVariable String boCateNum,
			Picture pdto
			) throws Exception{
		
		SessionInfo info=
				(SessionInfo)session.getAttribute("main");
		if(info==null) {
			return new ModelAndView("redirect:/group/"+url);
		}
		
		
		//��ǥ���� ��������
		List<Picture> plist=service2.listNonMainPicture(url);
		pdto=service2.readMainPicture(url);
		
		//�׺���̼� �� �����ϱ�
		//���� �Խ��� �̸� ��������
		Map<String, Object> navMap=new HashMap<>();
		navMap.put("groupURL", url);
		navMap.put("boCateNum", boCateNum);
				
		String boardName=navService.readName(navMap);
		List<InsertBoard> navList=navService.listBoard(navMap);
		

		ModelAndView mav=new ModelAndView(".community.photo.created");
		mav.addObject("subMenu", "3");
		mav.addObject("url",url);
		mav.addObject("mode", "created");
		mav.addObject("boardName",boardName); 
		mav.addObject("navList", navList);
		mav.addObject("pdto",pdto);
		mav.addObject("plist", plist);
		mav.addObject("boCateNum", boCateNum);
		
		return mav;
	}
	
	@RequestMapping(value="/photoBoard/photoCreated/{boCateNum}/{url}",
			method=RequestMethod.POST
			)
	public String createdSubmit(
			@PathVariable String url,
			HttpSession session,
			@PathVariable String boCateNum,
			Picture pdto,
			Photo dto
			) throws Exception {
		String root=session.getServletContext().getRealPath("/");
		String path=root+File.separator+"uploads"+File.separator+"photo";
		
		SessionInfo info=(SessionInfo)session.getAttribute("main");
		if(info==null) {
			return "redirect:/group/"+boCateNum+"/"+url;
		}
		
		dto.setUserId(info.getUserId());
		dto.setMemberNo(info.getMemberNo());
		dto.setGroupURL(url);
		service.insertPhoto(dto, path);
		
		return "redirect:/photoBoard/list/"+boCateNum+"/"+url;
	}
	
	@RequestMapping(value="/photoBoard/photoArticle/{boCateNum}/{url}", 
			method=RequestMethod.GET)
	public ModelAndView article(
			@PathVariable String url,
			HttpSession session,
			@RequestParam(value = "photoNo") int photoNo,
			@RequestParam(value = "page") String page,
			@RequestParam(value="searchKey", defaultValue="subject") String searchKey,
			@RequestParam(value="searchValue", defaultValue="") String searchValue,
			@PathVariable String boCateNum,
			Picture pdto
			) throws Exception{
		
		
		SessionInfo info=(SessionInfo)session.getAttribute("main");
		if(info==null) {
			return new ModelAndView("redirect:/group/"+url);
		}
		
		
		//�׺���̼� �� �����ϱ�
		//���� �Խ��� �̸� ��������
		Map<String, Object> navMap=new HashMap<>();
		navMap.put("groupURL", url);
		navMap.put("boCateNum", boCateNum);
				
		String boardName=navService.readName(navMap);
		List<InsertBoard> navList=navService.listBoard(navMap);
        
		//��ǥ���� ��������
		List<Picture> plist=service2.listNonMainPicture(url);
		pdto=service2.readMainPicture(url);
		
		
		Map<String, Object> map=new HashMap<>();
		map.put("photoNo", photoNo);
		map.put("url", url);
		
		Photo dto = service.readPhoto(map);
		if (dto == null)
			return new ModelAndView("redirect:/photoBoard/list/"+url+"?page="+page);
		
		dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
		
		// ���� ��, ���� ��
		
		map.put("searchKey", searchKey);
		map.put("searchValue", searchValue);
		map.put("photoNo", photoNo);
		map.put("url", url);

		Photo preReadDto = service.preReadPhoto(map);
		Photo nextReadDto = service.nextReadPhoto(map);
        
		String params = "page="+page;
		if(searchValue.length()!=0) {
		    params += "&searchKey=" + searchKey + 
		                    "&searchValue=" + URLEncoder.encode(searchValue, "utf-8");
		}
		
		ModelAndView mav=new ModelAndView(".community.photo.article");
		mav.addObject("subMenu", "3");
		
		mav.addObject("dto", dto);
		mav.addObject("preReadDto", preReadDto);
		mav.addObject("nextReadDto", nextReadDto);
		
		mav.addObject("page", page);
		mav.addObject("params", params);
		
		mav.addObject("boardName",boardName); 
		mav.addObject("navList", navList);
		mav.addObject("pdto",pdto);
		mav.addObject("plist", plist);
		mav.addObject("boCateNum", boCateNum);
		
		
		return mav;
	}
	
	@RequestMapping(value="/photoBoard/photoUpdate/{boCateNum}/{url}", 
			method=RequestMethod.GET)
	public ModelAndView updateForm(
			@PathVariable String url,
			HttpSession session,
			@RequestParam(value = "photoNo") int photoNo,
			@RequestParam(value = "page") String page,
			@PathVariable String boCateNum,
			Picture pdto
			) throws Exception{
		
		SessionInfo info=(SessionInfo)session.getAttribute("main");
		if(info==null) {
			return new ModelAndView("redirect:/group/"+boCateNum+"/"+url);
		}
		
		//�׺���̼� �� �����ϱ�
		//���� �Խ��� �̸� ��������
		Map<String, Object> navMap=new HashMap<>();
		navMap.put("groupURL", url);
		navMap.put("boCateNum", boCateNum);
				
		String boardName=navService.readName(navMap);
		List<InsertBoard> navList=navService.listBoard(navMap);
        
		//��ǥ���� ��������
		List<Picture> plist=service2.listNonMainPicture(url);
		pdto=service2.readMainPicture(url);
		
		
		Map<String, Object> map=new HashMap<>();
		map.put("photoNo", photoNo);
		map.put("url", url);
		Photo dto = service.readPhoto(map);
		if (dto == null)
			return new ModelAndView("redirect:/photoBoard/list/"+boCateNum+"/"+url+"?page="+page);

		// ���� ����� ����� ���� ����
		if(! dto.getUserId().equals(info.getUserId())) {
			return new ModelAndView("redirect:/photoBoard/list/"+boCateNum+"/"+url+"?page="+page);
		}
		
		ModelAndView mav=new ModelAndView(".community.photo.created");
		mav.addObject("subMenu", "3");
		
		mav.addObject("dto", dto);
		mav.addObject("page", page);
		mav.addObject("mode", "update");
		mav.addObject("url",url);
		
		mav.addObject("boardName",boardName); 
		mav.addObject("navList", navList);
		mav.addObject("pdto",pdto);
		mav.addObject("plist", plist);
		mav.addObject("boCateNum", boCateNum);
		return mav;
	}
	
	@RequestMapping(value="/photoBoard/photoUpdate/{boCateNum}/{url}",
			method=RequestMethod.POST)
	public String updateSubmit(
			@PathVariable String url,
			HttpSession session,
			Photo dto,
			String page,
			@PathVariable String boCateNum,
			Picture pdto
			) throws Exception {
		String root=session.getServletContext().getRealPath("/");
		String path=root+File.separator+"uploads"+File.separator+"photo";
		
		SessionInfo info=(SessionInfo)session.getAttribute("main");
		if(info==null) {
			return "redirect:/group/"+url;
		}
		
		// �����ϱ�
		dto.setGroupURL(url);
		service.updatePhoto(dto, path);
		
		// return "redirect:/photo/list?page="+page;
		return "redirect:/photoBoard/photoArticle/"+boCateNum+"/"+url+"?photoNo="+dto.getPhotoNo()+"&page="+page;
	}
	
	@RequestMapping(value="/photoBoard/photoDelete/{boCateNum}/{url}",
			method=RequestMethod.GET)
	public String delete(
			@PathVariable String url,
			HttpSession session,
			@RequestParam(value = "photoNo") int photoNo,
			@RequestParam(value = "page") String page,
			@PathVariable String boCateNum,
			Picture pdto
			) throws Exception {
		String root=session.getServletContext().getRealPath("/");
		String path=root+File.separator+"uploads"+File.separator+"photo";
		
		SessionInfo info=(SessionInfo)session.getAttribute("main");
		if(info==null) {
			return "redirect:/group/"+url;
		}
		
		
		Map<String, Object> map=new HashMap<>();
		map.put("photoNo", photoNo);
		map.put("url", url);
		Photo dto = service.readPhoto(map);
		if (dto == null)
			return "redirect:/group/"+url+"?page="+page;

		// admin�� ���� ����� ����� ���� ����
		if( !dto.getUserId().equals(info.getUserId()) && ! info.getUserId().equals("admin")) {
			return "redirect:/group/"+url+"?page="+page;
		}
		// �Խù� �����
		map.put("photoNo", photoNo);
		map.put("url", url);
		service.deletePhoto(map, dto.getImageFilename(), path);
		
		return "redirect:/photoBoard/list/"+boCateNum+"/"+url+"?page="+page;
	}	
	
	// ��� ó��...................................
	// ��� ����Ʈ
	@RequestMapping(value="/photoBoard/photoReply/{boCateNum}/{url}")
	public ModelAndView listReply(
			@PathVariable String url,
			@RequestParam(value="photoNo") int photoNo,
			@RequestParam(value="pageNo", defaultValue="1") int current_page,
			@PathVariable String boCateNum,
			Picture pdto
			) throws Exception {
		
		int numPerPage=5;
		int total_page=0;
		int dataCount=0;
		
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("photoNo", photoNo);
		map.put("url", url);
		dataCount=service.replyDataCount(map);
		total_page=myUtil.pageCount(numPerPage, dataCount);
		if(current_page>total_page)
			current_page=total_page;
		
		// ����Ʈ�� ����� ������
		int start=(current_page-1)*numPerPage+1;
		int end=current_page*numPerPage;
		map.put("start", start);
		map.put("end", end);
		map.put("url", url);
		List<Reply> listReply=service.listReply(map);
		
		// ���͸� <br>
		Iterator<Reply> it=listReply.iterator();
		int listNum, n=0;
		while(it.hasNext()) {
			Reply dto=it.next();
			listNum=dataCount-(start+n-1);
			dto.setListNum(listNum);
			dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
			n++;
		}
		
		// ����¡ó��(�μ�2�� ¥�� js�� ó��)
		String paging=myUtil.paging(current_page, total_page);
		
		ModelAndView mav=new ModelAndView("community/photo/listReply");

		// jsp�� �ѱ� ������
		mav.addObject("listReply", listReply);
		mav.addObject("pageNo", current_page);
		mav.addObject("replyCount", dataCount);
		mav.addObject("total_page", total_page);
		mav.addObject("paging", paging);
		mav.addObject("url",url);
		mav.addObject("pdto",pdto);
		mav.addObject("boCateNum", boCateNum);
		
		return mav;
	}

	// ��ۺ� ��� ����Ʈ
	@RequestMapping(value="/photoBoard/photoReplyAnswer/{boCateNum}/{url}")
	public ModelAndView listReplyAnswer(
			@PathVariable String url,
			@RequestParam(value="answer") int answer,
			@PathVariable String boCateNum,
			Picture pdto
			) throws Exception {
		Map<String, Object> map=new HashMap<>();
		map.put("answer", answer);
		map.put("url", url);
		List<Reply> listReplyAnswer=service.listReplyAnswer(map);
		
		// ���͸� <br>
		Iterator<Reply> it=listReplyAnswer.iterator();
		while(it.hasNext()) {
			Reply dto=it.next();
			dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
		}
		
		ModelAndView mav=new ModelAndView("community/photo/listReplyAnswer");

		// jsp�� �ѱ� ������
		mav.addObject("listReplyAnswer", listReplyAnswer);
		mav.addObject("url",url);
		
		return mav;
	}
	
	// ��ۺ� ��� ����
	@RequestMapping(value="/photoBoard/photoCountAnswer/{boCateNum}/{url}",
			method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> replyCountAnswer(
			@PathVariable String url,
			@RequestParam(value="answer") int answer,
			@PathVariable String boCateNum,
			Picture pdto
			
			) throws Exception {
		
		int count=0;
		Map<String, Object> map=new HashMap<>();
		map.put("url", url);
		map.put("answer", answer);
		count=service.replyCountAnswer(map);
		
   	    // �۾� ����� json���� ����
		Map<String, Object> model = new HashMap<>(); 
		model.put("count", count);
		model.put("url", url);
		return model;
	}
	
	// ��� �� ���ú� ��� �߰�
	@RequestMapping(value="/photoBoard/photoCreatedReply/{boCateNum}/{url}",
			method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> createdReply(
			@PathVariable String url,
			HttpSession session,
			Reply dto,
			@PathVariable String boCateNum,
			Picture pdto
			) throws Exception {
	
		SessionInfo info=(SessionInfo) session.getAttribute("main");
		
		String state="true";
		if(info==null) { // �α����� ���� �ʴ� ���
			state="loginFail";
		} else {
			dto.setUserId(info.getUserId());
			dto.setGroupURL(url);
			dto.setMemberNo(info.getMemberNo());
			int result=service.insertReply(dto);
			if(result==0)
				state="false";
		}
		
   	    // �۾� ����� json���� ����
		Map<String, Object> model = new HashMap<>(); 
		model.put("state", state);
		model.put("url", url);
		return model;
	}
	
	// ��� �� ��ۺ���� ����
	@RequestMapping(value="/photoBoard/photoDeleteReply/{boCateNum}/{url}",
			method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteReply(
			@PathVariable String url,
			HttpSession session,
			@RequestParam(value="commentNo") int commentNo,
			@RequestParam(value="mode") String mode,
			@PathVariable String boCateNum,
			Picture pdto
			) throws Exception {
		SessionInfo info=(SessionInfo) session.getAttribute("main");
		
		String state="true";
		if(info==null) { // �α����� ���� �ʴ� ���
			state="loginFail";
		} else {
			Map<String, Object> map=new HashMap<String, Object>();
			map.put("mode", mode);
			map.put("commentNo", commentNo);
			map.put("url", url);

			// ���ƿ�/�Ⱦ�� �� ON DELETE CASCADE �� �ڵ� ����

            // ��ۻ���
			int result=service.deleteReply(map);

			if(result==0)
				state="false";
		}
		
		// �۾� ����� json���� ����
		Map<String, Object> model = new HashMap<>(); 
		model.put("state", state);
		model.put("url", url);
		return model;
	}
	
	// ���ƿ�/�Ⱦ�� �߰�
	@RequestMapping(value="/photoBoard/photoReplyLike/{boCateNum}/{url}",
			method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> replyLike(
			@PathVariable String url,
			HttpSession session,
			Reply dto,
			@PathVariable String boCateNum,
			Picture pdto
			) throws Exception {
	
		SessionInfo info=(SessionInfo) session.getAttribute("main");
		
		String state="true";
		if(info==null) { // �α����� ���� �ʴ� ���
			state="loginFail";
		} else {
			dto.setUserId(info.getUserId());
			dto.setGroupURL(url);
			dto.setMemberNo(info.getMemberNo());
			int result=service.insertReplyLike(dto);
			if(result==0)
				state="false";
		}
		
		// �۾� ����� json���� ����
		Map<String, Object> model = new HashMap<>(); 
		model.put("state", state);
		model.put("url", url);
		return model;
	}
	
	// ���ƿ�/�Ⱦ�� ����
	@RequestMapping(value="/photoBoard/photoReplyCountLike/{boCateNum}/{url}",
			method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> countLike(
			@PathVariable String url,
			@RequestParam(value="commentNo") int commentNo,
			@PathVariable String boCateNum,
			Picture pdto
			) throws Exception {
		
		int likeCount=0, disLikeCount=0;
		Map<String, Object> map1=new HashMap<>();
		map1.put("url", url);
		map1.put("commentNo", commentNo);
		Map<String, Object> map=service.replyCountLike(map1);
		if(map!=null) {
			// resultType�� map�� ��� int�� BigDecimal�� �Ѿ��
			likeCount=((BigDecimal)map.get("LIKECOUNT")).intValue();
			disLikeCount=((BigDecimal)map.get("DISLIKECOUNT")).intValue();
		}
		
		Map<String, Object> model = new HashMap<>(); 
		model.put("likeCount", likeCount);
		model.put("disLikeCount", disLikeCount);
		model.put("url", url);
		return model;
	}
	
	//�Խù� ���ƿ�,�Ⱦ��
	@RequestMapping(value="/photoBoard/photoBoardLike/{boCateNum}/{url}",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> photoLike(
			@PathVariable String url,
			HttpSession session,
			Photo dto,
			@PathVariable String boCateNum,
			Picture pdto
			)throws Exception{
			SessionInfo info=(SessionInfo) session.getAttribute("main");
		
			String state="true";
			if(info==null) { // �α����� ���� �ʴ� ���
				state="loginFail";
			} else {
				dto.setUserId(info.getUserId());
				dto.setGroupURL(url);
				dto.setMemberNo(info.getMemberNo());
				int result=service.insertPhotoLike(dto);
				if(result==0)
					state="false";
		}
		
			Map<String, Object> model=new HashMap<>();
			model.put("state", state);
			model.put("url", url);
			return model;
	}
	
	// �Խù� ���ƿ�/�Ⱦ�� ����
		@RequestMapping(value="/photoBoard/photoCountLike/{boCateNum}/{url}",
				method=RequestMethod.POST)
		@ResponseBody
		public Map<String, Object> photocountLike(
				@PathVariable String url,
				@RequestParam(value="photoNo") int photoNo,
				@PathVariable String boCateNum,
				Picture pdto
				) throws Exception {
			
			int likeCount=0, disLikeCount=0;
			Map<String, Object> map1=new HashMap<>();
			map1.put("url", url);
			map1.put("photoNo", photoNo);
			Map<String, Object> map=service.photoCountLike(map1);
			if(map!=null) {
				// resultType�� map�� ��� int�� BigDecimal�� �Ѿ��
				likeCount=((BigDecimal)map.get("LIKECOUNT")).intValue();
				disLikeCount=((BigDecimal)map.get("DISLIKECOUNT")).intValue();
			}
			
			Map<String, Object> model = new HashMap<>(); 
			model.put("likeCount", likeCount);
			model.put("disLikeCount", disLikeCount);
			model.put("url", url);
			return model;
		}

}
