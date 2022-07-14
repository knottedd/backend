package com.kh.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Arrays;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.jasper.tagplugins.jstl.core.ForEach;


@WebServlet("/method.do")
public class MethodServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public MethodServlet() {

    }

    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
    	// 사용자가 보낸 데이터들은 request 객체 안에 키(폼 태그에서의 name 속성 값), 값(폼 태그에서의 value 속성 값)형태로 담겨있다.
    	// 해당 name 속성을 가지는 요소의 value 값을 문자열로 읽어온다. 
    	String userName = request.getParameter("userName");
    	String userAge = request.getParameter("userAge");
    	String gender = request.getParameter("gender");
    	String height = request.getParameter("height");
    	// 체크박스와 같이 하나의 name 속성에 여러개의 값이 존재하는 경우 getParameterValues("name 속성") 메소드를 사용한다.  
    	String[] food = request.getParameterValues("food");
    	
    	System.out.println(userName);
    	System.out.println(userAge);
    	System.out.println(gender);
    	System.out.println(height);
    	// 스트림을 이용해 food 배열의 속성값을 전부 출력
    	Arrays.stream(food).forEach(System.out::println);
    	
    	// 응답 화면 작성
    	response.setContentType("text/html;charset=utf-8");
    	
    	PrintWriter out = response.getWriter();
    	
    	out.println("<html>");
    	out.println("<head>");
    	out.println("<title>개인 정보 출력 화면</title>");
      	out.println("</head>");
    	out.println("<body>");
    	out.println("<h2>개인 정보 입력 결과</h2>");
    	out.printf("%s님은 %s세 이고 키가 %scm인 %s입니다.\n" ,userName, userAge, height, gender);
    	out.print("좋아하는 음식은 : ");
    	Arrays.stream(food).forEach(f -> out.write(f + ""));
    	out.print(" 입니다.");
    	out.println("</body>");
    	out.println("</html>");
    	
	}

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	// get 방식은 url로 보낸다. 한글을 url로 보낼땐 자동으로 인코딩이 되기 때문에 따로 작업을 해주지 않아도 된다.
    	// 하지만 post 방식은 url로 보내지 않기 때문에 인코딩이 되지 않고 따로 UTF-8로 인코딩 해주어야 한다.
    	request.setCharacterEncoding("UTF-8");
    	
    	// doGet 메소드 안에 있는 정보를 그대로 출력해 줌. html 파일 안 폼태그에 메소드 설정값만 post로 바꿔주면 된다.
		doGet(request, response);
		
	}

}
