package com.band.community.board;

import java.util.List;
import java.util.Map;

public interface BoardService {
	public int insertBoard(Board dto, String path);
	public List<Board> listBoard(Map<String, Object> map);
	public int dataCount(Map<String, Object> map);
	public Board readBoard(Map<String, Object> map);
	
	public int updateHitCount(Map<String, Object> map);


	public Board preReadBoard(Map<String, Object> map);
	
	public Board nextReadBoard(Map<String, Object> map);
	
	
	public int updateBoard(Board dto, String path);
	public int deleteBoard(Map<String, Object> map, String saveFilename, String path);
	
	public int deleteBoardId(String userId, String root);
	
	public int insertReply(Reply dto);
	public int dataCountReply(Map<String, Object> map);
	public List<Reply> listReply(Map<String, Object> map);
	public int deleteReply(Map<String, Object> map);
	
	public int insertHash(String hashName);
	
	
	
}
