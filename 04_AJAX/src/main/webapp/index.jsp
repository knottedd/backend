<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="path" value="${ pageContext.request.contextPath }" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AJAX(Asynchronous JavaScript and XML)</title>

<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>

</head>
<body>
	<h1>AJAX(Asynchronous JavaScript and XML)</h1>
	<h2>1. Javascript를 이용한 AJAX 테스트</h2>
	<h3>1) GET 방식으로 서버에 데이터 전송 및 응답</h3>
	
	<button onclick="jsAjaxTest1();">GET 방식 전송</button>
	
	<p id="area1"></p>
	
	<script>
		function jsAjaxTest1() {
			// 1. XMLHttpRequest 객체 생성
			let xhr = new XMLHttpRequest();
			
			/*
			// 브라우저 호환성 체크
			if (window.XMLHttpRequest) { // 모질라, 사파리, IE7+ ...
			    httpRequest = new XMLHttpRequest();
			} else if (window.ActiveXObject) { // IE 6 이하
			    httpRequest = new ActiveXObject("Microsoft.XMLHTTP");
			}
			*/
			
			// 2. onreadystatechange 속성에 콜백함수 지정
			//   - 비동기 통신에 대한 응답 상태에 변경이 있을 경우 실행된다.
			xhr.onreadystatechange = function () {
				// 1) readyState : AJAX 통신 진행 상황
				//    0 : 요청이 초기화 되지 않은 상태
				//    1 : 서버와의 연결이 설정된 상태
				//    2 : 서버가 요청을 받은 상태
				//    3 : 서버가 요청을 처리하는 상태
				//    4 : 서버가 요청에 대한 처리가 끝나고 응답을 준비한 상태
				console.log(xhr.readyState);
				
				// 서버 응답 준비가 완료되면 실행되는 구문 작성 
				if(xhr.readyState == 4) {
					// 2) status : HTTP 응답 상태 코드
					//    200 : OK
					//    403 : Forbidden
					//    404 : Not Found
					//    500 : Internal Server Error
					console.log(xhr.status);
					// 서버 응답이 완료되면 실행되는 구문 작성
					if (xhr.status == 200) {
						// 서버에서 응답한 데이터를 담고 있는 속성
						console.log(xhr.responseText);		
						
						document.getElementById("area1").innerHTML = xhr.responseText;
					} else {
						console.log("통신 실패 : " + xhr.status);
					}
				}
				
				
				
			}
			
			// 3. open() 호출
			//   - 서버와 통신에 필요한 정보를 입력한다. (요청 방식, 대상(서버), 동기/비동기 여부(default : true)) 
			xhr.open("GET", "${ path }/jsAjax.do?name=서호정&age=27", true);
			
			// 4. send() 호출
			//   - 서버에 요청을 한다.
			xhr.send();
		}
	</script>
	
	<h3>2) POST 방식으로 서버에 데이터 전송 및 응답</h3>
	
	<button onclick="jsAjaxTest2();">POST 방식 전송</button>
	
	<p id="area2"></p>
	
	<script>
		function jsAjaxTest2() {
		// 1. XMLHttpRequest 객체 생성
		let xhr = new XMLHttpRequest();
		
		// 2. onreadystatechange 콜백 함수 생성
		// xhr.readyState == 4랑 == DONE이랑 같은 조건이다.
		xhr.onreadystatechange = () => {
			if(xhr.readyState === XMLHttpRequest.DONE && xhr.status === 200) {
				document.getElementById("area2").innerHTML = xhr.responseText;
			} 
		};
		
		// 3. open() 메소드 호출
		xhr.open("POST", "${ path }/jsAjax.do", true);
		
		// * post 요청의 경우 send() 메소드 호출 전에 아래와 같이 요청 헤더를 추가해야 한다.
		xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded")
		
		// 4. send() 메소드 호출
		xhr.send("name=서호정&age=27");
		
		
		}	
	
	
	</script>
	
	<h2>2. JQuery를 이용한 AJAX 테스트</h2>
	<h3>1) GET 방식으로 서버에 데이터 전송 및 응답</h3>
	
	입력 : <input type="text" id="input1" size="30" /> <br>
	출력 : <input type="text" id="output1" size="30" readonly /> <br><br>
	
	<button id="btn3">GET 방식 전송</button>
	
	
	<h3>2) POST 방식으로 서버에 여러 개의 데이터 전송 및 응답</h3>
	
	이름 : <input type="text" id="name" /> <br>
	나이 : <input type="text" id="age" /> <br>
	출력 : <input type="text" id="output2" size="30" readonly /> <br><br>
	
	<button id="btn4">POST 방식 전송</button>
	
	<h3>3) 서버에 데이터 전송 후, 응답을 객체(Object)로 받기</h3>
	<!-- maven repository 사이트에서 gson 라이브러리를 .jar 파일로 다운 후 lib에 넣어줘야 함. -->
	회원 번호 : <input type="text" id="userNo"/>
	
	<button id="btn5">조회</button> <br><br>
	
	<textarea id="textarea5" rows="5" cols="60"></textarea>
	
	<h3>4) 서버에 데이터 전송 후, 응답을 리스트(List)로 받기</h3>
	
	성별 : 
	<label> <input type="radio" name="gender" value="남자" checked>남자</label>
	<label> <input type="radio" name="gender" value="여자">여자</label>
	
	<button id="btn6">조회</button> <br><br>
	
	<textarea id="textarea6" rows="5" cols="60"></textarea>
	
	
	<script>
		$(document).ready(function() {
			// GET 방식
			$("#btn3").on("click", function () {
				let input = $("#input1").val();
				
				$.ajax({
					// 전송 방식(GET, POST)
					type: "GET",
					url: "${ path }/jqAjax1.do",
					// 요청 시 전달할 파라미터 설정
					// data는 객체형태로 넘겨주어야 한다.
					data: {
						input // 'input': input 과 같다.
					},
					// AJAX 통신 성공 시 실행 될 콜백함수
					success: function(data) {
						console.log(data);
						
						$("#output1").val(data);
					},
					// AJAX 통신 실패 시 실행 될 콜백함수
					error: function(error) {
						console.log(error);
					},
					// AJAX 통신 성공 여부와 상관없이 실행될 콜백함수
					complete: function() {
						console.log("complete");
					}
					
				});
			});
			
			// POST 방식
			$("#btn4").on("click", () => {
				let name = $("#name").val();
				let age = $("#age").val();
				
				$.ajax({
					type: "POST",
					url: "${ path }/jqAjax1.do",
					data: {
						// 프로퍼티와 값 형식으로 넣어주어야 한다.
						// 값과 프로퍼티가 같으면 하나만 넣어주어도 된다.
						name, //'name': name,
						age, //'age': age
					},
					success: (data) => {
						console.log(data);
						
						$("#output2").val(data);
					},
					error: (error) => {
						console.log(error);
					}
				});
			});
			
			// JSON(객체) 방식
			$("#btn5").on("click", () => {
				let userNo = $("#userNo").val();
				
				$.ajax({
					type: "GET",
					url: "${ path }/jqAjax2.do",
					dataType: "json", // 응답 데이터 형식
					data: {
						userNo
					},
					success: (obj) => {
						console.log(obj);
						
						let result = "";
						
						if(obj !== null) {
							result = "회원 번호 : " + obj.no + ", 이름 : " + obj.name + 
									 ", 나이" + obj.age + ", 성별 : " + obj.gender;
						} else {
							result = "사용자 정보가 없습니다.";
						}
						
						$("#textarea5").val(result);
					},
					error: (error) => {
						console.log(error);
					}
				});
				
			});
			// JSON(리스트) 방식
			$("#btn6").on("click", () => {
				let gender = $("input[name=gender]:checked").val();
				
				$.ajax({
					type: "POST", 
					url: "${ path }/jqAjax2.do",
					dataType: "json",
					data: {
						gender // 'gender': gender
					},
					success: (list) => {
						console.log(list);
						
						let result = "";
						
						// 배열 요소를 반복해주는 반복자 역할
						$.each(list, (i) => {
							result += 
								"회원 번호 : " + list[i].no + 
								", 이름 : " + list[i].name + 
								", 나이 : " + list[i].age + 
								", 성별 : " + list[i].gender + "\n";
						});
						
						$("#textarea6").val(result);
					},
					error: (error) => {
						console.log(error);
					}
					
				});
				
			});
			
			
			
		});
	
	
	</script>
	
	
	
	
</body>
</html>