package com.band.manager.picture;

import java.util.List;

public interface PictureService {
	
	public int insertPicture(Picture dto, String path, String url);
	public int deletePicture(String groupURL, String path);
	public List<Picture> listPicture(String url);
	public int dataCount(String url);
	
}
