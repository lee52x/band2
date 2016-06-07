package com.band.manager.notice;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.band.common.dao.CommonDAO;

@Service("manager.notice.noticeService")
public class NoticeServiceImpl implements NoticeService{

	@Autowired
	private CommonDAO dao;
	
	@Override
	public int insertNotice(Notice dto) {
		int result=0;
		
		try {
			result=dao.insertData("notice.insertNotice", dto);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result=0;
		
		try {
			result=dao.getIntValue("notice.dataCount",map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}

	@Override
	public List<Notice> listNotice(Map<String, Object> map) {
		List<Notice> list=null;
		try {
			list=dao.getListData("notice.listNotice", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return list;
	}

	@Override
	public List<Notice> listNoticeTop() {
		List<Notice> list=null;
		
		try {
			list=dao.getListData("");
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return list;
	}

	@Override
	public int updateHitCount(int noticeNo) {
		int result=0;
		
		try {
			result=dao.getIntValue("notice.hitCount",noticeNo);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}


	@Override
	public int updateNotice(Notice dto) {
		int result=0;
		
		try {
			result=dao.updateData("notice.updateNotice", dto);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}

	@Override
	public int deleteNotice(int noticeNo) {
		int result=0;
		
		try {
			dao.deleteData("notice.deleteNotice", noticeNo);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}




	
}
