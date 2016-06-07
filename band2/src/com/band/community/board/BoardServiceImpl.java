package com.band.community.board;


import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.band.common.FileManager;
import com.band.common.dao.CommonDAO;

@Service("board.boardService")
public class BoardServiceImpl implements BoardService{
	@Autowired
	private CommonDAO  dao;
	@Autowired
	private FileManager fileManager;
	
	@Override
	public int insertBoard(Board dto, String path) {
		int result=0;
		try{
			if(dto.getUpload()!=null && ! dto.getUpload().isEmpty()) {
				String saveFilename=fileManager.doFileUpload(dto.getUpload(), path);
				dto.setSaveFilename(saveFilename);
				dto.setOriginalFilename(dto.getUpload().getOriginalFilename());
			}
			result=dao.insertData("board.insertBoard", dto);
		} catch(Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public List<Board> listBoard(Map<String, Object> map) {
		List<Board> list=null;
		
		try{
			list=dao.getListData("board.listBoard", map);
		} catch(Exception e) {
			System.out.println(e.toString());
		}
		
		return list;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result=0;
		
		try{
			result=dao.getIntValue("board.dataCount", map);			
		} catch(Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}

	@Override
	public Board readBoard(int boardNo) {
		Board dto=null;
		
		try{
			// 게시물 가져오기
			dto=dao.getReadData("board.readBoard", boardNo);
		} catch(Exception e) {
			System.out.println(e.toString());
		}
		
		return dto;
	}


	@Override
	public Board preReadBoard(Map<String, Object> map) {
		Board dto=null;
		
		try{
			dto=dao.getReadData("board.preReadBoard", map);
		} catch(Exception e) {
			System.out.println(e.toString());
		}
		
		return dto;

	}

	@Override
	public Board nextReadBoard(Map<String, Object> map) {
		Board dto=null;
		
		try{
			dto=dao.getReadData("board.nextReadBoard", map);
		} catch(Exception e) {
			System.out.println(e.toString());
		}
		
		return dto;
	}

	@Override
	public int updateBoard(Board dto, String path) {
		int result=0;

		try{
			if(dto.getUpload()!=null && !dto.getUpload().isEmpty()) {
				// 이전파일 지우기
				if(dto.getSaveFilename().length()!=0)
					fileManager.doFileDelete(dto.getSaveFilename(), path);
				
				String newFilename = fileManager.doFileUpload(dto.getUpload(), path);
				if (newFilename != null) {
					dto.setOriginalFilename(dto.getUpload().getOriginalFilename());
					dto.setSaveFilename(newFilename);
				}
			}
			
			dao.updateData("board.updateBoard", dto);
			result=1;
		} catch(Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public int deleteBoard(int boardNo, String saveFilename, String path) {
		int result=0;

		try{
			// 댓글, 좋아요/싫어요 는 ON DELETE CASCADE 로 자동 삭제
			
			if(saveFilename != null ) {
			  fileManager.doFileDelete(saveFilename, path);
			}
			
			dao.deleteData("board.deleteBoard", boardNo);
			result=1;
		} catch(Exception e) {
		}
		return result;
	}
	
	
	@Override
	public int updateHitCount(int boardNo){
		int result=0;
		
		try{
			// 조회수 증가
			result=dao.updateData("board.updateHitCount", boardNo);
		} catch(Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}
	
	@Override
	public int deleteBoardId(String userId, String root) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int insertReply(Reply dto) {
		int result=0;
		try {
			result=dao.insertData("board.insertReply", dto);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public List<Reply> listReply(Map<String, Object> map) {
		List<Reply> list=null;
		try {
			list=dao.getListData("board.listReply", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}

	@Override
	public int dataCountReply(int boardNo) {
		int result=0;
		try {
			result=dao.getIntValue("board.dataCountReply", boardNo);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public int deleteReply(int replyNum) {
		int result=0;
		try {
			result=dao.deleteData("board.deleteReply", replyNum);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}



	
}
