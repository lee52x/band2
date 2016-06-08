package com.band.account.fee;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.band.account.Event;
import com.band.common.dao.CommonDAO;

@Service("account.feeService")
public class FeeServiceImpl implements FeeService{

	@Autowired
	private CommonDAO dao;

	@Override
	public List<Event> eventList(Map<String, Object> map) {
		List<Event> list=null;
		try {
			list=dao.getListData("account.eventList", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}

}
