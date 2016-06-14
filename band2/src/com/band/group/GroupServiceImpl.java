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
		String url=dto.getGroupUrl();
		try {
			dao.insertData("group.insertManager", dto);
			dao.insertData("group.insertGroup", dto);
			
			dao.updateData("group.createAccountTable", url);
			dao.updateData("group.createAccountTable_seq", url);
			
			dao.updateData("group.createMemberTable", url);
			dao.updateData("group.createMemberTable_seq", url);
			
			dao.updateData("group.createEventTable", url);
			dao.updateData("group.createEventAttendTable", url);
			dao.updateData("group.createEventTable_seq", url);
			
			dao.updateData("group.createCommunityTable", url);
			dao.updateData("group.createCommunityTable_seq", url);
			dao.updateData("group.createHashcodeTable", url);
			dao.updateData("group.createHashcodeTable_seq", url);
			
			dao.updateData("group.createGuestbookTable", url);
			dao.updateData("group.createGuestbookTable_seq", url);
			dao.updateData("group.createGuestbookLikeTable", url);
			
			dao.updateData("group.createFreeBoardTable", url);
			dao.updateData("group.createFreeBoardTable_seq", url);
			dao.updateData("group.createFreeBoardReplyTable", url);
			dao.updateData("group.createFreeBoardReplyTable_seq", url);
			
			dao.updateData("group.createPhotoBoardTable", url);
			dao.updateData("group.createPhotoBoardTable_seq", url);
			dao.updateData("group.createPhotoCommentTable", url);
			dao.updateData("group.createPhotoCommentTable_seq", url);
			dao.updateData("group.createPhotoBoardLikeTable", url);
			dao.updateData("group.createPhotoReplyLikeTable", url);
			
			dao.insertData("group.insertOwner", dto);
			
			result=1;
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

}
