package com.band.manager.insertBoard;

import java.util.List;
import java.util.Map;

public interface InsertBoardService {
	
	public int insertBoard(Map<String, Object> map);
	public int updateBoard(Map<String, Object> map);
	public List<InsertBoard> listBoard(Map<String, Object> map);
	public int deleteBoard(Map<String, Object> map);
	public int dataCount(Map<String, Object> map);
	public String readName(Map<String, Object> map);
}
