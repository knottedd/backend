package com.kh.mvc.mamber.model.service;

import java.sql.Connection;

import static com.kh.mvc.common.jdbc.JDBCTemplate.*;
import com.kh.mvc.mamber.model.dao.MemberDao;
import com.kh.mvc.mamber.model.vo.Member;

// 비지니스 로직을 처리하는 클래스
public class MemberService {

	public Member login(String id, String password) {
		// JDBCTemplate에서 커넥션을 얻어온다.
		Connection connection = getConnection(); 
		
		Member member = new MemberDao().findMemberById(connection, id);

		close(connection);
		
		// member가 없거나 password가 맞지 않으면 null 리턴
		if(member == null || !member.getPassword().equals(password)) {
			return null;
		} else {
			return member;
		}
		
		
		
	}
	
	// 회원가입 성공 여부 메소드. return 값이 0이면 회원가입 실패 1이면 회원가입 성공
	public int save(Member member) {
		int result = 0;
		Connection connection = getConnection();
		
		result = new MemberDao().insertMember(connection, member);
		
		if(result > 0) {
			commit(connection);
		} else {
			rollback(connection);
		}
		
		
		close(connection);
		
		return result;
	}
	
	// 아이디 중복 여부 메소드
	public Boolean isDuplicateID(String id) {
		Connection connection = getConnection(); 
		
		Member member = new MemberDao().findMemberById(connection, id);

		close(connection);
		
	
		return member != null;
	}
}
