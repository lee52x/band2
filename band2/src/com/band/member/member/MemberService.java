package com.band.member.member;

import java.util.List;
import java.util.Map;

public interface MemberService {	
	
	public int insertMember(Member dto);
	
	public int updateMember(Member dto);
	
	public int deleteMember(Map<String, Object> map);
	
	public List<Member> listMember(Map<String, Object> map);
}
