package com.band.account.state;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.band.account.Account;
import com.band.common.dao.CommonDAO;

@Service("account.stateService")
public class StateServiceImpl implements StateService{

	@Autowired
	private CommonDAO dao;
	
	@Override
	public List<Account> cateState(Map<String, Object> map) {
		List<Account> list=null;
		try {
			list=dao.getListData("account.cateState", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}
	
	@Override
	public String minDate(Map<String, Object> map) {
		String result=null;
		try {
			result=dao.getReadData("account.minDate", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public List<Account> depositState(Map<String, Object> map) {
		List<Account> list=null;
		try {
			list=dao.getListData("account.depositState", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}

	@Override
	public List<Account> dayState(Map<String, Object> map) {
		List<Account> list=null;
		try {
			list=dao.getListData("account.dayState", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}
	

	@Override
	public Account listThisMonth(Map<String, Object> map) {
		Account dto=null;
		try {
			dto=dao.getReadData("account.listThisMonth", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return dto;
	}

	@Override
	public Account listPreMonth(Map<String, Object> map) {
		Account dto=null;
		try {
			dto=dao.getReadData("account.listPreMonth", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return dto;
	}

	@Override
	public int readBalance(Map<String, Object> map) {
		int result=0;
		try {
			result=dao.getReadData("account.readBalance", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}
}
