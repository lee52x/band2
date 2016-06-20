package com.band.event;

import java.util.List;

public class Event {
	private int eventNo;
	private String eventName, content, eventPlace, fromDate, toDate, fromTime, toTime;
	private int eventType;
	private String url, fullDate, eventFee, eventComplete;
	
	private List<Integer> memberNos;
	private int memberNo;
	private String latitude, longitude;
	private int member, attend;
	
	
	
	



	public int getMember() {
		return member;
	}
	public void setMember(int member) {
		this.member = member;
	}
	public int getAttend() {
		return attend;
	}
	public void setAttend(int attend) {
		this.attend = attend;
	}
	public String getLatitude() {
		return latitude;
	}
	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}
	public String getLongitude() {
		return longitude;
	}
	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}
	public List<Integer> getMemberNos() {
		return memberNos;
	}
	public void setMemberNos(List<Integer> memberNos) {
		this.memberNos = memberNos;
	}
	public int getMemberNo() {
		return memberNo;
	}
	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}
	public String getEventComplete() {
		return eventComplete;
	}
	public void setEventComplete(String eventComplete) {
		this.eventComplete = eventComplete;
	}
	public String getEventFee() {
		return eventFee;
	}
	public void setEventFee(String eventFee) {
		this.eventFee = eventFee;
	}
	public String getFullDate() {
		return fullDate;
	}
	public void setFullDate(String fullDate) {
		this.fullDate = fullDate;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public int getEventNo() {
		return eventNo;
	}
	public void setEventNo(int eventNo) {
		this.eventNo = eventNo;
	}
	public String getEventName() {
		return eventName;
	}
	public void setEventName(String eventName) {
		this.eventName = eventName;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getEventPlace() {
		return eventPlace;
	}
	public void setEventPlace(String eventPlace) {
		this.eventPlace = eventPlace;
	}
	public String getFromDate() {
		return fromDate;
	}
	public void setFromDate(String fromDate) {
		this.fromDate = fromDate;
	}
	public String getToDate() {
		return toDate;
	}
	public void setToDate(String toDate) {
		this.toDate = toDate;
	}
	public String getFromTime() {
		return fromTime;
	}
	public void setFromTime(String fromTime) {
		this.fromTime = fromTime;
	}
	public String getToTime() {
		return toTime;
	}
	public void setToTime(String toTime) {
		this.toTime = toTime;
	}
	public int getEventType() {
		return eventType;
	}
	public void setEventType(int eventType) {
		this.eventType = eventType;
	}

	
}
