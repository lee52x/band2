package com.band.community;

import java.util.List;
import java.util.Map;

import com.band.account.Account;
import com.band.account.NoticeAccount;
import com.band.manager.notice.Notice;
import com.band.manager.picture.Picture;

public interface CommunityService {

	public List<Picture> listNonMainPicture(String url);
	public Picture readMainPicture(String url);
	
	public List<Notice> listCommunityNotice(Map<String, Object> map);
	public int dataCount(Map<String, Object> map);
	
	public List<NoticeAccount> readNoticeAccount(Map<String, Object> map);
	public List<Account> accountList(Map<String, Object> map);
	public int deleteAccountList(Map<String, Object> map);
}
