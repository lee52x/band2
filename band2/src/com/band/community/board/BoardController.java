package com.band.community.board;

import java.io.File;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
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
import com.band.common.MyUtil;
import com.band.community.CommunityService;
import com.band.main.SessionInfo;
import com.band.manager.insertBoard.InsertBoard;
import com.band.manager.insertBoard.InsertBoardService;
import com.band.manager.picture.Picture;

@Controller("board.boardController")
public class BoardController {
	@Autowired
	private BoardService service;
	@Autowired
	private MyUtil myUtil;
	@Autowired
	private FileManager fileManager;
	
	@Autowired
	public CommunityService service2;
	
	@Autowired
	private InsertBoardService navService;

	@RequestMapping(value = "/freeBoard/list/{boCateNum}/{url}")
	public ModelAndView list(
			HttpServletRequest req, 
			@RequestParam(value = "page", defaultValue = "1") int current_page,
			@RequestParam(value = "searchKey", defaultValue = "subject") String searchKey,
			@RequestParam(value = "searchValue", defaultValue = "") String searchValue, 
			@PathVariable String url,
			@PathVariable String boCateNum,
			InsertBoard idto,
			Picture pdto
			)throws Exception {
		
		//��ǥ���� ��������
		List<Picture> plist=service2.listNonMainPicture(url);
		pdto=service2.readMainPicture(url);
		
		
		String cp = req.getContextPath();

		int numPerPage = 10; // �� ȭ�鿡 �����ִ� �Խù� ��
		int total_page = 0;
		int dataCount = 0;

		if (req.getMethod().equalsIgnoreCase("GET")) { // GET ����� ���
			searchValue = URLDecoder.decode(searchValue, "utf-8");
		}

		// ��ü ������ ��
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("searchKey", searchKey);
		map.put("searchValue", searchValue);
		map.put("url", url);

		dataCount = service.dataCount(map);
		if (dataCount != 0)
			total_page = myUtil.pageCount(numPerPage, dataCount);

		// �ٸ� ����� �ڷḦ �����Ͽ� ��ü ���������� ��ȭ �� ���
		if (total_page < current_page)
			current_page = total_page;

		// ����Ʈ�� ����� �����͸� ��������
		int start = (current_page - 1) * numPerPage + 1;
		int end = current_page * numPerPage;
		map.put("start", start);
		map.put("end", end);

		// �� ����Ʈ
		List<Board> list = service.listBoard(map);

		// ����Ʈ�� ��ȣ
		int listNum, n = 0;
		Iterator<Board> it = list.iterator();
		while (it.hasNext()) {
			Board data = it.next();
			listNum = dataCount - (start + n - 1);
			data.setListNum(listNum);
			n++;
		}

		String params = "";
		String urlList = cp + "/freeBoard/"+boCateNum+"/list/" + url;
		String urlArticle = cp + "/freeBoard/article/" + url + "?page=" + current_page;
		if (searchValue.length() != 0) {
			params = "searchKey=" + searchKey + "&searchValue=" + URLEncoder.encode(searchValue, "utf-8");
		}

		if (params.length() != 0) {
			urlList = cp + "/freeBoard/"+boCateNum+"/list/" + url + "?" + params;
			urlArticle = cp + "/freeBoard/article/" + url + "?page=" + current_page + "&" + params;

		}

		
		//�׺���̼� �� �����ϱ�
		//���� �Խ��� �̸� ��������
		Map<String, Object> navMap=new HashMap<>();
		navMap.put("groupURL", url);
		navMap.put("boCateNum", boCateNum);
		
		String boardName=navService.readName(navMap);
		List<InsertBoard> navList=navService.listBoard(navMap);
        
		
		
		ModelAndView mav = new ModelAndView(".community.board.list");
		mav.addObject("subMenu", "2");
		mav.addObject("list", list);
		mav.addObject("urlArticle", urlArticle);
		mav.addObject("page", current_page);
		mav.addObject("dataCount", dataCount);
		mav.addObject("total_page", total_page);
		mav.addObject("paging", myUtil.paging(current_page, total_page, urlList));
		mav.addObject("boardName",boardName);
		mav.addObject("navList", navList);
		mav.addObject("pdto",pdto);
		mav.addObject("plist", plist);

		return mav;

	}

	@RequestMapping(value = "/freeBoard/created/{boCateNum}/{url}", method = RequestMethod.GET)
	public ModelAndView createdForm(
			HttpSession session,
			@PathVariable String url,
			@PathVariable String boCateNum,
			InsertBoard idto,
			Picture pdto
			
			) throws Exception {
		 SessionInfo info=(SessionInfo)session.getAttribute("main");
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
		 
		 
		ModelAndView mav = new ModelAndView(".community.board.created");
		mav.addObject("subMenu", "2");
		mav.addObject("mode", "created");
		mav.addObject("url", url);
		mav.addObject("boardName",boardName);
		mav.addObject("navList", navList);
		mav.addObject("pdto",pdto);
		mav.addObject("plist", plist);
		return mav;
	}

	@RequestMapping(value = "/freeBoard/created/{url}", method = RequestMethod.POST)
	public ModelAndView createdSubmit(HttpSession session, @PathVariable String url, Board dto) throws Exception {

		 SessionInfo info=(SessionInfo)session.getAttribute("main");
		 if(info==null) {
		 return new ModelAndView("redirect:/group/"+url);
		 }
		String root = session.getServletContext().getRealPath("/");
		String path = root + File.separator + "uploads" + File.separator + "board";

		dto.setMemberNo(info.getMemberNo());
		dto.setUserId(info.getUserId());
		
		service.insertBoard(dto, path);
		
		//�ؽ��±� ����� �ؽ��±� DB�� ����
		if(dto.getContent().indexOf('#')!=-1){
		String content=dto.getContent().substring(dto.getContent().indexOf("#"));
		content=content.substring(0, content.indexOf("</"));
		String[] hashName= content.split("#");
		for(int i=0; i<hashName.length; i++){
			if(i==0)
				continue;
			
			service.insertHash(hashName[i]);
		}
		}
		

		return new ModelAndView("redirect:/freeBoard/list/"+url);
	}

	/*
	 * @RequestMapping(value="/bbs/download") public void download(
	 * HttpServletRequest req, HttpServletResponse resp, HttpSession session,
	 * 
	 * @RequestParam(value="num") int num ) throws Exception{ String
	 * cp=req.getContextPath();
	 * 
	 * SessionInfo info=(SessionInfo)session.getAttribute("member");
	 * if(info==null) { resp.sendRedirect(cp+"/member/login"); return; }
	 * 
	 * String root=session.getServletContext().getRealPath("/"); String
	 * path=root+File.separator+"uploads"+File.separator+"bbs"; Board
	 * dto=service.readBoard(num); boolean flag=false;
	 * 
	 * if(dto!=null) { flag=fileManager.doFileDownload( dto.getSaveFilename(),
	 * dto.getOriginalFilename(), path, resp); }
	 * 
	 * if(! flag) { resp.setContentType("text/html;charset=utf-8"); PrintWriter
	 * out=resp.getWriter(); out.print(
	 * "<script>alert('���� �ٿ�ε尡 �����߽��ϴ�.');history.back();</script>"); } }
	 */
	@RequestMapping(value = "/freeBoard/article/{url}")
	public ModelAndView article(
			HttpSession session, 
			@RequestParam(value = "boardNo") int boardNo,
			@RequestParam(value = "page") String page,
			@RequestParam(value = "searchKey", defaultValue = "subject") String searchKey,
			@RequestParam(value = "searchValue", defaultValue = "") String searchValue,
			@PathVariable String url)
			throws Exception {

		 SessionInfo info=(SessionInfo)session.getAttribute("main");
		 if(info==null) {
		 return new ModelAndView("redirect:/group/{url}");
		 }
		searchValue = URLDecoder.decode(searchValue, "utf-8");

		// ��ȸ�� ����
		service.updateHitCount(boardNo);

		// �ش� ���ڵ� ���� ����
		Board dto = service.readBoard(boardNo);
		// if(dto==null)
		// return new ModelAndView("redirect:/community/list/{url}?page="+page);

		// ��ü ���μ�
		// int linesu = dto.getContent().split("\n").length;

		// ����Ʈ�����͸� ����ϹǷ� ���͸� <br>�� �������� ����
		dto.setContent(dto.getContent().replaceAll("\n", "<br>"));

		// ���� ��, ���� ��
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("searchKey", searchKey);
		map.put("searchValue", searchValue);
		map.put("boardNo", boardNo);

		Board preReadDto = service.preReadBoard(map);
		Board nextReadDto = service.nextReadBoard(map);

		String params = "page=" + page;
		if (searchValue.length() != 0) {
			params += "&searchKey=" + searchKey + "&searchValue=" + URLEncoder.encode(searchValue, "utf-8");
		}

		ModelAndView mav = new ModelAndView(".community.board.article");
		mav.addObject("subMenu", "2");

		mav.addObject("dto", dto);
		mav.addObject("preReadDto", preReadDto);
		mav.addObject("nextReadDto", nextReadDto);
		mav.addObject("url",url);
		mav.addObject("page", page);
		mav.addObject("params", params);

		return mav;
	}

	@RequestMapping(value = "/freeBoard/update/{url}", method = RequestMethod.GET)
	public ModelAndView updateForm(
			HttpSession session,
			@RequestParam(value = "boardNo") int boardNo,
			@RequestParam(value = "page") String page,
			@PathVariable String url
			) throws Exception {
		 SessionInfo info=(SessionInfo)session.getAttribute("main");
		 if(info==null) {
		 return new ModelAndView("redirect:/group/"+url);
		 }
		Board dto = (Board) service.readBoard(boardNo);
		if (dto == null) {
			return new ModelAndView("redirect:/freeBoard/list/"+url+"?page=" + page);
		}

		if (!info.getUserId().equals(dto.getUserId())) {
			return new ModelAndView("redirect:/freeBoard/list/"+url+"?page=" + page);
		}

		ModelAndView mav = new ModelAndView(".community.board.created");
		mav.addObject("subMenu", "2");
		mav.addObject("dto", dto);
		mav.addObject("mode", "update");
		mav.addObject("page", page);
		mav.addObject("url","url");
		
		return mav;
	}

	@RequestMapping(value = "/freeBoard/update/{url}", method = RequestMethod.POST)
	public ModelAndView updateSubmit(HttpSession session, Board dto, @RequestParam(value = "page") String page,
			@PathVariable String url) throws Exception {

		 SessionInfo info=(SessionInfo)session.getAttribute("main");
		 if(info==null) {
		 return new ModelAndView("redirect:/group/"+url);
		 }
		String root = session.getServletContext().getRealPath("/");
		String path = root + File.separator + "uploads" + File.separator + "board";

		// ���� �ϱ�
		service.updateBoard(dto, path);

		return new ModelAndView("redirect:/freeBoard/list/"+url+"?page=" + page);
	}

	/*
	 * @RequestMapping(value="/community/deleteFile/{url}",
	 * method=RequestMethod.GET) public ModelAndView deleteFile( HttpSession
	 * session,
	 * 
	 * @RequestParam(value="boardNo") int boardNo,
	 * 
	 * @RequestParam(value="page") String page,
	 * 
	 * @PathVariable String url ) throws Exception { SessionInfo
	 * info=(SessionInfo)session.getAttribute("main"); // if(info==null) { //
	 * return new ModelAndView("redirect:/member/login"); // } // Board dto =
	 * service.readBoard(boardNo); // if(dto==null) { // return new
	 * ModelAndView("redirect:/bbs/list?page="+page); // } // // if(!
	 * info.getUserId().equals(dto.getUserId())) { // return new
	 * ModelAndView("redirect:/bbs/list?page="+page); // }
	 * 
	 * String root = session.getServletContext().getRealPath("/"); String path =
	 * root + File.separator + "uploads" + File.separator + "bbs";
	 * if(dto.getSaveFilename() != null && dto.getSaveFilename().length()!=0) {
	 * fileManager.doFileDelete(dto.getSaveFilename(), path);
	 * 
	 * dto.setSaveFilename(""); dto.setOriginalFilename("");
	 * service.updateBoard(dto, path); }
	 * 
	 * return new
	 * ModelAndView("redirect:/board/update/{url}?boardNo="+boardNo+"&page="+
	 * page); }
	 */
	@RequestMapping(value = "/freeBoard/delete/{url}")
	public ModelAndView delete(HttpSession session, @RequestParam(value = "boardNo") int boardNo,
			@RequestParam(value = "page") String page, @PathVariable String url

	) throws Exception {
		 SessionInfo info=(SessionInfo)session.getAttribute("main");
		 if(info==null) {
		 return new ModelAndView("redirect:/group/"+url);
		 }
		// �ش� ���ڵ� ���� ����
		Board dto = service.readBoard(boardNo);
		if (dto == null) {
			return new ModelAndView("redirect:/freeBoard/list/"+url+"?page=" + page);
		}

		if (!info.getUserId().equals(dto.getUserId()) && !info.getUserId().equals("admin")) {
			return new ModelAndView("redirect:/freeBoard/list/"+url+"?page=" + page);
		}

		String root = session.getServletContext().getRealPath("/");
		String path = root + File.separator + "uploads" + File.separator + "board";

		service.deleteBoard(boardNo, dto.getSaveFilename(), path);

		return new ModelAndView("redirect:/freeBoard/list/"+url+"?page=" + page);
	}
	
	// -------------------------------------------------------------------------
		// ��� ����Ʈ
		@RequestMapping(value="/freeBoard/listReply/{url}")
		
		public ModelAndView listReply(
				@RequestParam(value="boardNo") int boardNo,
				@RequestParam(value="pageNo", defaultValue="1") int current_page,
				@PathVariable String url
				
				) throws Exception {
			
			int numPerPage=5;
			int total_page=0;
			int dataCount=0;
			
			dataCount=service.dataCountReply(boardNo);
			total_page=myUtil.pageCount(numPerPage, dataCount);
			if(current_page>total_page)
				current_page=total_page;
			
			int start=(current_page-1)*numPerPage+1;
			int end=current_page*numPerPage;
			
			// ����Ʈ�� ����� ������
			Map<String, Object> map=new HashMap<String, Object>();
			map.put("boardNo", boardNo);
			map.put("start", start);
			map.put("end", end);
			map.put("url", url);
			
			
			List<Reply> list=service.listReply(map);
			
			// ���͸� <br>
			Iterator<Reply> it=list.iterator();
			while(it.hasNext()) {
				Reply dto=it.next();
				dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
			}
			
			// ����¡ó��(�μ�2�� ¥�� js�� ó��)
			String paging=myUtil.paging(current_page, total_page);
			
			ModelAndView mav=new ModelAndView("community/board/listReply");

			// jsp�� �ѱ� ������
			mav.addObject("url",url);
			mav.addObject("list", list);
			mav.addObject("pageNo", current_page);
			mav.addObject("dataCount", dataCount);
			mav.addObject("paging", paging);
			
			return mav;
		}

		// ���� �߰�
		@RequestMapping(value="/freeBoard/insertReply/{url}",
				method=RequestMethod.POST)
		@ResponseBody
		public Map<String, Object> insertReply(
				HttpServletResponse resp,
				HttpSession session,
				Reply dto,
				@PathVariable String url
				) throws Exception {
		
			SessionInfo info=(SessionInfo)session.getAttribute("main");
			
		
			String state="true";
			if(info==null) { // �α����� ���� �ʴ� ���
				state="loginFail";
			} else {
				dto.setUserId((info.getUserId()));
				dto.setMemberNo(info.getMemberNo());
				
				int result=service.insertReply(dto);
				if(result==0)
					state="false";
			}
			
			Map<String, Object> model=new HashMap<>();
			model.put("state",state);
			return model;
		}
		//��� ����
		@RequestMapping(value="/freeBoard/deleteReply/{url}",method=RequestMethod.POST)
		@ResponseBody
		public Map<String, Object> deleteReply(
				HttpSession session,
				@RequestParam(value="replyNum") int replyNum,
				@PathVariable String url
				
				)throws Exception{
			SessionInfo info=(SessionInfo)session.getAttribute("main");
			
			String state="true";
			if(info==null){
				state="loginFail";
			}else{
				int result=service.deleteReply(replyNum);
				if(result==0)
					state="false";
			}
		Map<String, Object> model=new HashMap<>();
		model.put("state", state);
		return model;
}
}
