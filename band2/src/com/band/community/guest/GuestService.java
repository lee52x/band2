package com.band.community.guest;

import java.util.List;
import java.util.Map;


public interface GuestService {
	public int insertGuest(Guest dto, String pathname);
	public List<Guest> listGuest(Map<String, Object> map);
	public List<Guest> listReplyAnswer(Map<String, Object> map);
	public int dataCount();
	public int deleteGuest(Map<String, Object> map,String pathname,String imageFilename);
	
	
	public int insertReply(GuestReply dto);
	public int insertGuestLike(Guest dto);
	public Map<String, Object> guestCountLike(Map<String, Object> map);
}

	

