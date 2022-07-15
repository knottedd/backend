package com.kh.ajax.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.kh.ajax.model.vo.User;


@WebServlet("/jqAjax2.do")
public class jqAjaxServlet2 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public jqAjaxServlet2() {
    	
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int userNo = Integer.parseInt(request.getParameter("userNo"));
		
		// 사용자 정보가 저장되어 있는 List 객체 생성
		List<User> list = new ArrayList<>();
		
		list.add(new User(1, "김철수", 30, "남자"));
		list.add(new User(2, "김영희", 30, "여자"));
		list.add(new User(3, "서호정", 27, "남자"));
		list.add(new User(4, "영심이", 16, "여자"));
		list.add(new User(5, "안경태", 16, "남자"));
		
		
		User findUser = list.stream()
							.filter(user -> user.getNo() == userNo)
							.findFirst()
							.orElse(null);
		
		System.out.println(findUser);
		// new Gson().toJson(findUser)를 통해 findUser 자바 객체를 자바스크립트 객체로 변환
		System.out.println(new Gson().toJson(findUser));
		// new Gson().formJson을 통해 자바 스크립트 객체를 자바 객체로 변환
		System.out.println(new Gson().fromJson("{\"no\":5, \"name\":\"안경태\",\"age\":16,\"gender\":\"남자\"}", User.class));
		
		// 콘텐츠 타입으로 application과 json 설정
		response.setContentType("application/json;charset=UTF-8");
		
		// response.getWriter().write("{\"no\":1, \"name\":\"홍길동\"}");
		response.getWriter().write(new Gson().toJson(findUser));
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String gender = request.getParameter("gender");
		
		// 사용자 정보가 저장되어 있는 List 객체 생성
		List<User> list = new ArrayList<>();
		
		list.add(new User(1, "김철수", 30, "남자"));
		list.add(new User(2, "김영희", 30, "여자"));
		list.add(new User(3, "서호정", 27, "남자"));
		list.add(new User(4, "영심이", 16, "여자"));
		list.add(new User(5, "안경태", 16, "남자"));
		
		List<User> findList = list.stream()
								  .filter(user -> user.getGender().equals(gender))
								  .collect(Collectors.toList());
		
		System.out.println(gender);
		System.out.println(findList);
		// json이 알아서 자바스크립트 객체로 바꿔 준다.
		System.out.println(new Gson().toJson(findList));
		
		response.setContentType("application/json;charset=UTF-8");
		
		// response.getWriter().write(new Gson().toJson(findLis));
		// 말고도 Gson으로 접근해 출력 가능
		new Gson().toJson(findList, response.getWriter());
	}

}
