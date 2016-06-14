package com.band.manager.insertBoard;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.band.common.dao.CommonDAO;

@Service("nurida.manager.insertBoard.insertBoardService")
public class InsertBoardServiceImpl implements InsertBoardService{

	@Autowired
	public CommonDAO dao;
	
	@Override
	public int insertBoard(Map<String, Object> map) {
		int result=0;
		try {
			result=dao.insertData("insertBoard.insertBoard",map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public int updateBoard(Map<String, Object> map) {
		int result=0;
		try {
			result=dao.updateData("insertBoard.updateBoard",map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public List<InsertBoard> listBoard(Map<String, Object> map) {
		List<InsertBoard> list=null;
		
		try {
			
			list=dao.getListData("insertBoard.listBoard", map);
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return list;
	}

	@Override
	public int deleteBoard(Map<String, Object> map) {
		int result=0;
		try {
			result=dao.deleteData("insertBoard.deleteBoard",map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result=0;
		try {
			result=dao.getIntValue("insertBoard.dataCount",map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	
	
}
