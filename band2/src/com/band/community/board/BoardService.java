package com.band.community.board;

import java.util.List;
import java.util.Map;

public interface BoardService {
	public int insertBoard(Board dto, String path);
	public List<Board> listBoard(Map<String, Object> map);
	public int dataCount(Map<String, Object> map);
	public Board readBoard(int boardNo);
	
	public int updateHitCount(int boardNo);


	public Board preReadBoard(Map<String, Object> map);
	
	public Board nextReadBoard(Map<String, Object> map);
	
	
	public int updateBoard(Board dto, String path);
	public int deleteBoard(int boardNo, String saveFilename, String path);
	
	public int deleteBoardId(String userId, String root);
	
	public int insertReply(Reply dto);
	public int dataCountReply(int boardNo);
	public List<Reply> listReply(Map<String, Object> map);
	public int deleteReply(int replyNum);
	
	
}
