<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>영역(Scope)</h1>
	
	<h2>application 영역과 session 영역을 비교</h2>
	
	<%
		application.setAttribute("name", "서호정");
		session.setAttribute("address", "경기도");
		
	%>
	
	<a href="scopeTest1.jsp">View Details</a>
	
	<h2>request 영역과 page 영역을 비교</h2>
	
	
	<a href="scopeTest2.jsp">View Details</a>
	
</body>
</html>