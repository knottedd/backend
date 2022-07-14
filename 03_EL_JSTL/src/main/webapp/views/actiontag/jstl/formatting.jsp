<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSTL Formatting Tags</title>
</head>
<body>
	<h1>JSTL Formatting Tags</h1>
	
	<h2>1. fmt:formatNumber</h2>
	<p>
		숫자 데이터의 포맷을 지정할 때 사용하는 태그이다.
	</p>
	
	<!--  groupingUsed 속성 : 숫자 단위의 구분자(,) 표시 여부를 지정한다. (기본값 : true) -->
	숫자 출력 : <fmt:formatNumber type="number" value="123456789" groupingUsed="false" /><br>
	세 자리 마다 구분하여 숫자 출력 : <fmt:formatNumber type="number" value="123456789" groupingUsed="true" /><br><br>
	
	<!-- 
		pattern 속성 : 화면에 표시할 숫자 데이터의 패턴을 지정한다.
		#, 0을 패턴 기호로 사용하여 지정한다. 패턴 기호를 초과하는 부분은 반올림 되고,
		부족한 부분에 대해서는 #은 표시 하지 않지만 0은 0으로 표시한다. 
	 -->
	#을 이용해서 pattern 지정 : <fmt:formatNumber value="1.23" pattern="#.###" /><br>
	#을 이용해서 pattern 지정 : <fmt:formatNumber value="1.2346" pattern="#.###" /><br>
	0을 이용해서 pattern 지정 : <fmt:formatNumber value="1.23" pattern="0.000" /><br>
	0을 이용해서 pattern 지정 : <fmt:formatNumber value="1.2346" pattern="0.000" /><br><br>
	
	<!-- 
		type 속성 : number(숫자, 기본값), currency(통화), percent(백분율)
	 -->
	숫자 : <fmt:formatNumber value="50000" /> <br>
	통화 : <fmt:formatNumber type="currency" value="50000" /> <br>
	통화 : <fmt:formatNumber type="currency" currencySymbol="$" value="50000" /> <br>
	<!-- 1이 100%. 70%를 표현하고 싶다면 0.7 -->
	백분율 : <fmt:formatNumber type="percent" value="0.7" /> <br><br>
	
	<h2>2. fmt:formatDate</h2>
	<p>
		날짜와 시간 데이터의 포맷을 지정할 때 사용하는 태그이다. 
	</p>
	
	<c:set var="date" value="<%= new java.util.Date() %>" />
	<!-- type 송성 생략 가능 (기본값: date) -->
	<fmt:formatDate value="${ date }"/>
	
	<ul>
		<li>날짜 : <fmt:formatDate type="date" value="${ date }"/> </li>
		<li>시간 : <fmt:formatDate type="time" value="${ date }"/> </li>
		<li>날짜 시간 둘 다 : <fmt:formatDate type="both" value="${ date }"/> </li>
		<li>short : <fmt:formatDate type="both" dateStyle="short" timeStyle="short" value="${ date }"/> </li>
		<li>medium : <fmt:formatDate type="both" dateStyle="medium" timeStyle="medium" value="${ date }"/> </li>
		<li>long : <fmt:formatDate type="both" dateStyle="long" timeStyle="long" value="${ date }"/></li>
		<li></li>
		<li></li>
	</ul>
	
	
</body>
</html>