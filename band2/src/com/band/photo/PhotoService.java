package com.band.photo;

import java.util.List;
import java.util.Map;

public interface PhotoService {
	public int insertPhoto(Photo dto, String path);
	public int dataCount(Map<String, Object> map);
	public List<Photo> listPhoto(Map<String, Object> map);
	public Photo readPhoto(Map<String, Object> map);
	public Photo preReadPhoto(Map<String, Object> map);
	public Photo nextReadPhoto(Map<String, Object> map);
	public int updatePhoto(Photo dto, String path);
	public int deletePhoto(Map<String, Object> map, String imageFilename, String path);
	
	public int deletePhotoId(Map<String, Object> map, String root);
	
	public int insertReply(Reply dto);
	public List<Reply> listReply(Map<String, Object> map);
	public List<Reply> listReplyAnswer(Map<String, Object> map);
	public int replyDataCount(Map<String, Object> map);
	public int replyCountAnswer(Map<String, Object> map);
	public int deleteReply(Map<String, Object> map);

	public int insertReplyLike(Reply dto);
	public Map<String, Object> replyCountLike(Map<String, Object> map);
	
	public int insertPhotoLike(Photo dto);
	public Map<String, Object> photoCountLike(Map<String, Object> map);
}
