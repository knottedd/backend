package com.kh.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/*
 * 서버에서 서블릿을 실행시키는 방법
 * 	1. 서블릿 클래스를 작성한다.
 * 	  - javax.servlet.http.HttpServlet 상속하는 클래스 생성
 * 	  - doGet(), doPost() 메소드를 재정의한다. 
 *  2. 서블릿을 등록, URL을 매핑한다.
 *    - web.xml에 서블릿을 등록, URL 매핑
 *    - @WebServlet으로 서블릿 등록, URL 매핑
 */

public class FirstServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	
    public FirstServlet() {

    }
    
    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// GET 방식의 요청에 응답할 로직을 구현한다.
    	
    	// 한글이 깨지는 것을 방지하기 위해 Content-Type 응답 헤더를 설정한다.
    	// ;을 기준으로 여러 값을 설정할 수 있다.
    	response.setContentType("text/html;charset=utf-8");
    	
    	// 응답 페이지를 작성해서 보내주면 브라우저가 띄어준다.
    	PrintWriter out = response.getWriter();
    	
    	out.write("<html>");
    	out.write("<body>");
    	out.write("<h1>우리가 만든 첫 번째 서블릿의 반환 내용</h1>");
    	out.write("</body>");
    	out.write("</html>");
	}

    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// POST 방식의 요청에 응답할 로직을 구현한다.
		doGet(request, response);
	}

}
