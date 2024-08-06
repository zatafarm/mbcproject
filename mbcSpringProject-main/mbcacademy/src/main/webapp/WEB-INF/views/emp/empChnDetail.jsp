<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<%@ page session="true"%>

<!DOCTYPE html>
<html lang="en">
<head>
<jsp:include page='/WEB-INF/views/include/head.jsp' />
<title>Employee information change request detail</title>
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
									<h2>정보 변경 요청 상세</h2>
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
											<input type="hidden" id="chno" name="chno"
												value="${chninfo.chno}">
										</div>
									</div>
									<div class="full price_table padding_infor_info">
										<div class="row">
											<div class="col-lg-12">
												<div class="table-responsive-sm">
													<table class="table table-striped projects">
														<tr>
															<th>신청자</th>
															<td>${chninfo.reqnm}</td>
															<th>소속</th>
															<td>${chninfo.reqdeptnm}</td>
														</tr>
													</table>
												</div>
											</div>
										</div>
									</div>
									<div class="full graph_head">
										<div class="heading1 margin_0">
											<h5>대상자 정보</h5>
										</div>
									</div>
									<div class="full price_table padding_infor_info">
										<div class="row">
											<div class="col-lg-12">
												<div class="table-responsive-sm">
													<table class="table table-striped projects">
														<tr>
															<th>사번 (이름)</th>
															<td>${chninfo.whochn}&nbsp;(${chninfo.whochnnm})</td>
															<th>변경 요청</th>
															<td><c:if test="${chninfo.typchn == 0 }">정보 변경</c:if>
																<c:if test="${chninfo.typchn == 1 }">퇴사</c:if></td>
														</tr>
														<c:if test="${chninfo.typchn == 0 }">
															<tr>
																<th>부서변경</th>
																<td>
																<c:if test="${chninfo.chndept ne null}">
																	${chninfo.predeptnm} → ${chninfo.chndeptnm}
																</c:if>
																<c:if test="${chninfo.chndept eq null}">-</c:if>
																</td>
																<th>직책변경</th>
																<td><c:choose>
																<c:when test="${chninfo.chnpstn == 2}">
																	팀장 → 팀원
																	<span style="font-size: x-small;">*관리권한 변경 필요</span>
																</c:when>
																<c:when test="${chninfo.chnpstn == 1}">
																	팀원 → 팀장
																	<span style="font-size: x-small;">*관리권한 변경 필요</span>
																</c:when>
																<c:otherwise>&nbsp;&nbsp;-</c:otherwise>
																</c:choose>
																</td>
															</tr>
														</c:if>
													</table>
												</div>
											</div>
										</div>
									</div>
									<div class="full graph_head">
										<div class="heading1 margin_0">
											<h5>요청 상태 정보</h5>
										</div>
									</div>
									<div class="full price_table padding_infor_info">
										<div class="row">
											<div class="col-lg-12">
												<div class="table-responsive-sm">
													<table class="table table-striped projects">
														<tr>
															<th>신청일</th>
															<td>${chninfo.reqdt}</td>
															<th>처리일</th>
															<td>${chninfo.resdt}</td>
														</tr>
														<tr>
															<th>처리상태</th>
															<td><c:if test="${chninfo.res == 0 }">미처리</c:if> <c:if
																	test="${chninfo.res == 1 }">처리완료</c:if></td>
															<td><c:if
																	test="${id eq 'admin' && chninfo.res == 0}">
																	<form action="/confirmChn" method="post">
																		<input type="hidden" name="chno"
																			value="${chninfo.chno}" />
																		<button type="submit" class="btn btn-success">처리
																			완료</button>
																	</form>
																</c:if></td>
														</tr>
													</table>
												</div>
											</div>
										</div>
									</div>
									<!-- 요청 상태 정보 end -->
									<div class="full price_table padding_infor_info">
										<div class="row">
											<div class="col-lg-12">
												<div class="table-responsive-sm">
													<table class="table projects">
														<tr>
															<td colspan="4" align="center"><c:if
																	test="${id eq chninfo.apl && chninfo.res == 0}">
																	<button type="button" class="btn btn-success"
																		onclick="location.href='empChnModify?chno=${chninfo.chno}'">수정</button>
																	<button type="button" class="btn btn-danger" onclick="confirmDeletion('empChnDel?chno=${chninfo.chno}')">삭제</button>
																</c:if>
																<button type="button" class="btn btn-info"
																	onclick="location.href='empChnList'">목록</button></td>
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
		function confirmDeletion(url) {
	        if (confirm('정말 삭제하시겠습니까?')) {
	            window.location.href = url;
	        }
	    }
	</script>
</body>
</html>