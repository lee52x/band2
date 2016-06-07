package com.band.manager.notice;

public class Notice {
	
	private int NoticeNo, listNum, isNotice;
	private String noticeDate;
	private String content, created, endDate, groupURL;
	
	public String getNoticeDate() {
		return noticeDate;
	}
	public void setNoticeDate(String noticeDate) {
		this.noticeDate = noticeDate;
	}
	public int getListNum() {
		return listNum;
	}
	public void setListNum(int listNum) {
		this.listNum = listNum;
	}
	
	public int getNoticeNo() {
		return NoticeNo;
	}
	public void setNoticeNo(int noticeNo) {
		NoticeNo = noticeNo;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getCreated() {
		return created;
	}
	public void setCreated(String created) {
		this.created = created;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	public String getGroupURL() {
		return groupURL;
	}
	public void setGroupURL(String groupURL) {
		this.groupURL = groupURL;
	}
	public int getIsNotice() {
		return isNotice;
	}
	public void setIsNotice(int isNotice) {
		this.isNotice = isNotice;
	}
	

}
