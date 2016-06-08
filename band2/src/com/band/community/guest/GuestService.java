package com.band.community.guest;

import java.util.List;
import java.util.Map;

public interface GuestService {
	public int insertGuest(Guest dto);
	public List<Guest> listGuest(Map<String, Object> map);
	public int dataCount(String url);
	public int deleteGuest(Map<String, Object> map);
}
