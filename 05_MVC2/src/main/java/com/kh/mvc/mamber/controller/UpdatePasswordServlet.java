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


@WebServlet(name = "updatePwd", urlPatterns = "/member/updatePwd")
public class UpdatePasswordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
 
    public UpdatePasswordServlet() {

    }

    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/views/member/updatePwd.jsp").forward(request, response);
	}

    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	int result = 0;
    	HttpSession session = request.getSession(false);
    	Member loginMember = (session == null) ? null : (Member) session.getAttribute("loginMember");
    	String userPwd = request.getParameter("userPwd");
    	
    	if (loginMember != null) {
    		// getNo를 매개값으로 받는 이유는 프라이머리 키인 No로 식별해서 password를 변경해야 하기 때문
    		result = new MemberService().updatePassword(loginMember.getNo(), userPwd);
    		
    		if (result > 0) {
				// 탈퇴 성공
    			request.setAttribute("msg", "비밀번호 변경이 완료되었습니다.");
    			request.setAttribute("script", "self.close()");
			} else {
				// 탈퇴 실패
				request.setAttribute("msg", "비밀번호 변경에 실패하였습니다.");
				request.setAttribute("location", "/member/updatePwd");
			}
    		
		} else {
			request.setAttribute("msg", "로그인 후 수정해주세요.");
			request.setAttribute("script", "self.close()");
			
		}
    	request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);

	}

}
