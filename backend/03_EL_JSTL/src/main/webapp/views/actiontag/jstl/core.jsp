<%@page import="java.util.ArrayList"%>
<%@page import="com.kh.el.model.vo.Student"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSTL Core Tags</title>
</head>
<body>
	<h1>JSTL Core Tags</h1>
	
	<h2>1. 변수</h2>
	<h3>1) 변수 선언(c:set)</h3>
	
	<p>
		변수를 선언하고 초기 값을 대입하는 태그이다
	</p>
	
	<c:set var="number1" value="10"/>
	<c:set var="number2" value="10" scope="request"/>
	<c:set var="result" value="${ number1 + number2 }" scope="session"/>
	<c:set var="array">
		red, blue, yellow, pink, green
	</c:set>
	
	number1 : ${ number1 } 또는 ${ pageScope.number1 } <br>
	number1 : <%= pageContext.getAttribute("number1") %> <br>
	number2 : ${ number2 } 또는 ${ requestScope.number2 } <br>
	result : ${ result } 또는 ${ sessionScope.result } <br>
	array : ${ array } 또는 ${ pageScope.array } <br>
	
	<h3>2) 변수 삭제(c:remove)</h3>
	
	<p>
		c:set 태그로 선언한 변수를 삭제할 때 사용하는 태그이다.
	</p>
	
	<c:set var="result" value="99999" />
	<c:set var="result" value="10000" scope="request" />
	
	삭제 전 : ${ result }
	
	<h4>* 특정 scope에 변수 삭제</h4>
	<c:remove var="result" scope="page" />
	
	삭제 후 : ${ result }
	
	<h4>* 모드 scope에 변수 삭제</h4>
	<c:remove var="result"/>
	
	삭제 후 : ${ result }
	
	<br>
	
	<h2>2. 출력</h2>
	
	<p>
		클라이언트로 데이터를 출력할 때 사용하는 태그이다.
	</p>
	<%-- escapeXml 옵션이 트루이면 태그도 문자열로 인식된다. 기본값이 true --%>
	태그를 문자열로 출력 : <c:out value="<b>태그로 출력하기</b>" escapeXml="true" /> <br>
	태그를 해석하여 출력 : <c:out value="<b>태그로 출력하기</b>" escapeXml="false" /> <br>
	<%-- result는 c:remove 변수에 의해 값을 삭제한 상태. 값이 없을때 default 속성을 이용해
	     기본 값을 출력해 줄 수 있다. --%>
	태그를 해석하여 출력 : <c:out value="${ result }" default="값이 없음..!" />
	
	<h2>3. 조건문</h2>
	<h4>1) c:if 태그</h4>
	<p>
		자바의 if 구문과 같은 역할을 하는 태그이다.<br>
		조건식은 test 속성에 EL 구문으로 기술해야 한다.
	</p>
	
	<c:if test="${ number1 > number2 }">
		<b>number1이 number2보다 크다.</b>
	</c:if>
	
	<c:if test="${ number1 < number2 }">
		<b>number1이 number2보다 작다.</b>
	</c:if>
	
	<h4>2) c:choose 태그</h4>
	<p>
		자바의 switch 구문과 같은 역할을 하는 태그이다.
		하위 태그인 c:when, c:otherwise 태그와 함께 사용되는데, 
		각각 switch 구문의 case, default 절과 비슷한 역할을 한다.
	</p>
	
	<c:choose>
		<c:when test="${ number1 > number2 }">
		<b>number1이 number2보다 크다.</b>
		</c:when>
		
		<c:when test="${ number1 < number2 }">
		<b>number1이 number2보다 작다.</b>
		</c:when>
		
		<c:otherwise>
		<b>number1이 number2보다 크거나 작지 않다.</b>
		</c:otherwise>
	</c:choose>
	
	<h2>4. 반복문</h2>
	<h4>1) c:forEach 태그</h4>
	<p>
		자바의 for 구문에 해당하는 역할을 하는 태그이다.
	</p>

	<%-- 자바의 for 구문처럼 사용하기 --%>
	<%-- step 속성을 통해 증가 값을 정해줄 수 있으나 step의 값은 1보다 작을 수 없다. --%>
	<c:forEach var="i" begin="1" end="6" step="2">
		<h${ i }>반복 확인 : ${ i }</h${ i }>
	</c:forEach>
	
	<%-- 자바의 향상된 for 구문처럼 사용하기 --%>
	<c:forEach var="color" items="${ array }">
		${ color } <br>
	</c:forEach>
	
	<%
		List<Student> list = new ArrayList<>();
	
		list.add(new Student("서호정", 20, 80, 80));
		list.add(new Student("홍길동", 30, 70, 90));
		list.add(new Student("성춘향", 20, 100, 100));
		list.add(new Student("이몽룡", 20, 70, 70));
		
		pageContext.setAttribute("list", list);
	%>
	
	<%-- varStatus 옵션은 forEach에 대한 상태 속성을 가지고 있는 객체이다. --%>
	<h5>* 학생 목록 조회</h5>
	<table border="1">
		<tr>
			<th>인덱스</th>
			<th>순번</th>
			<th>First</th>
			<th>Last</th>
			<th>이름</th>
			<th>나이</th>
			<th>수학 점수</th>
			<th>영어 점수</th>
		</tr>
		<c:forEach var="student" items="${ list }" varStatus="status">
			<tr>
				<td>${ status.index }</td>
				<td>${ status.count }</td>
				<td>${ status.first }</td>
				<td>${ status.last }</td>
				<td>${ student.name }</td>
				<td>${ student.age }</td>
				<td>${ student.math }</td>
				<td>${ student.english }</td>
			</tr>
		</c:forEach>
	</table>
	
	<h4>2) c:forTokens 태그</h4>
	<p>
		문자열에 포함된 구분자를 통해 토큰을 분리해 반복을 수행하는 태그이다.
	</p>
	<%-- 
		 items엔 객체를 담고있는 변수가 들어가도 되며, delims 옵션은 구분자를 지정해주는 역할
		 이다. 또한 여러 구분자를 한번에 지정해 줄 수 있다.
	 --%>
	<ul>
	<c:forTokens var="device" items="컴퓨터,노트북,핸드폰,에어컨/TV,냉장고.세탁기" delims=",/.">
		<li>${ device }</li>
	</c:forTokens>
	</ul>
	
	<ul>
		<c:forTokens var="color" items="pink aqua tomato yellow lime" delims=" ">
			<li style="background-color : ${ color }">${ color }</li>
		</c:forTokens>
	</ul>
	
	<h2>5. c:url 태그</h2>
	<p>
		URL을 생성하고 쿼리 스트링을 미리 설정하는 태그이다.
	</p>
	
	<%-- elparam url로 param값을 넣은 채 전송. --%>
	<c:url var="url" value="/views/el/elParam.jsp">
		<c:param name="pName" value="아이폰 12" />
		<c:param name="pCount" value="2" />
		<c:param name="option" value="화이트" />
		<c:param name="option" value="64GB" />
	</c:url>
	
	<a href="${ url }">이동</a>

</body>
</html>