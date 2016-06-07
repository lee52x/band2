package com.band.manager.picture;

import org.springframework.web.multipart.MultipartFile;

public class Picture {
	
	private int manageNo, image;
	private String saveFilename, groupURL;
	private MultipartFile upload1;
	private MultipartFile upload2;
	private MultipartFile upload3;
	
	
	public MultipartFile getUpload1() {
		return upload1;
	}
	public void setUpload1(MultipartFile upload1) {
		this.upload1 = upload1;
	}
	public MultipartFile getUpload2() {
		return upload2;
	}
	public void setUpload2(MultipartFile upload2) {
		this.upload2 = upload2;
	}
	public MultipartFile getUpload3() {
		return upload3;
	}
	public void setUpload3(MultipartFile upload3) {
		this.upload3 = upload3;
	}
	public int getManageNo() {
		return manageNo;
	}
	public void setManageNo(int manageNo) {
		this.manageNo = manageNo;
	}
	public int getImage() {
		return image;
	}
	public void setImage(int image) {
		this.image = image;
	}
	public String getSaveFilename() {
		return saveFilename;
	}
	public void setSaveFilename(String saveFilename) {
		this.saveFilename = saveFilename;
	}
	public String getGroupURL() {
		return groupURL;
	}
	public void setGroupURL(String groupURL) {
		this.groupURL = groupURL;
	}
}
