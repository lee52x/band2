package com.band.member.stats;

import java.util.List;
import java.util.Map;

import com.band.member.member.Member;

public interface StatsService {
	public int totalMember(Map<String, Object> map); // ��üȸ���� �˻�
	public int communityMember(Map<String, Object> map); // Ŀ�´�Ƽȸ���� �˻�
	public int recentJoinMember(Map<String, Object> map); // �ֱ� ������ ȸ���� �˻�
	public String firstday(); // ���� ��¥�� ���� ���� ������ �˻�
	public String today(); // ���� ��¥ �˻�
	public String foundationDay(Map<String, Object> map); // ���� â���� �˻�
	public int countFoundationDay(Map<String, Object> map); // â���� ���
	public List<Member> listJoinMember(Map<String, Object> map);	// �ֱ� ������ ȸ������ �˻�
}
