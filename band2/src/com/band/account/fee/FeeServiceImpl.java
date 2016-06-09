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

	@Override
	public List<Event> memberList(Map<String, Object> map) {
		List<Event> list=null;
		try {
			list=dao.getListData("account.feeMember", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}

	@Override
	public Event firstEvent(Map<String, Object> map) {
		Event dto=null;
		try {
			dto=dao.getReadData("account.firstEventNo", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return dto;
	}

	@Override
	public Event datailEvent(Map<String, Object> map) {
		Event dto=null;
		try {
			dto=dao.getReadData("account.datailEvent", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return dto;
	}

	@Override
	public int feeRatio(Map<String, Object> map) {
		int result=0;
		try {
			result=dao.getIntValue("account.feeRatio", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public int updateFee(Event dto) {
		int result=0;
		try {
			result=dao.insertData("account.updateFee", dto);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public int updateFeeN(Event dto) {
		int result=0;
		try {
			result=dao.insertData("account.updateFeeN", dto);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}
}
