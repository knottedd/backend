<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String year = "2022";
	// jsp:param 액션 태그로 include.jsp 페이지에 선언해준 값을 가져옴 
	// String userName = request.getParameter("userName");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>Include 페이지</h2>

	includePage.jsp 페이지의 year 변수 값은 <%= year %> 입니다. <br><br>
	
	<%-- EL을 사용하면 위에서 따로 getPrameter를 통해 변수에 받아올 필요 없음. --%>
	userName : ${ param.userName } <br><br>
</body>
</html>