package com.kh.mvc.mamber.model.service;

import com.kh.mvc.mamber.model.dao.MemberDao;
import com.kh.mvc.mamber.model.vo.Member;

// 비지니스 로직을 처리하는 클래스
public class MemberService {

	public Member login(String id, String password) {
		Member member = new MemberDao().findMemberById(id);

		// member가 없거나 password가 맞지 않으면 null 리턴
		if(member == null || !member.getPassword().equals(password)) {
			
		return null;
		} else {
		return member;
		}
	}
}
