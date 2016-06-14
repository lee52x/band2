package com.band.member.proceed;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.band.common.FileManager;
import com.band.common.dao.CommonDAO;

@Service("member.proceed.ProceedService")
public class ProceedServiceImpl implements ProceedService {

	@Autowired
	private CommonDAO dao;
	@Autowired
	private FileManager fileManager;
	
	@Override
	public int insertProceed(Proceed dto, String path) {
		int result = 0;
		try {
			if(dto.getUpload() != null && ! dto.getUpload().isEmpty()) {
				String newFilename = fileManager.doFileUpload(dto.getUpload(), path);
				dto.setSaveFilename(newFilename);
			}
			result = dao.insertData("member.insertProceed", dto);
		} catch(Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public int updateProceed(Proceed dto, String path) {
		int result = 0;
		try {
			if(dto.getUpload() != null && ! dto.getUpload().isEmpty()) {
				String newFilename = fileManager.doFileUpload(dto.getUpload(), path);
				
				if(newFilename != null) {
					Proceed vo = readProceed(dto.getProceedNo());
					if(vo != null && vo.getSaveFilename() != null) {
						fileManager.doFileDelete(vo.getSaveFilename(), path);						
					}
				}
				dto.setSaveFilename(newFilename);
			}
			result = dao.updateData("member.updateProceed", dto);
		} catch(Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public int deleteProceed(int proceedNo, String saveFilename, String path) {
		int result = 0;
		try {
			if(saveFilename != null)
				fileManager.doFileDelete(saveFilename, path);			
			result = dao.deleteData("member.deleteProceed", proceedNo);
		} catch(Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.getIntValue("member.dataCount", map);
		} catch(Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public List<Proceed> proceedList(Map<String, Object> map) {
		List<Proceed> list = null;
		try {
			list = dao.getListData("member.proceedList", map);
		} catch(Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}

	@Override
	public Proceed readProceed(int proceedNo) {
		Proceed dto = null;
		try {
			dto = dao.getReadData("member.readProceed", proceedNo);
		} catch(Exception e) {
			System.out.println(e.toString());
		}
		return dto;
	}	
}
