<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>application 영역과 session 영역을 비교</title>
</head>
<body>
	<h2>application 영역과 session 영역을 비교</h2>
	
	<%-- application은 서버가 종료될 때까지 유효범위를 가지고 session은 브라우저가 종료될 때까지
	 유효범위를 가진다. 즉 getAttribute 메소드를 통해 index.jsp 파일에 객체를 생성해
	 정보를 담아 현재 jsp 페이지에 해당 객체를 사용했을 때 서버가 돌아가고 있는 동안에 
	 application 안에 담긴 정보는 소멸되지 않고, 브라우저가 종료 됐다면 session 안에 담긴 정보는
	 소멸된다. --%>
	
	현재 application 영역에 저장된 데이터 : <%= application.getAttribute("name") %> <br>
	현재 session 영역에 저장된 데이터 : <%= session.getAttribute("address") %>
	
	
</body>
</html>