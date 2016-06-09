package com.band.member.insertMember;

import java.util.List;
import java.util.Map;

public interface MemberService {
	
	public Member readMember(Map<String, Object> map);
	
	
	public int insertMember(Member dto);
	
	public int updateMember(Member dto);
	
	public int deleteMember(int memberNo);
	
	public List<Member> listMember(Map<String, Object> map);
}
