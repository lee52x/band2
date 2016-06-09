package com.band.community;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.band.common.dao.CommonDAO;
import com.band.manager.notice.Notice;
import com.band.manager.picture.Picture;

@Service("community.communityService")
public class CommunityServiceImpl implements CommunityService{

	@Autowired
	public CommonDAO dao;
	
	@Override
	public List<Picture> listNonMainPicture(String url) {
		List<Picture> list=null;
		try {
			list=dao.getListData("picture.listNonMainPicture", url);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}
	

	@Override
	public Picture readMainPicture(String url) {
		Picture dto=null;
		try {
			dto=dao.getReadData("picture.readMainPicture", url);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return dto;
	}

	@Override
	public List<Notice> listCommunityNotice(Map<String, Object> map) {
		List<Notice> list=null;
		try {
			list=dao.getListData("notice.listCommunityNotice",map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return list;
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


	
}
