package com.kh.mvc.mamber.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kh.mvc.mamber.model.service.MemberService;
import com.kh.mvc.mamber.model.vo.Member;


@WebServlet(name = "login", urlPatterns = "/login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public LoginServlet() {

    }

    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userId = request.getParameter("userId");
		String userPwd = request.getParameter("userPwd");
		HttpSession session = null;
		String saveId = request.getParameter("saveId");
		
		System.out.println(userId + ", " + userPwd + ", " + saveId);
		
		System.out.println(userId+ ", " + userPwd);
		
		Member loginMember = new MemberService().login(userId, userPwd);
		
		if (saveId != null) {
			// 현재 전달된 아이디를 쿠키에 저장
			// 1. 쿠키 생성
			Cookie cookie = new Cookie("saveId", userId);
			
			// 2. 쿠키의 유지시간 지정 후 response 객체에 쿠키 추가
//			cookie.setMaxAge(-1); // 쿠키 유지시간 설정. -1이면 브라우저 종료시까지 유지
			cookie.setMaxAge(259200); // 초 단위. 259200 = 3일 동안 유지
			response.addCookie(cookie); 
		} else {
			// 기존 쿠키값을 삭제 
			// 쿠키는 따로 삭제 메소드가 없기 때문에 동일한 키 값으로 쿠키를 다시 생성하고 
			// 유지 시간을 0으로 설정해줘야 한다.
			Cookie cookie = new Cookie("saveId", "");
			
			cookie.setMaxAge(0);
			response.addCookie(cookie);
		}
		
		// loginMember가 null이면 로그인 실패
		// loginMember가 null이 아니면 로그인 성공
		
		if (loginMember != null) {
			// loginMember 객체를 세션에 저장
			session = request.getSession();
			
			session.setAttribute("loginMember", loginMember);
			// 로그인 하면 다시 메인 페이지로 돌아가는 구문
			response.sendRedirect(request.getContextPath() + "/");
		} else {
			// 로그인 실패에 대한 메시지를 띄어주고 메인 페이지로 돌아가는 구문
			
			// 1. 공용으로 사용하는 에러 메시지 출력 페이지에 
			//	  전달 할 메시지와 메시지 출력 후 이동할 페이지를 request 객체에 저장한다.
			request.setAttribute("msg", "아이디나 비밀번호가 일치하지 않습니다.");
			request.setAttribute("location", "/");
			
			// 2. request 객체의 데이터를 유지해서 에러 메시지 출력 페이지에 전달하기 위해 forward() 실행
			request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);
		}
				
		
	}

}
