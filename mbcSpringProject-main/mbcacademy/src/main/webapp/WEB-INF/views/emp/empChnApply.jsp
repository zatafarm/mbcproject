<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<%@ page session="true"%>
<!DOCTYPE html>
<!--  -->
<html lang="en">
<head>
<jsp:include page='/WEB-INF/views/include/head.jsp' />
<title>Change Employ Information</title>
<style type="text/css">
.etcrea {
	text-align: left;
	font-size: small;
	color: red;
}

.output {
	background-color: transparent; /* 배경색 제거 */
	border: none; /* 테두리 제거 */
	margin: 0; /* 여백 제거 */
	padding: 0; /* 내부 여백 제거 */
}
</style>

</head>
<body class="dashboard dashboard_1">
	<jsp:include page='/WEB-INF/views/include/body.jsp' />
	<div class="full_container">
		<div class="inner_container">
			<!-- Sidebar  -->
			<jsp:include page='/WEB-INF/views/include/sidebar.jsp' />
			<!-- right content -->
			<div id="content">
				<!-- topbar -->
				<jsp:include page='/WEB-INF/views/include/topbar.jsp' />
				<!-- Main -->
				<form role="form" onsubmit="return validate();" method="post"
					action="/empChnApply">
					<div class="midde_cont">
						<div class="container-fluid">
							<div class="row column_title">
								<div class="col-md-12">
									<div class="page_title">
										<h2>사원정보 변경 신청</h2>
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
																<td><input type="hidden" name="apl" id="apl" value="${id}"
																	readonly="readonly">${user}</td>
																<th>소속</th>
																<td><c:if test="${dept == 'E0'}">
																		경영지원팀
																	</c:if> <c:if test="${dept == 'E1'}">
																		인사팀
																	</c:if> <c:if test="${dept == 'E2'}">
																		재무팀
																	</c:if> <c:if test="${dept == 'E3'}">
																		영업팀
																	</c:if> <c:if test="${dept == 'E4'}">
																		마케팅팀
																	</c:if></td>
															</tr>
														</table>
														<input type="hidden" id="aplDept" value="${dept}">
													</div>
												</div>
											</div>
										</div>
										<div class="full graph_head">
											<div class="heading1 margin_0"
												style="display: flex; align-items: center;">
												<h5 style="margin-right: 10px;">대상자 정보</h5>
												&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
												<button type="button" class="btn btn-info btnempoly"
													id="empSearch" data-url="/emplistmodal">사원검색</button>
											</div>
										</div>
										<div class="full price_table padding_infor_info">
											<div class="row">
												<div class="col-lg-12">
													<div class="table-responsive-sm">
														<table class="table table-striped projects">
															<tr>
																<th>사번</th>
																<td><input type="text" name="whochn" id="whochn"
																	readonly="readonly" class="output"></td>
																<th>이름</th>
																<td><input type="text" id="ename"
																	readonly="readonly" class="output"></td>
															</tr>
															<tr>
																<th>부서</th>
																<td>
																	<input type="text" id="dept" readonly="readonly" class="output">
																	<input type="hidden" id="predept" name="predept">
																</td>
																<th>직책</th>
																<td>
																	<input type="text" id="pstn" readonly="readonly" class="output">
																	<input type="hidden" id="prepstn" name="prepstn">
																</td>
															</tr>
															<tr>
																<th>변경 요청</th>
																<td><select id="typchn" name="typchn" id="typchn">
																		<option selected>--선택--</option>
																		<option value="0">정보 변경</option>
																		<option value="1">퇴사</option>
																</select></td>
																<th>상세 정보</th>
																<td><select id="detail" name="detail"
																	disabled="disabled">
																		<option selected>--선택--</option>
																		<option value="0">부서</option>
																		<option value="1">직책</option>
																		<option value="2">부서 + 직책</option>
																</select></td>
															</tr>
															<tr>
																<th>부서변경</th>
																<td><select id="chndept" name="chndept"
																	disabled="disabled">
																		<option selected>--선택--</option>
																		<option value="E0">경영지원팀</option>
																		<option value="E1">인사팀</option>
																		<option value="E2">재무팀</option>
																		<option value="E3">영업팀</option>
																		<option value="E4">마케팅팀</option>
																</select></td>
																<th>직책변경</th>
																<td><select id="chnpstn" name="chnpstn"
																	disabled="disabled">
																		<option selected>--선택--</option>
																		<option value="1">팀장</option>
																		<option value="2">팀원</option>
																</select></td>
															</tr>
															<tr>
																<td colspan="4" align="center">
																	<button type="submit" class="btn btn-success">제출</button>
																	<button type="button" class="btn btn-info"
																		onclick="location.href='empChnList'">목록</button>
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
				<jsp:include page='/WEB-INF/views/include/footer.jsp' />
			</div>
		</div>
	</div>
	<script>
	<!-- 입력 체크 사항 -->
		function validate() {
			const alerts = [ "대상자 정보를 입력해주세요", "요청 정보를 입력해주세요",
					"요청 상세정보를 입력해주세요", "대상자에 대한 변경 권한이 없습니다." ];
			let whochn = document.getElementById("whochn").value;
			let typchn = document.getElementById("typchn").value;
			let detail = document.getElementById("detail").value;
			let chndept = document.getElementById("chndept").value;
			let chnpstn = document.getElementById("chnpstn").value;
			const aplDept = document.getElementById("aplDept").value;
			const jobTitleMap = {
	                "총책임자": 0,
	                "팀장": 1,
	                "팀원": 2
	        };
			
			const deptMap = {
					"경영지원팀": "E0",
					"인사팀": "E1",
					"재무팀": "E2",
					"영업팀": "E3",
					"마케팅팀": "E4"
	        };
			
			let prepstn = jobTitleMap[document.getElementById("pstn").value] || "";
			
			let predept = deptMap[document.getElementById("dept").value] || "";
			
			document.getElementById("prepstn").value = prepstn;
			
			document.getElementById("predept").value = predept;
			

			if (!whochn) {
				alert(alerts[0]);
				return false;
			}
			if (typchn === "--선택--") {
				alert(alerts[1]);
				return false;
			}
			if ((typchn === "0" && detail === "--선택--")
					|| (detail === "0" && chndept === "--선택--")
					|| (detail === "1" && chnpstn === "--선택--")
					|| (detail === "2" && (chndept === "--선택--" || chnpstn === "--선택--"))) {
				alert(alerts[2]);
				return false;
			}
			
			if (aplDept !== predept){
				alert(alerts[3]);
				return false;
			}
			
		}

		// typchn의 값이 변경될 때 실행
		document.getElementById('typchn').addEventListener('change',
				function() {
					const typchn = document.getElementById('typchn').value;
					const detail = document.getElementById('detail');
					const chndept = document.getElementById('chndept');
					const chnpstn = document.getElementById('chnpstn');

					if (typchn === '0') {
						detail.disabled = false;
					} else {
						detail.disabled = true;
						detail.value = '--선택--';
						chndept.disabled = true;
						chndept.value = '--선택--';
						chnpstn.disabled = true;
						chnpstn.value = '--선택--';
					}
				});

		// detail의 값이 변경될 때 실행
		document.getElementById('detail').addEventListener('change',
				function() {
					const detail = document.getElementById('detail').value;
					const chndept = document.getElementById('chndept');
					const chnpstn = document.getElementById('chnpstn');

					if (detail === '0') {
						chndept.disabled = false;
						chnpstn.disabled = true;
						chnpstn.value = '--선택--';
					} else if (detail === '1') {
						chndept.disabled = true;
						chndept.value = '--선택--';
						chnpstn.disabled = false;
					} else if (detail === '2') {
						chndept.disabled = false;
						chnpstn.disabled = false;
					} else {
						chndept.disabled = true;
						chndept.value = '--선택--';
						chnpstn.disabled = true;
						chnpstn.value = '--선택--';
					}
				});

		function updateDisplay() {
			document.getElementById('whochn_display').textContent = document
					.getElementById('whochn').value;
			document.getElementById('ename_display').textContent = document
					.getElementById('ename').value;
			document.getElementById('dept_display').textContent = document
					.getElementById('dept').value;
			document.getElementById('pstn_display').textContent = document
					.getElementById('pstn').value;
		}
	</script>
	<!-- 사원검색 모달창 -->

	<div class="modal fade" id="empolyModalss" tabindex="-1"
		aria-labelledby="empolyModalLabel" aria-hidden="true">
		<div class="modal-dialog  modal-dialog-centered custom-modal-size">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="empolyModalLabel">사원 검색</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body" id="modalContentss"></div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
	<script>
		$(document).ready(function() {
			$('.btnempoly').on('click', function(event) {
				event.preventDefault();
				let url = $(this).data('url');
				let empno = $('#whochn').val(); // 선택된 사원의 사번
				// URL에 empno를 포함하여 전달
				url += "?empno=" + empno;
				$.ajax({
					url : url,
					method : 'GET',
					success : function(data) {
						$('#modalContent').html(data);
						$('#empolyModal').modal({
							keyboard : false
						// Esc 키로 닫힘 방지
						});
					},
					error : function(jqXHR, textStatus, errorThrown) {
						console.error("AJAX 요청 실패: ", textStatus, errorThrown);
					}
				});
			});
		});
	</script>
</body>
</html>