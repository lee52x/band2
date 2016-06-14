package com.band.community.guest;


import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.band.common.FileManager;
import com.band.common.dao.CommonDAO;


@Service("guest.guestService")
public class GuestServiceImpl implements GuestService{
	@Autowired
	private CommonDAO  dao;
	@Autowired
	private FileManager fileManager;
	
	@Override
	public int insertGuest(Guest dto, String pathname) {
		int result=0;
		try{
			if(dto.getUpload()!=null && ! dto.getUpload().isEmpty()) {
				String imageFilename=fileManager.doFileUpload(dto.getUpload(), pathname);
				dto.setImageFilename(imageFilename);
				
			}
			result=dao.insertData("guest.insertGuest", dto);
		} catch(Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public List<Guest> listGuest(Map<String, Object> map) {
		List<Guest> list=null;
		
		try{
			list=dao.getListData("guest.guestList", map);
		} catch(Exception e) {
			System.out.println(e.toString());
		}
		
		return list;
	}

	@Override
	public int dataCount() {
		int result=0;
		
		try{
			result=dao.getIntValue("guest.dataCount");			
		} catch(Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}

	@Override
	public int deleteGuest(int guestNo, String pathname,String imageFilename) {
		int result=0;

		try{
			dao.deleteData("guest.deleteGuest", guestNo);
			result=1;
		} catch(Exception e) {
		}
		return result;

	}

	@Override
	public int insertGuestLike(Guest dto) {
		int result=0;
		try {
			result=dao.insertData("guest.insertGuestLike", dto);
		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return result;
	}

	@Override
	public Map<String, Object> guestCountLike(int guestNo) {
		Map<String, Object> map=null;
		try {
			map=dao.getReadData("guest.guestCountLike",guestNo);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return map;
	}

	@Override
	public int insertReply(GuestReply dto) {
		int result=0;
		try {
			result=dao.insertData("guest.insertReply", dto);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public List<Guest> listReplyAnswer(Map<String, Object> map) {
	List<Guest> listReplyAnswer=null;
		
		try{
			listReplyAnswer=dao.getListData("guest.listReplyAnswer", map);
		} catch(Exception e) {
			System.out.println(e.toString());
		}
		
		return listReplyAnswer;
	}




}
