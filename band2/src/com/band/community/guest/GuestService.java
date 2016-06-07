package com.band.community.guest;

import java.util.List;
import java.util.Map;


public interface GuestService {
	public int insertGuest(Guest dto, String pathname);
	public List<Guest> listGuest(Map<String, Object> map);
	public int dataCount();
	public int deleteGuest(int guestNo,String pathname,String imageFilename);
	
	
	public int insertReply(GuestReply dto);
	public int insertGuestLike(Guest dto);
	public Map<String, Object> guestCountLike(int guestNo);
}

	

