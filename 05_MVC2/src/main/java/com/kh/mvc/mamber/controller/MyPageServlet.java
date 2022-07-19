package com.kh.mvc.mamber.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kh.mvc.mamber.model.vo.Member;


@WebServlet("/member/myPage")
public class MyPageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public MyPageServlet() {
    }

    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	// session이 유지 되고 있는, 즉 로그인 상태에서만 마이페이지가 열려야 하기 때문에 session 객체를
    	// 가지고 와 로그인 멤버 객체가 있을땐 마이페이지로 forward. 없다면 alert 노출 후 다시 홈으로 가게 해줘야 한다.
    	HttpSession session = request.getSession(false);
    	Member loginMember = (session == null) ? null : (Member) session.getAttribute("loginMember");
    	
    	if (loginMember != null) {
    		request.getRequestDispatcher("/views/member/myPage.jsp").forward(request, response);
		} else {
			request.setAttribute("msg", "로그인 후 수정해주세요.");
			request.setAttribute("location", "/");
			
			request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);
		}
    	
	}
}
