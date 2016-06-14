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
		
		//대표사진 가져오기
		List<Picture> plist=service2.listNonMainPicture(url);
		pdto=service2.readMainPicture(url);
		
		
		String cp = req.getContextPath();

		int numPerPage = 10; // 한 화면에 보여주는 게시물 수
		int total_page = 0;
		int dataCount = 0;

		if (req.getMethod().equalsIgnoreCase("GET")) { // GET 방식인 경우
			searchValue = URLDecoder.decode(searchValue, "utf-8");
		}

		// 전체 페이지 수
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("searchKey", searchKey);
		map.put("searchValue", searchValue);
		map.put("url", url);

		dataCount = service.dataCount(map);
		if (dataCount != 0)
			total_page = myUtil.pageCount(numPerPage, dataCount);

		// 다른 사람이 자료를 삭제하여 전체 페이지수가 변화 된 경우
		if (total_page < current_page)
			current_page = total_page;

		// 리스트에 출력할 데이터를 가져오기
		int start = (current_page - 1) * numPerPage + 1;
		int end = current_page * numPerPage;
		map.put("start", start);
		map.put("end", end);

		// 글 리스트
		List<Board> list = service.listBoard(map);

		// 리스트의 번호
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

		
		//네비게이션 바 조정하기
		//동적 게시판 이름 가져오기
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
		
			//대표사진 가져오기
			List<Picture> plist=service2.listNonMainPicture(url);
			pdto=service2.readMainPicture(url);
		 
		 
			//네비게이션 바 조정하기
			//동적 게시판 이름 가져오기
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
		
		//해쉬태그 존재시 해쉬태그 DB에 삽입
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
	 * "<script>alert('파일 다운로드가 실패했습니다.');history.back();</script>"); } }
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

		// 조회수 증가
		service.updateHitCount(boardNo);

		// 해당 레코드 가져 오기
		Board dto = service.readBoard(boardNo);
		// if(dto==null)
		// return new ModelAndView("redirect:/community/list/{url}?page="+page);

		// 전체 라인수
		// int linesu = dto.getContent().split("\n").length;

		// 스마트에디터를 사용하므로 엔터를 <br>로 변경하지 않음
		dto.setContent(dto.getContent().replaceAll("\n", "<br>"));

		// 이전 글, 다음 글
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

		// 수정 하기
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
		// 해당 레코드 가져 오기
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
		// 댓글 리스트
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
			
			// 리스트에 출력할 데이터
			Map<String, Object> map=new HashMap<String, Object>();
			map.put("boardNo", boardNo);
			map.put("start", start);
			map.put("end", end);
			map.put("url", url);
			
			
			List<Reply> list=service.listReply(map);
			
			// 엔터를 <br>
			Iterator<Reply> it=list.iterator();
			while(it.hasNext()) {
				Reply dto=it.next();
				dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
			}
			
			// 페이징처리(인수2개 짜리 js로 처리)
			String paging=myUtil.paging(current_page, total_page);
			
			ModelAndView mav=new ModelAndView("community/board/listReply");

			// jsp로 넘길 데이터
			mav.addObject("url",url);
			mav.addObject("list", list);
			mav.addObject("pageNo", current_page);
			mav.addObject("dataCount", dataCount);
			mav.addObject("paging", paging);
			
			return mav;
		}

		// 리플 추가
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
			if(info==null) { // 로그인이 되지 않는 경우
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
		//댓글 삭제
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
