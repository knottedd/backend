<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>jsp:forward 액션 태그</title>
</head>
<body>
	<h1>jsp:forward 액션 태그</h1>
	<p>
		현재 페이지의 요청과 응답에 대한 처리권을 다른 페이지로 넘기는 액션 태그이다.
	</p>
	
	<jsp:forward page="forwardPage.jsp"/>
	<%
		// 현재 페이지의 요청과 응답 처리권을 다른 페이지로 넘겨버리기 때문에 
		// jsp:forward 태그랑 똑같이 작동한다.
		pageContext.forward("forwardPage.jsp");
	%>
</body>
</html>