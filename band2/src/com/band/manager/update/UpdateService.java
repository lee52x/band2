package com.band.manager.update;


public interface UpdateService {
	
	public int updateInfo(Update dto);
	public Update readInfo(String groupUrl);
	
}