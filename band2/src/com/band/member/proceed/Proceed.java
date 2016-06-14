package com.band.member.proceed;

import org.springframework.web.multipart.MultipartFile;

public class Proceed {
		
	private int proceedNo;
	private String subject, proceedDate, place, attendee, content, note, url;
	private String saveFilename, OriginalFilename;
	private MultipartFile upload;	
	
	public int getProceedNo() {
		return proceedNo;
	}
	public void setProceedNo(int proceedNo) {
		this.proceedNo = proceedNo;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getProceedDate() {
		return proceedDate;
	}
	public void setProceedDate(String proceedDate) {
		this.proceedDate = proceedDate;
	}
	public String getPlace() {
		return place;
	}
	public void setPlace(String place) {
		this.place = place;
	}
	public String getAttendee() {
		return attendee;
	}
	public void setAttendee(String attendee) {
		this.attendee = attendee;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}	
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getSaveFilename() {
		return saveFilename;
	}
	public void setSaveFilename(String saveFilename) {
		this.saveFilename = saveFilename;
	}
	public String getOriginalFilename() {
		return OriginalFilename;
	}
	public void setOriginalFilename(String originalFilename) {
		OriginalFilename = originalFilename;
	}
	public MultipartFile getUpload() {
		return upload;
	}
	public void setUpload(MultipartFile upload) {
		this.upload = upload;
	}
}
