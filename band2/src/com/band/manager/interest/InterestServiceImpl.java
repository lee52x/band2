package com.band.manager.interest;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.band.common.dao.CommonDAO;

@Service("band.manager.interest.interetService")
public class InterestServiceImpl implements InterestService{

	@Autowired
	private CommonDAO dao;
	
	@Override
	public List<Interest> listInterest(Map<String, Object> map) {
		List<Interest> list=null;
		try {
			list=dao.getListData("interest.listInterest", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return list;
	}


	@Override
	public int dataCount(Map<String, Object> map) {
		int result=0;
		try {
			result=dao.getIntValue("interest.dataCount", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	
	
}
