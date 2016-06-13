package com.band.member.stats;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.band.common.dao.CommonDAO;
import com.band.member.member.Member;

@Service("member.stats.StatsService")
public class StatsServiceImpl implements StatsService {

	@Autowired
	private CommonDAO dao;
	
	@Override
	public int totalMember(Map<String, Object> map) { // ��üȸ���� �˻�
		int result = 0;
		try {
			result = dao.getIntValue("member.selectTotalMember", map);
		} catch(Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public int communityMember(Map<String, Object> map) { // Ŀ�´�Ƽȸ���� �˻�
		int result = 0;
		try {
			result = dao.getIntValue("member.selectCommunityMember", map);
		} catch(Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public int recentJoinMember(Map<String, Object> map) { // �ֱ� ������ ȸ���� �˻�
		int result = 0;
		try {
			result = dao.getIntValue("member.recentJoinMemberCount", map);
		} catch(Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override	
	public String firstday() { // ���� ��¥�� ���� ���� ������ �˻�
		String firstDay = null;
		try {
			firstDay = dao.getReadData("member.selectFirstday");
		} catch(Exception e) {
			System.out.println(e.toString());
		}
		return firstDay;
	}

	@Override
	public String today() { // ���� ��¥ �˻�
		String today = null;
		try {
			today = dao.getReadData("member.selectToday");
		} catch(Exception e) {
			System.out.println(e.toString());
		}
		return today;
	}

	@Override
	public String foundationDay(Map<String, Object> map) { // ���� â���� �˻�
		String foundationDay = null;
		try {
			foundationDay = dao.getReadData("member.selectFoundationday", map);
		} catch(Exception e) {
			System.out.println(e.toString());
		}
		return foundationDay;
	}

	@Override
	public int countFoundationDay(Map<String, Object> map) { // â���� ���
		int result = 0;
		try {
			result = dao.getIntValue("member.countFoundationday", map);
		} catch(Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public List<Member> listJoinMember(Map<String, Object> map) { // �ֱ� ������ ȸ������ �˻�
		List<Member> list = null;
		try {
			list = dao.getListData("member.listRecentJoinMember", map);
		} catch(Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}

	@Override
	public List<Member> listBirthMember(Map<String, Object> map) {
		List<Member> list = null;
		try {
			list = dao.getListData("member.listBirthMember", map);
		} catch(Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}
}
