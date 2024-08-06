<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<%@ page session="true"%>

<% String source = request.getParameter("source"); %>

<!DOCTYPE html>
<html lang="en">
<head>
<jsp:include page='/WEB-INF/views/include/head.jsp' />
<title>vacation Detail</title>
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
				<div class="midde_cont">
					<div class="container-fluid">
						<div class="row column_title">
							<div class="col-md-12">
								<div class="page_title">
									<h2>휴가 내역 상세</h2>
									<div>${msg}</div>
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
															<td>${aprv.reqnm }</td>
															<th>소속</th>
															<td>${aprv.deptnm}</td>
														</tr>
														<tr>
															<th>총 지급 연차</th>
															<td id="totalPTO">${aprv.totalpto}</td>
															<th>잔여 연차</th>
															<td id="rstPTO">${aprv.rstpto}</td>
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
															<th>휴가 종류</th>
															<td>${aprv.ptotpnm}</td>
															<th>상태</th>
															<td>${aprv.sttsnm}</td>
														</tr>
														<tr>
															<th>사용 개수</th>
															<td id="usp">${aprv.usp}개</td>
															<th>신청일</th>
															<td>${aprv.reqdt}</td>
														</tr>
														<tr>
															<th>휴가 시작일</th>
															<td>${aprv.strdt}</td>
															<th>휴가 종료일</th>
															<td>${aprv.endt}</td>
														</tr>
														<tr>
															<th>신청 사유</th>
															<td colspan="3">${aprv.ptorea}</td>
														</tr>
													</table>
												</div>
											</div>
										</div>
									</div>
									<!-- 대기 상태 아닐 때 -->
									<c:if test="${aprv.stts != 'P0'}">
										<div class="full graph_head">
											<div class="heading1 margin_0">
												<h5>결재 상태 정보</h5>
											</div>
										</div>
										<div class="full price_table padding_infor_info">
											<div class="row">
												<div class="col-lg-12">
													<div class="table-responsive-sm">
														<table class="table table-striped projects">
															<tr>
																<th>결재자</th>
																<td>${aprv.aprvnm}</td>
																<th>결재일</th>
																<td>${aprv.apprvldt}</td>
															</tr>
															<c:if test="${aprv.stts == 'P3'}">
																<tr>
																	<th>반려 사유</th>
																	<td colspan="3">${aprv.rjctnrea}</td>
																</tr>
															</c:if>
														</table>
													</div>
												</div>
											</div>
										</div>
									</c:if>
									<!-- 결재 상태 정보 end -->
									<!-- 대기 상태 && 관리자권한 있을 때 -->
									<c:if test="${aprv.stts == 'P0' && admns != '0'}">
										<form action="/aprv" method="post">
											<input type="hidden" name="pno" value="${aprv.pno}" />
											<input type="hidden" name="ptotp" value="${aprv.ptotp}" />
											<input type="hidden" name="empno" value="${aprv.empno}" />
											<div class="full graph_head">
												<div class="heading1 margin_0">
													<h5>1차 결재</h5>
												</div>
											</div>
											<div class="full price_table padding_infor_info">
												<div class="row">
													<div class="col-lg-12">
														<div class="table-responsive-sm">
															<table class="table table-striped projects">
																<tr>
																	<th>결재</th>
																	<td>승인 <c:choose>
																			<c:when test="${admns != '2'}">
																				<input type="radio" name="stts" id="acpt" value="P1" />
																			</c:when>
																			<c:otherwise>
																				<input type="radio" name="stts" id="acpt" value="P2" />
																			</c:otherwise>
																		</c:choose>&nbsp;&nbsp;&nbsp;&nbsp;반려 <input type="radio"
																		name="stts" id="rjct" value="P3" checked="checked" />
																	</td>
																	<th>반려 사유</th>
																	<td><select name="rjctnrea" id="rjctnrea">
																			<option selected="selected">선택하세요</option>
																			<option value="주요업무">주요업무</option>
																			<option value="기타">기타</option>
																	</select></td>
																</tr>
																<tr>
																	<th>결재자</th>
																	<td><input type="hidden" name="apprver" value="${id}">${user}</td>
																	<td colspan="2" align="center">
																		<button type="submit" class="btn btn-success">결재</button>
																	</td>
																</tr>
															</table>
														</div>
													</div>
												</div>
											</div>
										</form>
									</c:if>
									<!-- 대기 상태 && 관리자권한 있을 때 결재 end-->
									<!-- 1차 승인 상태 && 관리자권한 있을 때 -->
									<c:if test="${aprv.stts == 'P1' && admns == '2'}">
										<form action="/aprv" method="post">
											<input type="hidden" name="pno" value="${aprv.pno}" /> <input
												type="hidden" name="ptotp" value="${aprv.ptotp}" /> <input
												type="hidden" name="empno" value="${aprv.empno}" />
											<div class="full graph_head">
												<div class="heading1 margin_0">
													<h5>최종 결재</h5>
												</div>
											</div>
											<div class="full price_table padding_infor_info">
												<div class="row">
													<div class="col-lg-12">
														<div class="table-responsive-sm">
															<table class="table table-striped projects">
																<tr>
																	<th>결재</th>
																	<td>승인<input type="radio" name="stts" id="acpt"
																		value="P2" /> &nbsp;&nbsp;&nbsp;&nbsp;반려 <input
																		type="radio" name="stts" id="rjct" value="P3"
																		checked="checked" /></td>
																	<th>반려 사유</th>
																	<td><select name="rjctnrea" id="rjctnrea">
																			<option selected="selected">선택하세요</option>
																			<option value="주요업무">주요업무</option>
																			<option value="기타">기타</option>
																	</select></td>
																</tr>
																<tr>
																	<th>결재자</th>
																	<td><input type="hidden" name="apprver" value="${id}">${user}</td>
																	<td colspan="2" align="center">
																		<button type="submit" class="btn btn-success">결재</button>
																	</td>
																</tr>
															</table>
														</div>
													</div>
												</div>
											</div>
										</form>
									</c:if>
									<!-- 1차 승인 상태 && 관리자권한 있을 때 결재 end -->
									<div class="full price_table padding_infor_info">
										<div class="row">
											<div class="col-lg-12">
												<div class="table-responsive-sm">
													<table class="table projects">
														<tr>
															<td colspan="4" align="center"><c:if
																	test="${id eq aprv.empno && aprv.stts == 'P0'}">
																	<button type="button" class="btn btn-success" onclick="location.href='ptoModify?pno=${aprv.pno}&source=ptoList'">수정</button>
																	<button type="button" class="btn btn-danger" onclick="confirmDeletion('<%= request.getContextPath() %>/ptoDel?pno=${aprv.pno}')">삭제</button>
																</c:if>
																<button type="button" class="btn btn-info" onclick="location.href='<%= source != null ? source : "dafaultPage" %>'">목록</button>
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
				<!-- end dashboard inner -->
				<!-- footer -->
				<jsp:include page='/WEB-INF/views/include/footer.jsp' />
			</div>
		</div>
	</div>
	<script type="text/javascript">
	 	
		document.addEventListener('DOMContentLoaded', (event) => {
			// 반려 사유 드롭다운 활성화/비활성화
			 function cmbbInbl() {
				 const ACPT = document.getElementById('acpt');
				 const RJCTNREA = document.getElementById('rjctnrea');
				 
				 if (ACPT.checked) {
					 RJCTNREA.disabled = true;
				 } else {
					 RJCTNREA.disabled = false;
				 }
			}
			
			// 초기 호출로 올바른 상태 설정
			cmbbInbl();
			
			// 라디오 버튼에 이벤트 리스너 추가
			const ACPT = document.getElementById('acpt');
			const RJCT = document.getElementById('rjct');
			
			ACPT.addEventListener('change', cmbbInbl);
			RJCT.addEventListener('change', cmbbInbl);
			
			// 페이지 로드 시 숫자 형식 지정
			function fmtNum(value) {
				if (value % 1 === 0) {
					return value.toFixed(0);
				} else {
					return value.toString();
				}
			}
			
			const totalPTO = parseFloat(document.getElementById('totalPTO').innerText);
			const rstPTO = parseFloat(document.getElementById('rstPTO').innerText);
			const usp = parseFloat(document.getElementById('usp').innerText);
			
			document.getElementById('totalPTO').innerText = fmtNum(totalPTO);
			document.getElementById('rstPTO').innerText = fmtNum(rstPTO);
	        document.getElementById('usp').innerText = fmtNum(usp);
	        
	     	// 제출 시 폼 검증
	     	document.querySelector('form').addEventListener('submit', function(event) {
	     		let isValid = true;
	     		let errMsg = "";
	     		
	     		if (document.getElementById('rjct').checked && document.getElementById('rjctnrea').value === "선택하세요") {
	     			errMsg += "반려사유를 선택하세요.\n";
	     			isValid = false;
	     		}
	     		
	     		if (!isValid) {
	     			alert(errMsg);
	     			event.preventDefault();
	     		}
	     	});

		 });
		
		 function confirmDeletion(url) {
	            if (confirm('정말 삭제하시겠습니까?')) {
	                window.location.href = url;
	            }
	        }
	</script>
</body>
</html>