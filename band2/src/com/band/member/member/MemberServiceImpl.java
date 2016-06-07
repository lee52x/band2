package com.band.member.member;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.band.common.dao.CommonDAO;

@Service("member.member.memberService")
public class MemberServiceImpl implements MemberService {

	@Autowired
	private CommonDAO dao;	

	@Override
	public int insertMember(Member dto) {
		int result = 0;
		try {
			dao.insertData("member.insertMember", dto);
			result = 1;
		} catch(Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public int updateMember(Member dto) {
		int result = 0;
		try {
			result = dao.updateData("member.updateMember", dto);
		} catch(Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public int deleteMember(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.deleteData("member.deleteMember", map);
		} catch(Exception e) {
			System.out.println(e.toString());
		}	
		return result;
	}	

	@Override
	public List<Member> listMember(Map<String, Object> map) {
		List<Member> list = null;
		try {
			list = dao.getListData("member.listMember", map);
		} catch(Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}

}
