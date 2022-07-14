<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>jsp:include 액션 태그</title>
</head>
<body>

	<h1>jsp:include 액션 태그</h1>
	<p>
		현재 JSP 페이지에 다른 페이지를 포함하고자 할 때 사용하는 액션 태그이다.
	</p>
	
	<h2>1. include 지시자 (정적 include 방식)</h2>
	<p>
		다른 페이지를 포함하는 JSP 파일이 컴파일 되기 전에 페이지에 삽입된다.
	</p>
	<%-- 
	정적 include 방식은 해당 지시자를 include 하면 해당 include 페이지로 권한이 넘어간다.
	<%@ include file="includePage.jsp" %>
	
	Include 한 페이지의 year 변수 값은 <%= year %> 입니다. <br>
	
	<%
		// 현재 페이지와 현재 페이지에 포함된 includePage의 변수명이 중복되어 
		// Duplicate local variable 에러가 발생한다.
		// String year = "2023";
	%>
	--%>
	
	<h2>2. include 액션 태그 (동적 include 방식)</h2>
	<p>
		다른 페이지를 포함하는 JSP 파일이 화면에 출력되는 시점(런타임)에 삽입된다.
	</p>
	
	<%-- 
	동적 include 방식은 해당 지시자를 include 하면 해당 include 페이지로 권한이 넘어갔다가
	다시 본 페이지로 넘어온다 즉 런타임 시에만 includePage.jsp로 권한이 넘어갔다 돌아옴.
	--%>
	<jsp:include page="includePage.jsp"/>
	
	<% 
		 // 권한이 넘어갔다 돌아오기 때문에 변수명을 중복해서 지정해 주어도 에러가 나지 않음 
		 String year = "2023";
	%>
	
	include.jsp 한 페이지의 year 변수 값은 <%= year %> 입니다. <br>
	
	<%-- jsp:param 액션 태그를 이용해서 포함되는 페이지로 값을 전달할 수 있다. --%>
	<jsp:include page="includePage.jsp">
		<jsp:param value="서호정" name="userName"/>
	</jsp:include>
	
	
	
</body>
</html>