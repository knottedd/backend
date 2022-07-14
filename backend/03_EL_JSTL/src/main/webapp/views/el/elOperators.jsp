<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.kh.el.model.vo.Student"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EL 연산자</title>
</head>
<body>

	<h1>EL 연산자</h1>
	
	<h2>1. 산술 연산자</h2>
	10 + 5 = ${ 10 + 5 } <br>
	10 - 5 = ${ 10 - 5 } <br>
	10 * 5 = ${ 10 * 5 } <br>
	10 / 5 = ${ 10 / 5 } 또는 <%-- ${ 10 div 5} --%> <br>
	10 % 7 = ${ 10 % 7 } 또는 ${ 10 mod 7} <br>

	<h2>2. 논리 연산자</h2>
	true && false = ${ true && false } 또는 ${ true and false } <br>
	true || false = ${ true || false } 또는 ${ true or false }<br>
	!(10 > 5) = ${ !(10 > 5) } 또는 ${ not (10 > 5) } <br>
	
	<h2>3. 비교 연산자</h2>
	<h3>1) 객체 비교</h3>
	<%
		// EL은 영역 객체의 속성(Attribute)에 접근해서 값을 가져오기 때문에
		// 스크립트릿에 선언된 변수는 가져올 수 없다.
		String str1 = new String("하이");
		String str2 = new String("하이");
		Student student1 = new Student("홍길동", 20, 80, 80); 
		Student student2 = new Student("성춘향", 18, 100, 100);
		
		// page 영역에 데이터 저장
		pageContext.setAttribute("str1", "하이!");
		pageContext.setAttribute("str2", "하이!");
		pageContext.setAttribute("student1", new Student("홍길동", 20, 80, 80));
		pageContext.setAttribute("student2", new Student("성춘향", 18, 100, 100));
	
	%>
	
	<%--
	str1 : ${ str1 }

	str1 : ${ str1 }<br>
	str2 : ${ str2 }<br>
	student1 : ${ student1 }<br>
	student2 : ${ student2 }<br>
	--%>
	
	<table border="1">
		<tr>
			<th>비교식</th>
			<th>표현식 태그</th>
			<th>EL</th>
		</tr>
		<tr>
			<td>str1 == str2</td>
			<td><%= str1 == str2 %></td>
			<%-- 
			<td><%= str1.equals(str2) %></td>
			--%>
			<!-- EL의 == 연산은 주소값 비교가 아닌 equals()와 같이 속성 값을 비교한다. -->
			<td>${ str1 == str2 } 또는 ${ str1 eq str2 }</td> 
		</tr>
		<tr>
			<td>str1 != str2</td>
			<td><%= str1 != str2 %></td>
			<td>${ str1 != str2 } 또는 ${ str1 ne str2 }</td>
		</tr>
		<tr>
			<td>student1 == student2</td>
			<td><%= student1 == student2 %></td>
			<td>${ student1 == student2 } 또는 ${ student1 eq student2 }</td>
		</tr>
		<tr>
			<td>student1 != student2</td>
			<td><%= student1 != student2 %></td>
			<td>${ student1 != student2 } 또는 ${ student1 ne student2 }</td>
		</tr>
		
	</table>
	
	<h3>2) 숫자 비교 연산</h3>
	<%
		// pageContext.setAttribute("big", 10);
		// pageContext.setAttribute("big", "10");
		pageContext.setAttribute("big", 'a');
		pageContext.setAttribute("small", 3);
	%>
	
	<!-- Object 타입 끼리는 더하기 연산이 성립되지 않는다.  -->
	표현식 태그 : <%-- <%= pageContext.getAttribute("big") + pageContext.getAttribute("samll") --%>
	<!-- Object 타입 끼리는 비교 연산 성립되지 않는다.  -->
	표현식 태그 : <%-- <%= pageContext.getAttribute("big") > pageContext.getAttribute("samll") --%>
	
	<br><br>
		
	
	<!--  EL은 영역 객체에 속성으로 담긴 Object 타입을 자동으로 인식해서 형 변환 후 연산을 처리한다. -->
	EL : ${ big + samll } <br>
	<!--  자동 형 변환으로 인해서 비교 연산도 가능하다. -->
	big > samll : ${ big > samll } 또는 ${ big gt samll }<br>
	big < samll : ${ big < samll } 또는 ${ big lt samll }<br>
	big >= samll : ${ big >= samll } 또는 ${ big ge samll }<br>
	big <= samll : ${ big <= samll } 또는 ${ big le samll }<br>
	
	<h3>3) 객체가 null 또는 비어있는지 체크하는 연산지</h3>
	<%
		String str = null;
		List<String> list = new ArrayList<>();
		
		list.add("안녕하세요.");
		
		pageContext.setAttribute("str", str);
		pageContext.setAttribute("list", list);
	%>
	
	표현식 태그 : <%= str == null %>, <%= list.isEmpty() %>  <br>
	EL : ${ str == null }, ${ empty str }, ${ list == null }, ${ empty list } <br> 
	EL : ${ not empty str }, ${ not empty list } <br>

	
	
</body>
</html>