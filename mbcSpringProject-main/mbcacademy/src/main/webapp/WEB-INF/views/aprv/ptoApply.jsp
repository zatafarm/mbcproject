<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<%@ page session="true" %>
<!DOCTYPE html>
<!--  -->
<html lang="en">
<head>
	<jsp:include page='/WEB-INF/views/include/head.jsp'/>
	<title>Request for vacation</title>
	<style type="text/css">
		.etcrea {
		text-align: left;
		font-size: small;
		color: red;
		}
	</style>
	
</head>
<body class="dashboard dashboard_1">
<jsp:include page='/WEB-INF/views/include/body.jsp' />
	<div class="full_container">
	<div class="inner_container">
	<!-- Sidebar  -->
	<jsp:include page='/WEB-INF/views/include/sidebar.jsp'/>
	<!-- right content -->
	<div id="content">
	<!-- topbar -->
	<jsp:include page='/WEB-INF/views/include/topbar.jsp'/>
	<!-- Main -->
	<form role="form" onsubmit="return validate();" method="post" action="/ptoApply">
		<div class="midde_cont">
			<div class="container-fluid">
				<div class="row column_title">
					<div class="col-md-12">
						<div class="page_title">
							<h2>휴가 신청</h2>
						</div>
					</div>
				</div>
				<!-- row -->
				<div class="row column1">
					<div class="col-md-12">
						<div class="white_shd full margin_bottom_30">
							<div class="full graph_head">
								<div class="heading1 margin_0">
									<h5>신청자 정보</h5>
								</div>
							</div>
							<div class="full price_table padding_infor_info">
								<div class="row">
									<div class="col-lg-12">
										<div class="table-responsive-sm">
											<table class="table table-striped projects">
												<tr>
													<th>신청자</th>
													<td><input type="hidden" name="empno" value="${id}" readonly="readonly">${user}</td>
													<th>소속</th>
													<td>${codenm}</td>
												</tr>
												<tr>
													<th>총 지급 연차</th>
													<td id="totalpto">${totalpto}</td>
													<th>잔여 연차</th>
													<td id="rstpto">${rstpto}</td>
												</tr>
											</table>
										</div>
									</div>
								</div>
							</div>
							<div class="full graph_head">
								<div class="heading1 margin_0">
									<h5>신청 휴가 정보</h5>
								</div>
							</div>
							<div class="full price_table padding_infor_info">
								<div class="row">
									<div class="col-lg-12">
										<div class="table-responsive-sm">
											<table class="table table-striped projects">
												<tr>
													<td colspan="4"><p class="etcrea">※ 기타 : 병결, 공가(예비군), 경조 휴가, 출산 휴가 등 기타 휴가의 경우 체크</p>
														<p class="etcrea">※ 기타 휴가의 경우 사용 개수란에 0을 입력하시고 신청 사유에 사용 일을 적어주세요.</p>
														<p class="etcrea">※ 예시) 사용 사유 : 병가로 인한 휴가 신청(1일) / 신혼 여행으로 인한 경조 휴가 신청(3일)</p>
														<p class="etcrea">※ 기타 휴가 신청 시 증명서류는 각 팀장에게 직접 제출하세요.</p>
													</td>
												</tr>
												<tr>
													<th>휴가 종류</th>
													<td><select id="ptotp" name="ptotp">
														<option selected>--선택--</option>
														<option value="T0">연차</option>
														<option value="T1">반차</option>
														<option value="T2">기타</option>
														</select>
													</td>					
													<th>사용 개수</th>
													<td><input type="number" id="usp" name="usp" max="${rstpto}" required="required">개</td>
												</tr>
												<tr>
													<th>휴가 시작일</th>
													<td><input type="text" class="date" id="strdt" name="strdt" placeholder="yyyy-mm-dd" required="required"></td>
													<th>휴가 종료일</th>
													<td><input type="text" class="date" id="endt" name="endt" placeholder="yyyy-mm-dd" required="required"></td>
												</tr>
												<tr>
													<th>신청 사유</th>
													<td colspan="3"><textarea name="ptorea" rows="5" cols="100" placeholder="휴가 신청 사유" required="required"></textarea></td>
												</tr>
												<tr>
													<td colspan="4" align="center">
														<button type="submit" class="btn btn-success">제출</button>
														<button type="reset" class="btn btn-secondary">초기화</button>
														<button type="button" class="btn btn-info" onclick="location.href='ptoList'">목록</button>
													</td>
												</tr>
											</table>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- end row -->
			</div>
		</div>
	</form>
	<!-- end dashboard inner -->
	<!-- footer -->
	<jsp:include page='/WEB-INF/views/include/footer.jsp'/>
	</div>
	</div>
	</div>
	<script>
	<!-- 데이트피커 -->
	  $(function(){
	$(".date").datepicker({
		dateFormat: 'yy-mm-dd' //달력 날짜 형태
	    ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
	    ,showMonthAfterYear:true // 월- 년 순서가아닌 년도 - 월 순서
	    ,changeYear: true //option값 년 선택 가능
	    ,changeMonth: true //option값  월 선택 가능                
	    ,showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시  
	    ,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
	    ,buttonImageOnly: true //버튼 이미지만 깔끔하게 보이게함
	    ,buttonText: "선택" //버튼 호버 텍스트              
	    ,yearSuffix: "년" //달력의 년도 부분 뒤 텍스트
	    ,monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 텍스트
	    ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip
	    ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 텍스트
	    ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 Tooltip
	    ,minDate: "-1M" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
	    ,maxDate: "+1M" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)
	});
	 $('#strdt').datepicker("option", "onClose", function ( selectedDate ) {
	       $("#endt").datepicker( "option", "minDate", selectedDate );
	   });
	$('#endt').datepicker("option", "onClose", function ( selectedDate ) {
	       $("#strdt").datepicker( "option", "maxDate", selectedDate );
	   });
	  });
	  

		<!-- 연차계산 -->
		function cmbbInbl() {
			const appr = document.getElementById('appr');
			const rjctnrea = document.getElementById('rjctnrea');
			
			if(appr.checked) {
				rjctnrea.disabled = true;
			} else {
				rjctnrea.disabled = false;
			}
		}
		
		document.addEventListener('DOMContentLoaded', (event) => {

			cmbbInbl();
			
			const appr = document.getElementById('appr');
			const rjct = document.getElementById('rjct');
			
			appr.addEventListener('change', cmbbInbl);
			rjct.addEventListener('change', cmbbInbl);
		
		});	
	  
	<!-- 입력 체크 사항 -->
	function validate() {

		var ptotp = document.getElementById("ptotp").value;
		var usp = document.getElementById("usp").value;
		var rstpto = document.getElementById("rstpto").value;
		
		if(ptotp === "--선택--"){
			alert("휴가 종류를 선택하세요.");
			return false;
		}
		
		if(ptotp === "T2" && usp !== "0"){
			alert("기타 휴가의 경우 사용 개수를 0으로 입력 해주세요.");
			return false;
		}
		
		if((ptotp === "T0" || ptotp === "T1") && parseInt(usp) <= 0){
			alert("휴가 사용 개수는 최소 1개 입니다.");
			return false;
		}
		

		
		
	}	// validate() end
	</script>
</body>
</html>