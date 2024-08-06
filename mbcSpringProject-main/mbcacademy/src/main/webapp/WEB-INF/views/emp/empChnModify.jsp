<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%@ page session="true"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<jsp:include page='/WEB-INF/views/include/head.jsp' />
<title>사원 정보 변경</title>
<style type="text/css">
.etcrea {
	text-align: left;
	font-size: small;
	color: red;
}

.output {
	background-color: transparent;
	border: none;
	margin: 0;
	padding: 0;
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
					action="/empChnModify">
					<div class="midde_cont">
						<div class="container-fluid">
							<div class="row column_title">
								<div class="col-md-12">
									<div class="page_title">
										<h2>사원 정보 변경</h2>
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
																<td><input type="hidden" name="apl" value="${id}"
																	readonly="readonly">${user}</td>
																<th>소속</th>
																<td><c:choose>
																		<c:when test="${dept == 'E0'}">경영지원팀</c:when>
																		<c:when test="${dept == 'E1'}">인사팀</c:when>
																		<c:when test="${dept == 'E2'}">재무팀</c:when>
																		<c:when test="${dept == 'E3'}">영업팀</c:when>
																		<c:when test="${dept == 'E4'}">마케팅팀</c:when>
																	</c:choose></td>
															</tr>
														</table>
													</div>
												</div>
											</div>
										</div>
										<div class="full graph_head">
											<div class="heading1 margin_0"
												style="display: flex; align-items: center;">
												<h5 style="margin-right: 10px;">대상자 정보</h5>
											</div>
										</div>
										<div class="full price_table padding_infor_info">
											<div class="row">
												<div class="col-lg-12">
													<div class="table-responsive-sm">
														<table class="table table-striped projects">
															<tr>
																<th>사번</th>
																<td>${chninfo.whochn}</td>
																<th>이름</th>
																<td>${chninfo.whochnnm}</td>
															</tr>
															<tr>
																<th>부서</th>
																<td>${chninfo.predeptnm}</td>
																<th>직책</th>
																<td><c:choose>
																		<c:when test="${chninfo.prepstn eq '0'}">총책임자</c:when>
																		<c:when test="${chninfo.prepstn eq '1'}">팀장</c:when>
																		<c:when test="${chninfo.prepstn eq '2'}">팀원</c:when>
																	</c:choose></td>
															</tr>
															<tr>
																<th>변경 요청</th>
																<td><select id="typchn" name="typchn">
																		<option value="--선택--"
																			${chninfo.typchn == null ? 'selected' : ''}>--선택--</option>
																		<option value="0"
																			${chninfo.typchn == '0' ? 'selected' : ''}>정보
																			변경</option>
																		<option value="1"
																			${chninfo.typchn == '1' ? 'selected' : ''}>퇴사</option>
																</select></td>
																<th>상세 정보</th>
																<td><select id="detail" name="detail">
																		<option value="--선택--"
																			${chninfo.chndept == null && chninfo.chnpstn == '0' ? 'selected' : ''}>--선택--</option>
																		<option value="0"
																			${chninfo.chndept != null && chninfo.chnpstn == '0' ? 'selected' : ''}>부서</option>
																		<option value="1"
																			${chninfo.chndept == null && chninfo.chnpstn != '0' ? 'selected' : ''}>직책</option>
																		<option value="2"
																			${chninfo.chndept != null && chninfo.chnpstn != '0' ? 'selected' : ''}>부서
																			+ 직책</option>
																</select></td>
															</tr>
															<tr>
																<th>부서 변경</th>
																<td><select id="chndept" name="chndept">
																		<option value="--선택--"
																			${chninfo.chndept == null ? 'selected' : ''}>--선택--</option>
																		<option value="E0"
																			${chninfo.chndept == 'E0' ? 'selected' : ''}>경영지원팀</option>
																		<option value="E1"
																			${chninfo.chndept == 'E1' ? 'selected' : ''}>인사팀</option>
																		<option value="E2"
																			${chninfo.chndept == 'E2' ? 'selected' : ''}>재무팀</option>
																		<option value="E3"
																			${chninfo.chndept == 'E3' ? 'selected' : ''}>영업팀</option>
																		<option value="E4"
																			${chninfo.chndept == 'E4' ? 'selected' : ''}>마케팅팀</option>
																</select></td>
																<th>직책 변경</th>
																<td><select id="chnpstn" name="chnpstn">
																		<option value="--선택--"
																			${chninfo.chnpstn == '0' ? 'selected' : ''}>--선택--</option>
																		<option value="1"
																			${chninfo.chnpstn == '1' ? 'selected' : ''}>팀장</option>
																		<option value="2"
																			${chninfo.chnpstn == '2' ? 'selected' : ''}>팀원</option>
																</select></td>
															</tr>
															<tr>
																<td colspan="4" align="center">
																	<button type="submit" class="btn btn-success">제출</button>
																	<button type="button" class="btn btn-info"
																		onclick="location.href='empChnDetail?chno=${chninfo.chno}'">이전으로</button>
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
        function validate() {
            const alerts = ["요청 정보를 입력해주세요", "요청 상세정보를 입력해주세요"];
            let typchn = document.getElementById("typchn").value;
            let detail = document.getElementById("detail").value;
            let chndept = document.getElementById("chndept").value;
            let chnpstn = document.getElementById("chnpstn").value;
            
            if (typchn === "--선택--") {
                alert(alerts[0]);
                return false;
            }
            if ((typchn === "0" && detail === "--선택--") ||
                (detail === "0" && chndept === "--선택--") ||
                (detail === "1" && chnpstn === "--선택--") ||
                (detail === "2" && (chndept === "--선택--" || chnpstn === "--선택--"))) {
                alert(alerts[1]);
                return false;
            }
            return true;
        }

        document.addEventListener('DOMContentLoaded', function () {
            // 페이지 로드 시 초기 상태 설정
            setInitialFormState();
        });

        function setInitialFormState() {
            const typchn = document.getElementById('typchn').value;
            const detail = document.getElementById('detail');
            const chndept = document.getElementById('chndept');
            const chnpstn = document.getElementById('chnpstn');

            if (typchn === '0') {
                detail.disabled = false;
                setDetailDependencies(detail.value);
            } else {
                detail.disabled = true;
                detail.value = '--선택--';
                chndept.disabled = true;
                chndept.value = '--선택--';
                chnpstn.disabled = true;
                chnpstn.value = '--선택--';
            }
        }

        function setDetailDependencies(detailValue) {
            const chndept = document.getElementById('chndept');
            const chnpstn = document.getElementById('chnpstn');

            switch (detailValue) {
                case '0':
                    chndept.disabled = false;
                    chnpstn.disabled = true;
                    chnpstn.value = '--선택--';
                    break;
                case '1':
                    chndept.disabled = true;
                    chndept.value = '--선택--';
                    chnpstn.disabled = false;
                    break;
                case '2':
                    chndept.disabled = false;
                    chnpstn.disabled = false;
                    break;
                default:
                    chndept.disabled = true;
                    chndept.value = '--선택--';
                    chnpstn.disabled = true;
                    chnpstn.value = '--선택--';
            }
        }

        document.getElementById('typchn').addEventListener('change', function () {
            setInitialFormState();
        });

        document.getElementById('detail').addEventListener('change', function () {
            setDetailDependencies(this.value);
        });
    </script>
</body>
</html>
