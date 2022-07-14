<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>request 영역과 page 영역을 비교</h2>
	
	requestValue : <%= request.getAttribute("requestScope") %> <br>
	pageValue : <%= pageContext.getAttribute("pageScope") %>
	

</body>
</html>