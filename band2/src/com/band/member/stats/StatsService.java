package com.band.member.stats;

import java.util.List;
import java.util.Map;

import com.band.member.member.Member;

public interface StatsService {
	public int totalMember(Map<String, Object> map); // 전체회원수 검색
	public int communityMember(Map<String, Object> map); // 커뮤니티회원수 검색
	public int recentJoinMember(Map<String, Object> map); // 최근 가입한 회원수 검색
	public String firstday(); // 현재 날짜가 속한 달의 시작일 검색
	public String today(); // 현재 날짜 검색
	public String foundationDay(Map<String, Object> map); // 모임 창립일 검색
	public int countFoundationDay(Map<String, Object> map); // 창립일 계산
	public List<Member> listJoinMember(Map<String, Object> map);	// 최근 가입한 회원정보 검색
}
