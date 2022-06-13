<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.3.1.js"></script>
<style>
	li{
		list-style-type: none;
	}
	.rsv-wrap{
		margin:  25px;
		display: flex;
		justify-content: center;
		align-items: center;
	}
	#next-btn{
		width: 250px;
		height: 55px;
		color: #222;
		background-color: transparent;
		margin-top: 40px;
		margin-bottom: 60px;
		border: 3px solid rgb(167, 177, 189);
		font-size:20px;
	}
	#next-btn:hover{
		background-color: rgb(143, 169, 199);
		color: white;
		border : none;
	}
	.rsv-table{
		width:90%;
		height:80%;
		border: 1px solid white;
	}
	.rsv-table tr:first-child{
		text-align: center
	}
	.rsv-table th{
		color:#222;
		font-size:23px;
	}
	.rsv-table td:hover{
		background-color:rgba(71, 71, 71, 0.466);
	}
	.rsv-movie{
		width: 30%;
		border: 1px solid white;
	}
	.rsv-branch{
		width: 15%;
		border: 1px solid white;
	}
	.rsv-date{
		width: 25%;
		border: 1px solid white;
		text-align: center;
	}
	.rsv-time{
		width: 25%;
		border: 1px solid white;
	}
	.content{
		margin-top:100px;
	}
</style>
</head>
<body>
	<%@include file="/WEB-INF/views/common/header.jsp" %>
	<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/ui-darkness/jquery-ui.css">
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<div class="background-img">
		<div class="content">
			<div class="rsv-wrap">
				<table border="1" class="rsv-table">
					<tr>
						<th>영화</th>
						<th>극장</th>
						<th>날짜</th>
						<th>시간</th>
					</tr>
					<tr>
						<td class="rsv-movie">
							<ul></ul>
						</td>
						<td class="rsv-branch">
							<ul></ul>
						</td>
						<td class="rsv-date">
							<div>
								<span><img src='image/schedule.png' width='30px'></img></span>
								<input type="text" id="selDate" name="selDate" form="rsv-form" readonly>
							</div>
						</td>
						<td class="rsv-time">
							<ul></ul>
						</td>
					</tr>
				</table>
			</div>
			<div class="rsv-wrap">
				<form action="/reserve1Next" method="post" id="rsv-form">	<!-- 다음페이지(좌석선택)로 넘겨줄 데이터 -->
					<input type="hidden" id="movieNo" name="movieNo" >
					<input type="hidden" id="branchNo" name="branchNo" >
					<input type="hidden" id="theaterNo" name="theaterNo" >
					<input type="hidden" id="theaterName" name="theaterName" >
					<input type="hidden" id="selectTime" name="selectTime">
					<button type="button" id="next-btn">다음</button>
				</form>
			</div>
		</div>
	</div>
	<script>
		$(function(){	//onload. 예매 페이지 진입시 DB에서 영화목록 받아와서 출력
			$.ajax({
				url : "/ajaxMovieList",
				success : function(data){
					if(data.length != 0){
						for(var i=0;i<data.length;i++){
							var movieTitle = data[i].movieTitle;
							var movieGrade = data[i].movieGrade;
							var li = $("<li value='"+data[i].movieNo+"'></li>");
							if(movieGrade == "12세이상관람가"){
								li.append("<img src='image/12.png' width='20px'>");
							}else if(movieGrade == "15세이상관람가"){
								li.append("<img src='image/15.png' width='20px'>");
							}else if(movieGrade == "청소년관람불가"){
								li.append("<img src='image/18.png' width='20px'>");
							}else if(movieGrade == "전체이용가"){
								li.append("<img src='image/ALL.png' width='20px'>");
							}
							li.append("<span>"+movieTitle+"</span>");
							$(".rsv-movie>ul").append(li);
						}
					}
				}
			});
		});
		
		//영화 선택시 글자 색상, 굵기 변경
		$(document).on("click",".rsv-movie>ul>li",function(){
			$(".rsv-movie>ul>li").css("color","white").css("font-weight","normal").css("font-size","16px");
			$(this).css("color","cornflowerblue").css("font-weight","bold").css("font-size","17px");
		});
		//지점 선택시 글자 색상, 굵기 변경
		$(document).on("click",".rsv-branch>ul>li",function(){
			$(".rsv-branch>ul>li").css("color","white").css("font-weight","normal").css("font-size","16px");
			$(this).css("color","cornflowerblue").css("font-weight","bold").css("font-size","17px");
		});
		//상영관 및 시간 선택시 글자 색상, 굵기 변경
		$(document).on("click",".rsv-time>ul>li",function(){
			$(".rsv-time>ul>li").css("color","white").css("font-weight","normal").css("font-size","16px");
			$(this).css("color","cornflowerblue").css("font-weight","bold").css("font-size","17px");
		});
		
		// 전역변수
		var mvNo = null;	//영화번호
		var brNo = null;	//지점번호
		var thNo = null;	//상영관번호
		var thName = null;	//상영관이름
		var selectDate = null; //날짜(문자열)
		var selectTime = null; //상영시간(문자열) ex-16:00~18:00
		
		//영화 선택시 마지막으로 클릭한 "영화번호"를 보내주고 해당하는 지점 목록 받아와서 출력
		$(document).on("click",".rsv-movie>ul>li",function(){//동적 처리모델에 이벤트를 걸때는 항상 주의! 동적 함수가 작동하기전에 나머지 이벤트가 먼저 생성되므로 해당 이벤트들이 동작을 안함
			$("#selDate").val("");		//날짜선택 초기화
			$(".rsv-time>ul>li").html("");		//시간선택 초기화
			mvNo = $(this).val();
			$.ajax({
				url : "/ajaxBranchList",
				data : {mvNo:mvNo},
				type : "get",
				success : function(data){
					if(data.length !=0 ){
						$(".rsv-branch>ul").empty();
						var arr = new Array();
						for(var i=0;i<data.length;i++){
							arr[i] = data[i].branchNo;
							var li = $("<li value='"+data[i].branchNo+"'></li>");
							li.append("<span>"+data[i].branchName+"</span>");						
							$(".rsv-branch>ul").append(li);
						}
					}
				}
			});	
		});
		
		//지점 선택시 마지막으로 클릭한 "영화번호","지점번호"를 보내주고 해당하는 날짜 목록 받아와서 출력
		$(document).on("click",".rsv-branch>ul>li",function(){
			$("#selDate").val("");		//날짜선택 초기화
			$(".rsv-time>ul>li").html("");		//시간선택 초기화
			brNo = $(this).val();
			$.ajax({
				url : "/ajaxDayList",
				data : {mvNo:mvNo,brNo:brNo},
				type : "get",
				success : function(data){
					if(data.length !=0 ){
						//상영시작일
						var startDate = String(data.startDate);
						var sMonth = startDate.substring(0,startDate.indexOf("월"));
						if(sMonth.length == 1){
							sMonth = "0"+sMonth;
						}
						var sDate = startDate.substring(startDate.indexOf("월")+2,startDate.indexOf(","));
						if(sDate.length == 1){
							sDate = "0"+sDate;
						}
						var sYear = startDate.substring(startDate.indexOf(",")+1);
						var minDate = sYear+"/"+sMonth+"/"+sDate;
						
						//날짜 비교
						var today = new Date();
						var startDay = new Date(minDate);
						
						if(today>=startDay){
		        	   		minDate = today.getFullYear()+"-"+(today.getMonth()+1)+"-"+today.getDate();
			           	}
						
						//상영종료일
						var endDate = String(data.endDate);
						var eMonth = endDate.substring(0,endDate.indexOf("월"));
						if(eMonth.length == 1){
							eMonth = "0"+eMonth;
						}
						var eDate = endDate.substring(endDate.indexOf("월")+2,endDate.indexOf(","));
						if(eDate.length == 1){
							eDate = "0"+eDate;
						}
						var eYear = endDate.substring(endDate.indexOf(",")+1);
						var maxDate = eYear+"-"+eMonth+"/"+eDate;
						console.log("상영시작일~상영종료일(문자열) : "+sYear+"/"+sMonth+"/"+sDate+" ~ "+eYear+"/"+eMonth+"/"+eDate);
						
						$('#selDate').datepicker("destroy");	//기존의 datepicker객체 삭제
						
						$('#selDate').datepicker({
							dateFormat: 'yy/mm/dd' //달력 날짜 형태
				           ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
				           ,showMonthAfterYear:true // 월- 년 순서가아닌 년도 - 월 순서
				           ,changeYear: true //option값 년 선택 가능
				           ,changeMonth: true //option값  월 선택 가능
				           ,yearSuffix: "년" //달력의 년도 부분 뒤 텍스트
				           ,onSelect : function(dateText,inst){
				        //날짜 선택시 마지막으로 클릭한 "영화번호","지점번호"를 보내주고 해당하는 상영스케쥴 목록 받아와서 출력. 예시:[상영관이름] 14:00~16:20 (잔여석)
				        	selectDate = dateText;
				        	$.ajax({
				   				url : "/ajaxScheduleList",
				   				data : {mvNo:mvNo,brNo:brNo},
				   				type : "get",
				   				success : function(data){
				   					if(data.length != 0){
				   						$(".rsv-time>ul").empty();
				   						for(var i=0;i<data.length;i++){
				   							var theaterNo = data[i].theaterNo;
				   							var theaterName = data[i].theaterName;
				   							var startTime = data[i].startTime;
				   							var endTime = data[i].endTime;
				   							var seatExist = data[i].seatExist;
				   							var li = $("<li value1='"+theaterNo+"' value2='"+theaterName+"' value3='"+startTime+' ~ '+endTime+"'></li>");
				   							li.append("<span>["+theaterName+"] </span>");
				   							li.append("<span>"+startTime+"~"+endTime+"</span>");
				   							li.append("<span> (여석 : "+seatExist+")</span>");
				   							$(".rsv-time>ul").append(li);
				   						}
				   					}
				   				}
				   			});
				           }
				           ,monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 텍스트
				           ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip
				           ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 텍스트
				           ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 Tooltip
				           ,minDate: new Date(minDate)
				           ,maxDate: new Date(maxDate) //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)
						}).datepicker("show");
						$('#selDate').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)
					}
				}
			});
		});
		$(document).on("click",".rsv-time>ul>li",function(){
			thNo = $(this).attr("value1");	
			thName = $(this).attr("value2");
			selectTime = $(this).attr("value3");
			$("#movieNo").val(mvNo);
			$("#branchNo").val(brNo);
			$("#theaterNo").val(thNo);
			$("#theaterName").val(thName);
			$("#selectTime").val(selectTime);

			console.log("영화번호 : "+mvNo+" / 지점번호 : "+brNo+"상영관번호 : "+thNo+" / 상영관이름 : "+thName+" / 날짜 : "+selectDate+" / 상영시간 : "+selectTime);
		});
		$("#next-btn").click(function(){
			if($("#movieNo").val()==''){
				alert("선택이 완료되지 않았습니다.");
			}else if($("#branchNo").val()==''){
				alert("선택이 완료되지 않았습니다.");
			}else if($("#theaterNo").val()==''){
				alert("선택이 완료되지 않았습니다.");
			}else if($("#selectTime").val()==''){
				alert("선택이 완료되지 않았습니다.");
			}else if($("#selDate").val()==''){
				alert("선택이 완료되지 않았습니다.");
			}else{
				$("#rsv-form").submit();
			}
		});
	</script>
	<%@include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>