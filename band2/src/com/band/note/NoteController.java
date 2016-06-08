package com.band.note;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.band.main.SessionInfo;

@Controller("note.noteController")
public class NoteController {
	@Autowired
	private NoteService service;
	
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping(value="/community/note/{url}")
	public ModelAndView note(
			@PathVariable String url,
			HttpSession session) throws Exception {
		SessionInfo info = (SessionInfo) session.getAttribute("main");

		if (info == null) {
			return new ModelAndView("redirect:/group/"+url);
		}
		
		ModelAndView mav=new ModelAndView(".community.note.note");
		mav.addObject("subMenu", "5");
		mav.addObject("url",url);
		
		return mav;
	}

	// --------------------------------------------------------
	@RequestMapping(value="/community/noteList/{url}")
	public ModelAndView list(
			@PathVariable String url,
			HttpSession session,
			@RequestParam(value="mode") String mode,
			@RequestParam(value="pageNo", defaultValue="1")int current_page,
			@RequestParam(value="searchKey", defaultValue="") String searchKey,
			@RequestParam(value="searchValue", defaultValue="") String searchValue
			) throws Exception {
		// ���� ���� ����Ʈ / ���� ���� ����Ʈ - �ʱ� �� 
		SessionInfo info = (SessionInfo) session.getAttribute("main");

		if (info == null) {
			return new ModelAndView("community/note/loginFail");
		}
		
		if(searchKey.length()==0) {
			searchKey="sendUserName";
			if(mode.equals("send"))
				searchKey="receiveUserName";
		}

		ModelAndView mav=new ModelAndView("community/note/list");
		mav.addObject("mode", mode);
		mav.addObject("pageNo", current_page);
		mav.addObject("searchKey", searchKey);
		mav.addObject("searchValue", searchValue);
		mav.addObject("url",url);
		return mav;
	}
	
	// ���� ���� ����Ʈ / ���� ���� ����Ʈ
	@RequestMapping(value="/community/listNote/{url}")
	@ResponseBody
	public Map<String, Object>  listNote(
			@PathVariable String url,
			HttpSession session,
			@RequestParam(value="mode") String mode,
			@RequestParam(value="pageNo", defaultValue="1")int current_page,
			@RequestParam(value="searchKey", defaultValue="") String searchKey,
			@RequestParam(value="searchValue", defaultValue="") String searchValue
			) throws Exception {
		// ���� ���� ����Ʈ
		SessionInfo info = (SessionInfo) session.getAttribute("main");

		if(info==null) {
			Map<String, Object> model = new HashMap<>(); 
			model.put("isLogin", "false");
			return model;
		}

		int numPerPage=10;
		int total_page=0;
		int dataCount=0;
		
		// ��ü �Խù��� ��
       Map<String, Object> map = new HashMap<String, Object>();
       map.put("searchKey", searchKey);
       map.put("searchValue", searchValue);
       map.put("memberNo", info.getMemberNo());
       map.put("url", url);
       
       if(mode.equals("listReceive")) {
    	   dataCount=service.dataCountReceive(map);
       } else {
    	   dataCount=service.dataCountSend(map);
       }
		
		// ��ü��������
		total_page=myUtil.pageCount(numPerPage, dataCount);
		
		if(current_page>total_page)
			current_page=total_page;
		
		// ����Ʈ
		int start=numPerPage*(current_page-1)+1;
		int end=numPerPage*current_page;
		
		map.put("start", start);
		map.put("end", end);
		map.put("url", url);
		
		List<Note> list=null;
        if(mode.equals("listReceive")) {
        	list=service.listReceive(map);
        } else {
	    	list=service.listSend(map);
        }
        for(Note dto:list) {
        	if(dto.getIdentifyDay()==null)
        		dto.setIdentifyDay("");
        }
        
		String paging=myUtil.paging(current_page, total_page);
		
		// �۾� ����� JSON���� ����
		Map<String, Object> model = new HashMap<>(); 
		model.put("isLogin", "true");
		
		model.put("mode", mode);
		model.put("list", list);
		model.put("dataCount", dataCount);
		model.put("pageNo", current_page);
		model.put("paging", paging);
		model.put("searchKey", searchKey);
		model.put("searchValue", searchValue);
		model.put("url", url);
		
		return model;
	}

	// --------------------------------------------------------
	@RequestMapping(value="/community/noteSend/{url}", method=RequestMethod.GET)
	public ModelAndView send(
			@PathVariable String url,
			HttpSession session) throws Exception {
		// ���� ������ ��
		SessionInfo info = (SessionInfo) session.getAttribute("main");

		if (info == null) {
			return new ModelAndView("community/note/loginFail");
		}
		
		return new ModelAndView("community/note/send");
	}
	
	@RequestMapping(value="/community/noteSend/{url}", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object>  sendSubmit(
			@PathVariable String url,
			HttpSession session, Note dto) throws Exception{
		// ���� ������
		SessionInfo info=(SessionInfo)session.getAttribute("main");
		if(info==null) {
			Map<String, Object> model = new HashMap<>(); 
			model.put("isLogin", "false");
			return model;
		}
		
		String state="false";
		try {
			for(String userId : dto.getUserIds()) {
				dto.setSendUserId(info.getUserId());
				dto.setReceiveUserId(userId);
			
				service.insertNode(dto);
			}
			state="true";
		}catch(Exception e) {
		}
		
		// �۾� ����� JSON���� ����
		Map<String, Object> model = new HashMap<>(); 
		model.put("isLogin", "true");
		model.put("state", state);
		return model;
	}
	
	// ģ�� ����Ʈ
	@RequestMapping(value="/community/listFriend/{url}")
	public ModelAndView listFriend(
			@PathVariable String url,
			HttpSession session) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("main");
		
		if (info == null) {
			return new ModelAndView("redirect:/group/"+url);
		}
		Map<String, Object> map=new HashMap<>();
		map.put("userId", info.getUserId());
		map.put("url", url);
		List<Note> list=service.listFriend(map);
		
		ModelAndView mav=new ModelAndView("community/note/listFriend");
		mav.addObject("listFriend", list);
		mav.addObject("url",url);
		return mav;
	}

	// ����Ʈ���� ���õ� ���� �����
	@RequestMapping(value="/community/noteDeleteChk/{url}", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object>  noteDeleteChk(
			@PathVariable String url,
			HttpSession session,
			Note note,
			@RequestParam(value="mode") String mode,
			@RequestParam(value="pageNo", defaultValue="1")int current_page,
			@RequestParam(value="searchKey", defaultValue="") String searchKey,
			@RequestParam(value="searchValue", defaultValue="") String searchValue) throws Exception{
		// ���� �����
		SessionInfo info=(SessionInfo)session.getAttribute("main");
		if(info==null) {
			Map<String, Object> model = new HashMap<>(); 
			model.put("isLogin", "false");
			return model;
		}
		
		Map<String, Object> map=new HashMap<String, Object>();
		
		if(mode.equals("listReceive")) {
			map.put("field1", "receiveDelete");
			map.put("field2", "sendDelete");
		} else {
			map.put("field1", "sendDelete");
			map.put("field2", "receiveDelete");
		}
		map.put("numList", note.getNums());
		
		service.deleteNote(map);
		
		return listNote(url,session, mode, current_page, searchKey, searchValue);
	}
	
	@RequestMapping(value="/community/noteArticle/{url}", method=RequestMethod.POST)
	public ModelAndView article(
			@PathVariable String url,
			HttpSession session,
			@RequestParam(value="messageNo") int messageNo,
			@RequestParam(value="mode") String mode,
			@RequestParam(value="pageNo", defaultValue="1") String pageNo,
			@RequestParam(value="searchKey", defaultValue="") String searchKey,
			@RequestParam(value="searchValue", defaultValue="") String searchValue
			) throws Exception {
		// ���� ���� / ���� ���� - �ۺ��� 
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		if (info == null) {
			return new ModelAndView("menu5/note/loginFail");
		}
		
		Map<String, Object> map=new HashMap<String, Object>();
	    map.put("searchKey", searchKey);
	    map.put("searchValue", searchValue);
	    map.put("userId", info.getUserId());
	    map.put("messageNo", messageNo);
		
		Note dto=null;
		Note replyDto=null;
		Note preDto=null;
		Note nextDto=null;
		if(mode.equals("listSend")) { // ���� ���� ����
			dto=service.readSend(messageNo);
			replyDto=service.readReplyReceive(messageNo);
			preDto=service.preReadSend(map);
			nextDto=service.nextReadSend(map);
		} else {// ���� ���� ����(listReceive)
			// Ȯ�� ���·� ����
			service.updateIdentifyDay(messageNo);
			dto=service.readReceive(messageNo);
			replyDto=service.readReplyReceive(messageNo);
			preDto=service.preReadReceive(map);
			nextDto=service.nextReadReceive(map);
		}

		if(dto==null) {
			int current_page = Integer.parseInt(pageNo);
			return list(url,session, mode, current_page, searchKey, searchValue);
		}
		
		dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
		
		ModelAndView mav=new ModelAndView("menu5/note/article");
		
		mav.addObject("dto", dto);
		mav.addObject("replyDto", replyDto);
		mav.addObject("preDto", preDto);
		mav.addObject("nextDto", nextDto);
		
		mav.addObject("mode", mode);
		mav.addObject("pageNo", pageNo);
		mav.addObject("searchKey", searchKey);
		mav.addObject("searchValue", searchValue);
		mav.addObject("url",url);
		
		return mav;
	}

	@RequestMapping(value="/community/updateIdentify/{url}", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object>  updateIdentify(
			@PathVariable String url,
			HttpSession session,
			int messageNo
			) throws Exception{
		// ���� ���⿡�� �亯�� Ȯ�� �� ��� ���� ���·� �����
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		if(info==null) {
			Map<String, Object> model = new HashMap<>(); 
			model.put("isLogin", "false");
			return model;
		}
		
		service.updateIdentifyDay(messageNo);
		
		// �۾� ����� JSON���� ����
		Map<String, Object> model = new HashMap<>(); 
		model.put("isLogin", "true");
		model.put("state", "true");
		model.put("url", url);
		return model;
	}
	
	@RequestMapping(value="/community/noteDelete/{url}", method=RequestMethod.POST)
	public ModelAndView delete(
			@PathVariable String url,
			HttpSession session,
			Note dto,
			@RequestParam(value="mode") String mode,
			@RequestParam(value="pageNo", defaultValue="1") String pageNo,
			@RequestParam(value="searchKey", defaultValue="") String searchKey,
			@RequestParam(value="searchValue", defaultValue="") String searchValue
			) throws Exception {
		// �ۺ��⿡�� - ���� ���� / ���� ���� - �ۻ���
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		if (info == null) {
			return new ModelAndView("menu5/note/loginFail");
		}
		
		Map<String, Object> map=new HashMap<String, Object>();
		
		if(mode.equals("listReceive")) {
			map.put("field1", "receiveDelete");
			map.put("field2", "sendDelete");
		} else {
			map.put("field1", "sendDelete");
			map.put("field2", "receiveDelete");
		}
		
		map.put("numList", dto.getNums());
		
		service.deleteNote(map);
		
		int current_page = Integer.parseInt(pageNo);
		return list(url,session, mode, current_page, searchKey, searchValue);
	}
	
}
