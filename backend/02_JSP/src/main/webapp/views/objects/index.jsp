<%@page import="java.util.Date"%>
<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP 내장 객체</title>
</head>
<body>
	<h1>JSP 내장 객체</h1>
	<%-- 
	<%
		String out = "";
	%>
	--%>
	
	<h2>1. request 객체</h2>
	<p>
		웹 브라우저의 요청 정보를 가지고 있는 객체이다.
	</p>
	
	<h3>1) 헤더와 관련된 메소드</h3>
	<table border="1">
		<tr>
			<th>헤더</th>
			<th>값</th>
		</tr>
		<%
		Enumeration<String> names = request.getHeaderNames();
		
		// names 객체 안에 요소가 전부 없어질때까지 반복문 실행
		while(names.hasMoreElements()) {
			String name = names.nextElement();
		%>
			<tr>
			<td><%= name %></td>
			<td><%= request.getHeader(name) %></td>
		 	</tr>
		<%	
		}
		%>
	</table>
	
	<h3>2) URL/URI, 요청 방식과 관련된 메소드</h3>
	<table border="1">
		<tr>
			<th>이름</th>
			<th>값</th>
		</tr>
		<tr>
			<td>서버 도메인명</td>
			<td><%= request.getServerName() %></td>
		</tr>
		<tr>
			<td>서버 포트 번호</td>
			<td><%= request.getServerPort() %></td>
		</tr>
		<tr>
			<td>URL</td>
			<td><%= request.getRequestURL() %></td>
		</tr>
		<tr>
			<td>URI</td>
			<td><%= request.getRequestURI() %></td>
		</tr>
		<tr>
			<td>요청 쿼리</td>
			<td><%= request.getQueryString() %></td>
		</tr>
		<tr>
			<td>프로토콜</td>
			<td><%= request.getProtocol() %></td>
		</tr>
		<tr>
			<td>요청 방식</td>
			<td><%= request.getMethod() %></td>
		</tr>
		<tr>
			<td>웹 애플리케이션 경로</td>
			<td><%= request.getContextPath() %></td>
		</tr>
		<tr>
			<td>클라이언트의 IP 주소</td>
			<td><%= request.getRemoteAddr() %></td>
		</tr>
		<tr>
			<td>클라이언트의 호스트 이름</td>
			<td><%= request.getRemoteHost() %></td>
		</tr>
		
	</table>
	
	<h2>2. response 객체</h2>
	<p>
		웹 브라우저의 요청에 대한 응답 객체이다.
	</p>
	
	<h3>1) Redirect</h3>
	<p>
		sendRedirect(String url); <br>
		매개값으로 지정한 URL로 요청을 재전송한다.
		리다이렉트 방식은 요청과 응답객체를 새로 생성하므로 이전 요청과 응답 정보가 유지되지 않는다.
	</p>
	
	<%-- redirect에 있는 jsp 파일의 response.sendRedirect 메소드를 통해 
	     redirect_target으로 요청과 응답객체를 브라우저가 다시 받음 --%>
	<a href="redirect.jsp">Redirect 테스트</a>
	
	<h2>3. pageContext</h2>
	<p>
		JSP와 관련된 다른 내장 객체를 얻어내거나 현재 페이지의 요청과 응답의 제어권을 다른 페이지로 넘겨주는데 사용하는 객체이다.
	</p>
	
	<h3>1) Forward</h3>
	<p>
		forward(String url); <br>
		매개값으로 지정한 URL로 요청과 응답에 관한 제어권을 영구적으로 넘긴다.
		포워드 방식은 현재 페이지의 요청과 응답 정보를 다른 페이지로 넘기기 때문에 요청 정보와 응답 정보가 유지된다.
	</p>
	
	<%-- forward.jsp 파일에서 pageContext.forward 메소드를 통해 forward_target.jsp
	     로 요청을 보냈지만 url은 forward_target.jsp가 아닌 forward.jsp로 요청 url이 바뀌지 않는다.  --%>
	<a href="forward.jsp">Forward 테스트</a>
	
	<h2>4. session 객체</h2>
	<%-- 세션은 클라이언트와 유저의 정보를 서버에 저장. 브라우저가 종료될 때까지 정보가 유지된다.
		 보통은 클라이언트와 서버는 요청과 응답이 끝나면 정보가 없어짐. 하지만 세션은 브라우저가 종료될 때까지 상태 유지
	     서버에 저장하기 때문에 보안에 유리. ex) 로그인 정보 --%>
	<p>
		웹 브라우저의 정보를 유지하기 위한 세션 정보를 저장하고 있는 객체이다.
	</p>
	<% 
		// 쿠키도 기능적으론 세션과 비슷하지만 세션처럼 서버에 저장하지 않고 클라이언트에 저장함.
		// 보안적으로 중요한 로그인 상태는 세션에 저장. 하지만 장바구니 같이 보안적으로 크게 중요하지
		// 않지만 클라이언트 상태를 계속 유지해야하는 상황엔 쿠키에 저장
		// 쿠키 생성
		Cookie cookie = new Cookie("userId", "knotted");
	
		// 쿠키의 유지 시간 지정 메소드
		// 10초가 지나면 쿠키가 삭제됐다가 새로고침 됐을때 다시 생성
		cookie.setMaxAge(10);
	
		response.addCookie(cookie);
		
		// 세션의 유지 시간 지정 메소드 (매개값은 밀리세컨드가 아닌 세컨드 단위)
		// 세션을 만든 후 클라이언트가 그 세션을 유지하고 있는 시간이 10초가 넘으면 소멸
		// 10초가 지나면 세션 아이디가 삭제됐다가 새로고침 됐을때 다시 생성
		session.setMaxInactiveInterval(10);
	%>
	세션 ID : <%= session.getId() %> <br>
	<%-- 요청이 됐을때 만들어진거면 true, 이미 만들어진 세션 객체이면 false --%>
	is New : <%= session.isNew() %> <br>
	생성 시간 : <%= new Date(session.getCreationTime()) %> <br>
	최종 접속 시간 : <%= new Date(session.getLastAccessedTime()) %> <br>
	
	<h2>5. Application 객체</h2>
	
	<p>
		웹 애플리케이션(컨텍스트)의 실행 환경을 제공하는 서버의 정보와 서버 측 지원에 대한 정보를 저장하고 있는 객체이다.
	</p>
	
	<table border="1">
		<tr>
			<td>JSP 버전</td>
			<td><%= application.getMajorVersion()%>.<%= application.getMinorVersion() %></td>
		</tr>
		<tr>
			<td>컨테이너 정보</td>
			<td><%= application.getServerInfo() %></td>
		</tr>
		<tr>
			<td>웹 애플리케이션의 실제 파일시스템 경로</td>
			<td><%= application.getRealPath("/") %></td>
		</tr>
	</table>
	
	</body>
</html>