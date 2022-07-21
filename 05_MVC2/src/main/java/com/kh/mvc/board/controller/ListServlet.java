package com.kh.mvc.board.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.mvc.board.model.service.BoardService;
import com.kh.mvc.board.model.vo.Board;
import com.kh.mvc.common.util.PageInfo;


@WebServlet("/board/list")
public class ListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public ListServlet() {

    }

    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	int page = 0;
    	int listCount = 0;
    	PageInfo pageInfo = null;
    	List<Board> list = null;
    	
    	// 현재 보고 있는 페이지를 가지고 온다. 만약 해당 페이지 주소를 주지 않아 에러가 뜬다면
    	// 예외처리 구문을 통해 기본적으로 첫번째 페이지가 보이게끔 처리
    	try {
        	page = Integer.parseInt(request.getParameter("page"));
		} catch (NumberFormatException e) {
			page = 1;
		}
    	
    	listCount = new BoardService().getBoardCount();
    	// currentPage 현재 페이지, pageLimit 한 페이지에 보이는 페이지의 수 
	    // listCount 전체 리스트의 수, listLimit 한 페이지에 표시될 리스트의 수 순서
    	pageInfo = new PageInfo(page, 10, listCount, 10);
    	list = new BoardService().getBoardList(pageInfo);
    	    	
    	request.setAttribute("pageInfo", pageInfo); 	
    	request.setAttribute("list", list);
		request.getRequestDispatcher("/views/board/list.jsp").forward(request, response);
	}

}
