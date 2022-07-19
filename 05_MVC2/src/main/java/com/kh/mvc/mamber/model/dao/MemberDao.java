package com.kh.mvc.mamber.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

// static import 
import static com.kh.mvc.common.jdbc.JDBCTemplate.*;
import com.kh.mvc.mamber.model.vo.Member;

// id를 매개변수로 주고 해당 멤버 객체를 찾는 클래스
public class MemberDao {

	public Member findMemberById(Connection connection, String id) {
		Member member = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		String query = "SELECT * FROM MEMBER WHERE ID=? AND STATUS='Y'";
		
		// 오라클 DBMS Driver 등록
		try {
			
			// DBMS와 연결
			pstm = connection.prepareStatement(query);
			
			// PreparedStatement를 사용하면 위 쿼리 변수에 담겨있는 ID 부분을 ?로 작성하고
			// 해당 ?에 값을 세팅할 수 있다. 즉 첫번째 ?에 매개값으로 전달하는 id를 추가 시킨다.
			pstm.setString(1, id);
			// 데이터 베이스에 있는 쿼리문 실행 결과를 담아줌
			rs = pstm.executeQuery();
			
			if(rs.next()) {
				// 가져온 데이터를 자바 객체에 담기
				member = new Member();
				
				member.setNo(rs.getInt("NO"));
				member.setId(rs.getString("ID"));
				member.setPassword(rs.getString("PASSWORD"));
				member.setRole(rs.getString("ROLE"));
				member.setName(rs.getString("NAME"));
				member.setPhone(rs.getString("PHONE"));
				member.setEmail(rs.getString("EMAIL"));
				member.setAddress(rs.getString("ADDRESS"));
				member.setHobby(rs.getString("HOBBY"));
				member.setStatus(rs.getString("STATUS"));
				member.setEnrollDate(rs.getDate("ENROLL_DATE"));
				member.setModifyDate(rs.getDate("MODIFY_DATE"));
			
			}		
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
//			JDBCTemplate.close(rs);
//			JDBCTemplate.close(pstm);
			// static import를 해줌으로써 생략 가능
			close(rs);
			close(pstm);
		}		
		
		return member;
	}

	public int insertMember(Connection connection, Member member) {
		int result = 0;
		String query = "INSERT INTO MEMBER VALUES(SEQ_UNO.NEXTVAL,?,?,DEFAULT,?,?,?,?,?,DEFAULT,DEFAULT,DEFAULT)";
		PreparedStatement pstm = null;
		
	      try {
	          pstm = connection.prepareStatement(query);
	          
	          pstm.setString(1, member.getId());
	          pstm.setString(2, member.getPassword());
	          pstm.setString(3, member.getName());
	          pstm.setString(4, member.getPhone());
	          pstm.setString(5, member.getEmail());
	          pstm.setString(6, member.getAddress());
	          pstm.setString(7, member.getHobby());
	          
	          result = pstm.executeUpdate();         
	       } catch (SQLException e) {
	          e.printStackTrace();
	       } finally {
	          close(pstm);
	       }

		return result;
	}

}
