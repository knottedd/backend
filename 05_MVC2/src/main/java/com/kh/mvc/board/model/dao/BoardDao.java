package com.kh.mvc.board.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.kh.mvc.board.model.vo.Board;
import com.kh.mvc.common.util.PageInfo;

import static com.kh.mvc.common.jdbc.JDBCTemplate.*;

public class BoardDao {

	public int getBoardCount(Connection connection) {
		int count = 0;
		PreparedStatement pstmt = null;
		// select count 쿼리문을 통해 가지고 오는 게시글의 갯수는 정수 값이 아닌 resultset이다.
		// 고로 ResultSet으로 값을 받아야 함.
		ResultSet rs = null;
		String query = "SELECT COUNT(*) FROM BOARD WHERE STATUS='Y'";
		
		try {
			pstmt = connection.prepareStatement(query);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return count;
		
	}

	public List<Board> findAll(Connection connection, PageInfo pageInfo) {
		List<Board> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query =  "SELECT RNUM, NO, TITLE, ID, CREATE_DATE, ORIGINAL_FILENAME, READCOUNT, STATUS   "
							+ "FROM ("
							+    "SELECT ROWNUM AS RNUM, "
							+           "NO, "
							+ 			"TITLE, "
							+ 			"ID, "
							+ 			"CREATE_DATE, "
							+ 			"ORIGINAL_FILENAME, "
							+  			"READCOUNT, "
							+     		"STATUS "
							+ 	 "FROM ("
							+ 	    "SELECT B.NO, "
							+ 			   "B.TITLE, "
							+  			   "M.ID, "
							+ 			   "B.CREATE_DATE, "
							+ 			   "B.ORIGINAL_FILENAME, "
							+ 			   "B.READCOUNT, "
							+ 	   		   "B.STATUS "
							+ 		"FROM BOARD B "
							+ 		"JOIN MEMBER M ON(B.WRITER_NO = M.NO) "
							+ 		"WHERE B.STATUS = 'Y' ORDER BY B.NO DESC"
							+ 	 ")"
							+ ") WHERE RNUM BETWEEN ? and ?";
		
		try {
			pstmt = connection.prepareStatement(query);
			
			pstmt.setInt(1, pageInfo.getStartList());
			pstmt.setInt(2, pageInfo.getEndList());
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Board board = new Board();
				
				board.setRowNum(rs.getInt("RNUM"));
				board.setNo(rs.getInt("NO"));
				board.setTitle(rs.getString("TITLE"));
				board.setCreateDate(rs.getDate("CREATE_DATE"));
				board.setOriginalFileName(rs.getString("ORIGINAL_FILENAME"));
				board.setReadCount(rs.getInt("READCOUNT"));
				board.setStatus(rs.getString("STATUS"));
				
				list.add(board);
				
				
			}			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		
		return list;
	}

}
