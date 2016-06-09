package com.band.member.insertMember;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.band.common.dao.CommonDAO;

@Service("manager.insertMember.memberService")
public class MemberServiceImpl implements MemberService {

	@Autowired
	private CommonDAO dao;
	
	@Override
	public Member readMember(Map<String, Object> map) {
		Member dto = null;		
		try {
			dto = dao.getReadData("insertMember.readDetailMember", map);
		} catch(Exception e) {
			System.out.println(e.toString());
		}
		return dto;
	}

	@Override
	public int insertMember(Member dto) {
		int result = 0;
		try {
			dao.insertData("insertMember.insertMember", dto);
			result = 1;
		} catch(Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public int updateMember(Member dto) {
		int result=0;
		try {
			result=dao.updateData("insertMember.updateMember", dto);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public int deleteMember(int memberNo) {
		// TODO Auto-generated method stub
		return 0;
	}	

	@Override
	public List<Member> listMember(Map<String, Object> map) {
		List<Member> list = null;
		try {
			list = dao.getListData("insertMember.listMember", map);
		} catch(Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}


}
