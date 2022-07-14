<%@page import="com.kh.el.model.vo.Student"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	// Request 영역에 저장된 속성(Attribute)룰 가져온다.
	// request.getAttribute는 반환값이 String이 아닌 최상위 객체인 object이고 
	// 객체형태로 저장되어있는 상태이기 때문에 하위 객체인 String에는 형변환 없이 들어가지 않는다.
	// String classRoom = request.getAttribute("classRoom");
	// String classRoom = (String) request.getAttribute("classRoom");
	// Student student = (Student) request.getAttribute("student");
	
	// Session 영역에 저장된 속성(Attribute)를 가져온다.
	// String classRoom = (String) session.getAttribute("classRoom");
	// Student student = (Student) session.getAttribute("student");
	
%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EL(Expression Language)</title>
</head>
<body>
	
	<h1>EL(Expression Language)</h1>
	
	<h2>1. 기존 방식으로 request, session 객체에 담겨 있는 데이터를 출력</h2>
	<%-- 
	강의장 : <%= classRoom %> <br>
	수강생 : <%= student.getName() %>, <%= student.getAge() %> <br>
	--%>
	
	<h2>2. EL 방식으로 request, session 객체에 담겨 있는 데이터를 출력</h2>
	<!-- 
		1. EL은 영역 객체에 저장된 속성명을 검색해서 존재하는 경우 값을 가져온다.
		   즉 기존 방식처럼 따로 객체 형태를 변수로 가져와 선언 하지 않아도 가져온다.
			- Page 영역 -> Request 영역 -> Session 영역 -> Application 영역
			  순으로 해당 속성을 찾아서 값을 가져온다.
		2. EL은 객체의 필드에 직접 접근하는 것 처럼 보이지만 내부적으로는 해당 객체의 Getter
		   메소드로 접근해서 값을 읽어 온다. 즉 Student.java에서 선언한 객체 안 요소들이 
		   private이기 때문에 직접 접근 없이 Getter를 이용해 가져와야 하지만 EL은 바로
		   Getter 메소드로 접근 한다.  
	 -->
	강의장 : ${ classRoom } <br>
	수강생 : ${ student.name }, ${ student.age } <br>
	강의장 : ${ sessionScope.classRoom } <br>
	수강생 : ${ sessionScope.student.name }, ${ sessionScope.student.age }
	
	<h2>3. EL 방식 사용 시 내장 객체에 저장된 속성명이 같은 경우</h2>
	<%-- 
		scope라는 속성명이 각 내장 객체에 똑같인 이름으로 저장되어 있을때 순서에 의해
		pageContext 객체를 통해 가져온 scope를 가지고 온다.
		특정 내장 객체의 속성을 가지고 오고 싶다면 requestScope, sessionScope, 
		applicationScope 처럼 명시적으로 scope를 지정해 원하는 값을 가지고올 수 있다.
	 --%>
	<%
		pageContext.setAttribute("scope", "page");
	%>
	scope: ${ scope } <br>
	requestScope : ${ requestScope.scope }<br>
	sessionScope : ${ sessionScope.scope }<br>
	applicationScope : ${ applicationScope.scope }<br>
	
	<h2>4. contextPath 가져오기</h2>
	<%-- contextPath는 톰캣에서 구동되고 있는 애플리케이션을 찾아가기 위한 경로 --%>
	
	<h3>1) 표현식 태그를 사용하는 방법 </h3>
	ContextPath : <%= request.getContextPath() %>  
	
	
	<h3>2) EL을 사용하는 방법 </h3>
	Contextpath : ${ pageContext.request.contextPath }
	
	<h2>5. 헤더에서 접근하기</h2>
	<h3>1) 표현식 태그를 사용하는 방법 </h3>
	Host : <%= request.getHeader("host") %> <br>
	User-Agent : <%= request.getHeader("User-Agent") %>
	
	<h3>2) EL을 사용하는 방법 </h3>
	Host : ${ header.host }
	User-Agent : ${ header['User-Agent'] }
	
	
</body>
</html>