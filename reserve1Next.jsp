<%@page import="reserve.vo.Reserve"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	Reserve r = (Reserve) request.getAttribute("rsv");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="/js/jquery-3.3.1.js"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script>
	var arr = new Array(4);
	var seat = new Array(4);
	for (var i = 0; i < arr.length; i++) {
		arr[i] = "";
		seat[i] = "";
	}
	var totalFee = 0;
	$(function() {
		$(".seatTbl1 td").click(function() {
			var selMember = Number($("[name=selMember]").val());
			var seatRow = $(this).siblings("th").text();
			var seatNum = $(this).text();
			var str = seatRow + seatNum;
			console.log("선택한 좌석:" + str);

			if (selMember == 0) { // 인원 선택 : 0
				alert('인원을 추가해주세요.');
				return;
			} else if (selMember - 1 < $(".checkedSeat").length) { // 설정한 인원, 선택된 좌석 수
				return;
			} else if (arr.indexOf(str) != -1) { // 배열의 값이 str과 일치하지 않는다면 true
				return;
			} else if ($(".checkedSeat").length == 4) { // 선택된 좌석이 4개인 경우 true
				return;
			}

			$(this).addClass("checkedSeat");
			$(this).css("border", "1px solid green");
			$(this).css("background-color", "blue");
			$(this).css("color", "white");

			var selSeatTr = $(".seatTbl2 tr").not(".seatTbl2 tr:first-child");
			var isBlank = true;
			selSeatTr.each(function(index, item) { // index : 최소 0 ~ 최대 3까지
				arr[index] = $(item).text();

				if ($(item).text() == "") {
					$(item).children().eq(0).text(seatRow);
					$(item).children().eq(1).text(seatNum);
					arr[index] = str;
					isBlank = false;
					return isBlank;
				}
			});
		});

		$(".seatTbl1 td").dblclick(function() {
			$(this).removeAttr("style");
			$(this).removeClass();

			var seatRow = $(this).siblings("th").text();
			var seatNum = $(this).text();
			var str = seatRow + seatNum;

			var selSeatTr = $(".seatTbl2 tr").not(".seatTbl2 tr:first-child");
			if (selSeatTr.is("tr")) { // 인원 선택한만큼 추가되는 tr, 있으면 true
				selSeatTr.each(function(index, item) { // index : 최소 0 ~ 최대 3까지
					delRow = $(item).children().eq(0);
					delNum = $(item).children().eq(1);
					if (delRow.text() == seatRow && delNum.text() == seatNum) {
						delRow.text("");
						delNum.text("");
						arr[index] = "";
					}
				});
			}
		});
		
		var payInfo1 = $(".confirmSeat>li:nth-child(3)");
		var payInfo2 = $(".confirmSeat>li:nth-child(4)");
		
		$("[name=confirmSeat]").click(function(){
			var msg = $("#msg");		
			payInfo1.hide();
			payInfo2.hide();
			$("#result").text("");

			var currentTrLen = $(".seatTbl2 tr").not(".seatTbl2 tr:first-child").length;
			if(currentTrLen == 0){
				msg.text("먼저 인원을 추가해주세요.");
				msg.show(1000).delay(2000).hide(1000);
				return;
			}
			
			var str = "선택된 좌석 수:"+currentTrLen+"<br>";
			
			for(var i=0;i<arr.length;i++){
				seat[i] = "";	
			}
			
			for(var i=0;i<currentTrLen;i++){
				if(arr[i] == ""){
					msg.text("좌석 선택을 먼저 해주세요.");
					msg.show(1000).delay(2000).hide(1000);
					return;
				}
				seat[i] = arr[i];
			}
			var fee = 5000;
			userFee = fee*currentTrLen
			totalFee = (String)(userFee);
			totalFee = totalFee.replace(/\B(?=(\d{3})+(?!\d))/g,",");
			// 정규표현식						   
			// \B : 첫번째 문자가 단어가 아닌 경우
			// ?= : 찾는다
			// ?!\d : 전방에 숫자가 있으면
			// \d{3} : 세자리숫자 다음
			// g : 전체 검색
			str += "결제 금액:"+totalFee+"원";
			msg.text("결제를 진행하려면 계속하세요.");
			
			$("#result").append(str);
			
			msg.show(1000);
			payInfo1.show();
			payInfo2.css("display","inline-block");
		});
		$("[name=payment]").click(function(){
			var d = new Date(); // 결제가 되었을 때 고유번호(결제 번호)를 만듦.
			var date = d.getFullYear()+""+(d.getMonth()+1)+""+d.getDate()
						+""+d.getHours()+""+d.getMinutes()+""+d.getSeconds();
			// ""는 숫자 연산 안되게 하려고
			IMP.init('imp54498209'); // 가맹점 식별코드, 결제 api 사용을 위한 코드 입력 
			IMP.request_pay({
				merchant_uid : "거래 일"+date,
				name : "결제 테스트",	// 결제 이름
				amount : userFee	// 결제 금액
				
			},function(rsp){
				if(rsp.success){ // 결제 성공 시
					alert('결제 성공!');
					// rsp.apply_num : 카드 승인 번호
					location.href = "/";
				}else{
					alert('결제 실패..');
				}
			});
		});
	});

	var count = 0;
	function oper(obj) {
		var selMember = $("[name=selMember]");
		var num = Number(selMember.val());
		if (obj == '+') {
			if (num >= 4) {
				alert("인원 선택은 최대 4명까지 가능합니다.");
				return;
			} else {
				count++;
			}
			selMember.val(String(count));
			var appendHTML = "<tr><td></td><td></td></tr>";
			$(".seatTbl2>tbody").append(appendHTML);
		}
		if (obj == '-') {
			var currentTrLen = $(".seatTbl2 tr")
					.not(".seatTbl2 tr:first-child").length;
			if (num <= 0) {
				return;
			} else {
				count--;
			}
			selMember.val(String(count));
			arr[currentTrLen - 1] = ""; // currenTrLen은 1~4까지 배열은 arr[0] ~ arr[3]까지
			var delRow = $(".seatTbl2 tr").last().children().eq(0).text();
			var delNum = $(".seatTbl2 tr").last().children().eq(1).text();

			$(".seatTbl1 tr").each(function(index, item) {
				var ths = $(item).children("th");
				var tds = $(item).children("td");
				if (ths.eq(0).text() == delRow) { // 일치하는 Row 찾으면 true
					for (var i = 0; i < tds.length; i++) {
						if (tds.eq(i).text() == delNum) { // 일치하는 Num 찾으면 true
							tds.eq(i).removeAttr("style");
							tds.eq(i).removeClass();
						}
					}
				}
			});
			$(".seatTbl2 tr").last().remove();
		}
	}
	function func1() {
		var length = $(".checkedSeat").length;
		var currentTr = $(".seatTbl2 tr").not(".seatTbl2 tr:first-child").length;
		console.log("인원 선택:" + currentTr);
		console.log("checkedSeat 클래스:" + length);
		console.log(seat);
	}
</script>
<style>
	.seatContainer {
		margin: 0 auto;
		padding: 0;
	}
	
	.seatTbl2 {
		text-align: center;
		border: 2px solid green;
		border-collapse: separate;
		border-spacing: 3px;
	}
	
	.seatTbl1 {
		border: 2px solid green;
		border-collapse: separate;
		border-spacing: 3px;
	}
	
	.seatTbl1 td, .seatTbl2 td {
		width: 50px;
		height: 50px;
		border: 1px solid limegreen;
		text-align: center;
		color: green;
		background-color: white;
		font-weight: bold;
	}
	
	.seatTbl1 th {
		width: 50px;
		height: 50px;
		background-color: limegreen;
		border: 1px solid green;
		text-align: center;
		color: white;
		font-weight: bold;
	}
	
	.seatTbl2 th{
		width: 111px;
		height: 50px;
		background-color: limegreen;
		border: 1px solid green;
		text-align: center;
		color: white;
		font-weight: bold;
	}
	
	.seatTbl1 td:hover {
		border: 1px solid red;
		color: red;
		cursor: pointer;
	}
	
	.seatContainer>div {
		margin: 0 auto;
		padding: 20px;
		height: 400px;
		border: 2px solid white;
		float: left;
	}
	
	.seatContainer>div:not(.seatContainer>div:first-child){
		border-left: none;
	}
	
	[name=selMember] {
		width: 31px;
		height: 31px;
		text-align: center;
	}
	
	[name=r-control], [name=l-control] {
		width: 31px;
		height: 31px;
		text-align: center;
	}
	.seatContainer>div:first-child{
		border-top-left-radius: 10px;
		border-bottom-left-radius: 10px; 
	}
	.seatContainer>div:last-child{
		width: 200px;
		border-top-right-radius: 10px;
		border-bottom-right-radius: 10px;
		text-align: center;
	}

	#msg{
		display: none;
	}
	.confirmSeat{
		margin: 0 auto;
		padding: 0;
		width: 100%;
		height: 100%;
        list-style-type: none;
        text-align: center;
	}
	
	.confirmSeat>li:nth-child(odd){
		margin: 5% 0; 
		padding: 5px;
		height: 30%;
		border: 1px solid white;
		text-align: left;
	}
	
	.confirmSeat>li:nth-child(even){
		width: 100px;
		height: 15%;
		display: inline-block;
	}
	.confirmSeat>li:nth-child(3),
	.confirmSeat>li:nth-child(4){
		display: none;
	}
	
	.confirmSeat input{
		width: 100%;
		height: 100%;
	}
	
	#result{
		color: lime;
	}
</style>
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp"%>
	<div class="container">
		<h2>좌석/인원 선택 페이지</h2>
		<br>
<!-- 	<p>영화번호 :<%=r.getMovieNo()%></p>
		<p>지점번호 :<%=r.getBranchNo()%></p>
		<p>상영관번호 :<%=r.getTheaterNo()%></p>
		<p>상영관이름 :<%=r.getTheaterName()%></p>
		<p>선택날짜 :<%=r.getSelectDate()%></p>
		<p>선택시간 :<%=r.getSelectTime()%></p> -->
 
		상영관 : <input type="text" name="thrNum" value="<%=r.getTheaterName()%>" readonly>
		관람인원선택 : <input type="button" name="l-control" value="-" onclick="oper('-');">
		<input type="text" name="selMember" value="0" readonly>
		<input type="button" name="r-control" value="+" onclick="oper('+');">
		<input type="button" name="btn" value="인원/선택된 좌석/배열 값 확인" onclick="func1();"><br><br>
		<p>좌석 선택: 클릭 / 더블 클릭 : 좌석 선택 해제</p>
		<div class="seatContainer">
			<div>
				<table class="seatTbl1">
					<tbody>
						<tr>
							<th>A</th>
							<td>1</td>
							<td>2</td>
							<td>3</td>
							<td>4</td>
							<td>5</td>
						</tr>
						<tr>
							<th>B</th>
							<td>1</td>
							<td>2</td>
							<td>3</td>
							<td>4</td>
							<td>5</td>
						</tr>
						<tr>
							<th>C</th>
							<td>1</td>
							<td>2</td>
							<td>3</td>
							<td>4</td>
							<td>5</td>
						</tr>
						<tr>
							<th>D</th>
							<td>1</td>
							<td>2</td>
							<td>3</td>
							<td>4</td>
							<td>5</td>
						</tr>
						<tr>
							<th>E</th>
							<td>1</td>
							<td>2</td>
							<td>3</td>
							<td>4</td>
							<td>5</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div>
				<table class="seatTbl2">
					<tbody>
						<tr>
							<th colspan="2">선택한 좌석</th>
						</tr>
					</tbody>
				</table>
			</div>
			<div>
				<ul class="confirmSeat">
					<li><span id="msg"></span></li>
					<li><input type="button" name="confirmSeat" value="좌석 확정"></li>
					<li><p id="result"></p></li>
					<li><input type="button" name="payment" value="결제하기"></li>
				</ul>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>