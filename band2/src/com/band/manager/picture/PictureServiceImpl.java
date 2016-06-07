package com.band.manager.picture;

import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.band.common.FileManager;
import com.band.common.dao.CommonDAO;

@Service("band.manager.picture.pictureService")
public class PictureServiceImpl implements PictureService{

	@Autowired
	private FileManager fileManager;
	
	@Autowired
	private CommonDAO dao;
	
	@Override
	public int insertPicture(Picture dto, String path, String url) {
		int result=0;
		try {
			if(dto.getUpload1()!=null && !dto.getUpload1().isEmpty()){
				String newFilename1=fileManager.doFileUpload(dto.getUpload1(), path);
				dto.setSaveFilename(newFilename1);
				dto.setImage(1);
				dto.setGroupURL(url);
				result=dao.insertData("picture.insertPicture", dto);
			}
			if(dto.getUpload2()!=null && !dto.getUpload2().isEmpty()){
				String newFilename2=fileManager.doFileUpload(dto.getUpload2(), path);
				dto.setSaveFilename(newFilename2);
				dto.setImage(0);
				dto.setGroupURL(url);
				result=dao.insertData("picture.insertPicture", dto);
			}
			if(dto.getUpload3()!=null && !dto.getUpload3().isEmpty()){
				String newFilename3=fileManager.doFileUpload(dto.getUpload3(), path);
				dto.setSaveFilename(newFilename3);
				dto.setImage(0);
				dto.setGroupURL(url);
				result=dao.insertData("picture.insertPicture", dto);
			}
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}

	@Override
	public int deletePicture(String groupURL, String path) {
		int result=0;
		try {
			
			List<Picture> list=listPicture(groupURL);
			Iterator<Picture> it=list.iterator();
			while(it.hasNext()){
				Picture dto=it.next();
				fileManager.doFileDelete(dto.getSaveFilename(), path);
			}
			
			result=dao.deleteData("picture.deletePicture", groupURL);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public List<Picture> listPicture(String url) {
		List<Picture> list=null;
		try {
			list=dao.getListData("picture.listPicture", url);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}

	@Override
	public int dataCount(String url) {
		int result=0;
		try {
			result=dao.getIntValue("picture.dataCount", url);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}



	
}
