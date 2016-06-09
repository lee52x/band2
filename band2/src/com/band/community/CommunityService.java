package com.band.community;

import java.util.List;
import java.util.Map;

import com.band.manager.notice.Notice;
import com.band.manager.picture.Picture;

public interface CommunityService {

	public List<Picture> listNonMainPicture(String url);
	public Picture readMainPicture(String url);
	
	public List<Notice> listCommunityNotice(Map<String, Object> map);
	public int dataCount(Map<String, Object> map);
}
