package com.kh.mvc.mamber.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kh.mvc.mamber.model.service.MemberService;
import com.kh.mvc.mamber.model.vo.Member;


@WebServlet("/member/delete")
public class DeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public DeleteServlet() {

    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int result = 0;
    	HttpSession session = request.getSession(false);
    	Member loginMember = (session == null) ? null : (Member) session.getAttribute("loginMember");
    	
    	if (loginMember != null) {
    		result = new MemberService().delete(loginMember.getNo());
    		
    		if (result > 0) {
				// 탈퇴 성공
    			request.setAttribute("msg", "정상적으로 탈퇴되었습니다.");
    			request.setAttribute("location", "/logout");
			} else {
				// 탈퇴 실패
				request.setAttribute("msg", "탈퇴에 실패하였습니다.");
				request.setAttribute("location", "/member/myPage");
			}
    		
		} else {
			request.setAttribute("msg", "로그인 후 탈퇴해주세요.");
			request.setAttribute("location", "/");
			
		}
    	request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);

	}

}
