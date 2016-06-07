package com.band.manager.update;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.band.common.dao.CommonDAO;

@Service("manager.update.updateService")
public class UpdateServiceImpl implements UpdateService{

	@Autowired
	private CommonDAO dao;
	
	@Override
	public int updateInfo(Update dto) {
		int result=0;
		try {
			result=dao.updateData("update.updateInfo", dto);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}

	@Override
	public Update readInfo(String groupUrl) {
		Update dto=null;
		try {
			dto=dao.getReadData("update.readInfo", groupUrl);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return dto;
	}
	
}
