package com.band.common.dao;

import java.util.List;
import java.util.Map;

public interface CommonDAO {
	public int insertData(String id, Object value) throws Exception;
	
	public int updateData(String id, Object value) throws Exception;
	public int updateData(String id, Map<String, Object> map) throws Exception;
	
	public int deleteData(String id, Map<String, Object> map) throws Exception;
	public int deleteData(String id, Object value) throws Exception;
	public int deleteAll(String id) throws Exception;
	
	public int getIntValue(String id, Map<String, Object> map) throws Exception;
	public int getIntValue(String id, Object value) throws Exception;
	public int getIntValue(String id) throws Exception;
	
	public <T> List<T> getListData(String id, Map<String, Object> map) throws Exception;
	public <T> List<T> getListData(String id, Object value) throws Exception;
	public <T> List<T> getListData(String id) throws Exception;
	
	public <T> T getReadData(String id) throws Exception;
	public <T> T getReadData(String id, Object value) throws Exception;
	public <T> T getReadData(String id, Map<String, Object> map) throws Exception;
	
}