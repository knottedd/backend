package com.kh.mvc.mamber.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.mvc.common.util.EncryptUtil;
import com.kh.mvc.mamber.model.service.MemberService;
import com.kh.mvc.mamber.model.vo.Member;


@WebServlet(name = "enroll", urlPatterns = "/member/enroll")
public class EnrollServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public EnrollServlet() {

    }
    
    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	// 회원가입 페이지로 전환해주는 기능
    	request.getRequestDispatcher("/views/member/enroll.jsp").forward(request, response);
	}

    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
    	Member member = new Member();
    	
    	member.setId(request.getParameter("userId"));
    	member.setPassword(request.getParameter("userPwd"));
    	member.setName(request.getParameter("userName"));
    	member.setPhone(request.getParameter("phone"));
    	member.setEmail(request.getParameter("email"));
    	member.setAddress(request.getParameter("address"));
    	member.setHobby(String.join(",", request.getParameterValues("hobby")));
    	
    	System.out.println(member);
    	
    	// save가 됐을때 member 객체가 한 행 이상 삽입이 되기 때문에 
    	// result가 0 보다 크면 회원 가입 완료. 0보다 작으면 회원 가입 실패
    	int result = new MemberService().save(member);
    	
    	// result가 0보다 크면 회원 가입 완료 됐다는 뜻. 0보다 작다면 회원 가입 실패
    	if(result > 0) {
    		request.setAttribute("msg", "회원 가입 성공");
    		request.setAttribute("location", "/");
    	} else {
    		request.setAttribute("msg", "회원 가입 실패");
    		request.setAttribute("location", "/member/enroll");
    	}
		
		request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);
    	
    }

}
