<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setAttribute("requestScope", "requestValue");
	// pageContext의 유효범위는 해당 페이지에만 유효하기 때문에 다른 페이지로 넘어가면 속성을
	// 가지고 올 수 없다.
	pageContext.setAttribute("pageScope", "pageValue");
	
	//pageContext.forward("scopeTest3.jsp");
	// 만약 리다이렉트로 페이지를 요청하면 리다이렉트는 두번을 요청하기 때문에 scopeTest3 페이지에선
	// 속성이 모두 소멸 됨. 즉 처음 요청하고 응답이 끝날때 소멸 되고 다시 요청하기 때문에 이미 속성이 
	// 소멸되서 속성이 없는 상태인 null을 가져옴. 
	// 포워드로 페이지를 요청하면 클라이언트에서 해당페이지로 요청. 이 페이지 자체에서 scopeTest3으로
	// 값을 넘긴후 클라이언트로 응답. 즉 한번만 요청 응답이 이뤄지기 때문에 request에선 속성을 가지고
	// 올 수 있다.
	response.sendRedirect("scopeTest3.jsp");
%>