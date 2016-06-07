package com.band.account;

import java.util.List;
import java.util.Map;

public interface AccountService {
	public int insertAccount(Account dto);
	public List<Account> listAccount(Map<String, Object> map);
	public List<Account> allListAccount(Map<String, Object> map);
	public List<Account> eventListAccount(Map<String, Object> map);
	public List<Account> cateListAccount(Map<String, Object> map);
	
	public String minDate(Map<String, Object> map);
	
	public Account listThisMonth(Map<String, Object> map);
	public Account listPreMonth(Map<String, Object> map);
	public int readBalance(Map<String, Object> map);
	
	public int deleteList(Map<String, Object> map);
	public int updateAccount(Account dto);
	
	public int uploadExcel(Account dto, String pathname, String option);
	
	// 일정 관련
	public List<Event> listEvent(Map<String, Object> map);
}