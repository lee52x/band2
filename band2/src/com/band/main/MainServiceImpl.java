package com.band.main;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.band.common.dao.CommonDAO;

@Service("main.mainService")
public class MainServiceImpl implements MainService{
	@Autowired
	private CommonDAO dao;
	
	@Override
	public Main readMember(Map<String, Object> map) {
		Main dto=null;
		try {
			dto=dao.getReadData("main.readMember", map);
		} catch (Exception e) {
		}
		return dto;
	}

}
