package com.band.account.state;

import java.util.List;
import java.util.Map;

import com.band.account.Account;

public interface StateService {
	public List<Account> cateState(Map<String, Object> map);
	public String minDate(Map<String, Object> map);
	public List<Account> depositState(Map<String, Object> map);
	public List<Account> dayState(Map<String, Object> map);
	public List<Account> eventState(Map<String, Object> map);
	
	public Account listThisMonth(Map<String, Object> map);
	public Account listPreMonth(Map<String, Object> map);
	public int readBalance(Map<String, Object> map);
}