<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page session="true"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html lang="en">
<head>
<jsp:include page='/WEB-INF/views/include/head.jsp' />

<title>Main</title>
</head>
<body class="dashboard dashboard_1">
    <%
        // 세션에서 userdto 객체를 가져옴
       String user = (String) session.getAttribute("user");
    	String id = (String) session.getAttribute("id");
    	int admns = (int) session.getAttribute("admns");
        if (user == null || id == null) {
            response.sendRedirect("/login");
        }
    %>
<script type="text/javascript">
    var gowshowAlert = ${gowshowAlert != null ? gowshowAlert : false};
    var message = "${message != null ? message : ''}";

    if (gowshowAlert) {
        alert(message);
        window.location.href = "/";
    }
</script>

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
	       		<div class="full graph_head"></div>
				<div class="row column4 graph">
					<!-- tab 출근 기록 -->
					<div class="col-md-6">
						<div class="white_shd full margin_bottom_30">
							<div class="full graph_head">
								<div class="heading1 margin_0">
									<h2>출근 기록</h2>
								</div>
							</div>
							<div class="full inner_elements">
								<div class="row">
									<div class="col-md-12">
										<div class="tab_style2">
											<div class="tabbar padding_infor_info">
												<jsp:include page='/WEB-INF/views/main/gtwboard.jsp' />
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- end tab 출근 기록 -->
					<!-- tab 프로필 -->
					<div class="col-md-6">
						<div class="white_shd full margin_bottom_30">
							<div class="full graph_head">
								<div class="heading1 margin_0">
									<h2>My Profile</h2>
								</div>
							</div>
							<div class="full inner_elements">
								<div class="row">
									<div class="col-md-12">
										<div class="tab_style2">
											<div class="tabbar padding_infor_info">
												<jsp:include page='/WEB-INF/views/main/mainmyprofile.jsp' />
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- end tab 프로필 -->
					
					<!-- tab 게시판 -->
					<div class="col-md-6">
						<div class="white_shd full margin_bottom_30">
							<div class="full graph_head">
								<div class="heading1 margin_0">
									<h2>커뮤니티</h2>
								</div>
							</div>
							<div class="full inner_elements">
								<div class="row">
									<div class="col-md-12">
										<div class="tab_style2">
											<div class="tabbar padding_infor_info">
												<nav>
													<div class="nav nav-tabs" id="nav-tab" role="tablist">
													<a class="nav-item nav-link active" id="nav-aumlist-tab" data-toggle="tab" href="#nav-aumlist" role="tab" aria-controls="nav-aumlist" aria-selected="true">공지사항</a>
													<a class="nav-item nav-link" id="nav-list-tab" data-toggle="tab" href="#nav-list" role="tab" aria-controls="nav-list" aria-selected="false">사내 게시판</a>
													</div>
												</nav>
												<div class="tab-content" id="nav-tabContent">
													<div class="tab-pane fade show active" id="nav-aumlist" role="tabpanel" aria-labelledby="nav-aumlist-tab">
														<jsp:include page='/WEB-INF/views/main/getaumlist.jsp' />
													</div>
													<div class="tab-pane fade" id="nav-list" role="tabpanel" aria-labelledby="nav-list-tab">
														<jsp:include page='/WEB-INF/views/main/getlist.jsp' />
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- end tab 게시판 -->
					
					<!-- tab 휴가현황 -->
						<div class="col-md-6">
						<div class="white_shd full margin_bottom_30">
							<div class="full graph_head">
								<div class="heading1 margin_0">
									<h2>휴가 처리 현황</h2>
								</div>
							</div>
							<div class="full inner_elements">
								<div class="row">
									<div class="col-md-12">
										<div class="tab_style2">
											<div class="tabbar padding_infor_info">
												<nav>
													<div class="nav nav-tabs" id="nav-tab" role="tablist">
														<a class="nav-item nav-link active" id="nav-myptolist-tab" data-toggle="tab" href="#nav-myptolist" role="tab" aria-controls="nav-myptolist" aria-selected="true">내 휴가 신청 현황</a>
														<c:if test="${admns == '2' || admns == '3'}">
															<a class="nav-item nav-link" id="nav-apprlist-tab" data-toggle="tab" href="#nav-apprlist" role="tab" aria-controls="nav-apprlist" aria-selected="false">결재 리스트</a>
														</c:if>
													</div>
												</nav>
												<div class="tab-content" id="nav-tabContent">
													<div class="tab-pane fade show active" id="nav-myptolist" role="tabpanel" aria-labelledby="nav-myptolist-tab">
														<jsp:include page='/WEB-INF/views/include/ptoListMain.jsp' />
													</div>
													<div class="tab-pane fade" id="nav-apprlist" role="tabpanel" aria-labelledby="nav-apprlist-tab">
														<c:if test="${admns == '2' || admns == '3'}">															
															<jsp:include page='/WEB-INF/views/include/aprvListMain.jsp' />
														</c:if>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- end tab 휴가현황 -->
					
				</div>

				
				
				<!-- footer -->
				<jsp:include page='/WEB-INF/views/include/footer.jsp' />
			</div>
		</div>
	</div>
</body>
</html>