package com.band.group;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.band.common.dao.CommonDAO;

@Service("group.groupService")
public class GroupServiceImpl implements GroupService{

	@Autowired
	private CommonDAO dao;
	
	@Override
	public int insertGroup(Group dto) {
		int result=0;
		try {
			dao.insertData("group.insertManager", dto);
			dao.insertData("group.insertGroup", dto);
			result=1;
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

}
