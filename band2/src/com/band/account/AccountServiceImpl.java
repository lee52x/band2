package com.band.account;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.band.common.ExcelManager;
import com.band.common.FileManager;
import com.band.common.dao.CommonDAO;

@Service("account.accountService")
public class AccountServiceImpl implements AccountService{
	
	@Autowired
	private CommonDAO dao;
	
	@Autowired
	private FileManager fileManager;
	
	@Autowired
	private ExcelManager excelManager;
	
	@Override
	public int insertAccount(Account dto) {
		int result=0;
		try {
			result=dao.insertData("account.insertAccount", dto);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public List<Account> listAccount(Map<String, Object> map) {
		List<Account> list=null;
		try {
			list=dao.getListData("account.listAccount", map);
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
	
	@Override
	public int deleteList(Map<String, Object> map) {
		int result=0;
		try {
			result=dao.deleteData("account.deleteList", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public int updateAccount(Account dto) {
		int result=0;
		try {
			result=dao.insertData("account.updateAccount", dto);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public int uploadExcel(Account dto, String pathname, String option) {
		int result=0;
		try {
			String fileName=fileManager.doFileUpload(dto.getUpload(), pathname);
			dto.setFileName(fileName);
			
			// ¿¢¼¿ ÀÐ±â
			String path=pathname+"/"+dto.getFileName();
			excelManager.ExcelRoad(path, dto.getUrl(), option);
			
			fileManager.doFileDelete(fileName, pathname);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public List<Account> allListAccount(Map<String, Object> map) {
		List<Account> list=null;
		try {
			list=dao.getListData("account.allListAccount", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}
	
	@Override
	public List<Account> eventListAccount(Map<String, Object> map) {
		List<Account> list=null;
		try {
			list=dao.getListData("account.eventListAccount", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}


	@Override
	public List<Account> cateListAccount(Map<String, Object> map) {
		List<Account> list=null;
		try {
			list=dao.getListData("account.cateListAccount", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}
	
	/**
	 * ÀÏÁ¤ °ü·Ã
	 */
	@Override
	public List<Event> listEvent(Map<String, Object> map) {
		List<Event> list=null;
		try {
			list=dao.getListData("account.eventList", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}

	@Override
	public int insertNoticeAccount(NoticeAccount dto) {
		int result=0;
		try {
			result=dao.insertData("account.insertNoticeAccount", dto);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

}