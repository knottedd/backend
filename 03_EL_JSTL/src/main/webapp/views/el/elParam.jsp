<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>주문내역</h2>
	
	<p>
		param : 해당 페이지 요청 시 전달된 파라미터 값을 받아올 때 사용하는 내장객체이다.<br>
		paramValues : 해당 페이지 요청 시 전달된 파라미터 값들을 배열로 받아올 때 사용하는 내장 객체이다.
	</p>
	
	상품명 : ${ param.pName } <br>
	수량 : ${ param.pCount } <br>
	<!--  
		옵션 값은 두 개지만 param 내장 객체를 통해서도 접근이 가능하다.
		(단, 첫 번째 값만 가져올 수 있다.)
	-->
	옵션(param.option) : ${ param.option } <br>
	옵션 1 : ${ paramValues.option[0] } <br>
	옵션 2 : ${ paramValues.option[1] } <br>
	
	
	
</body>
</html>