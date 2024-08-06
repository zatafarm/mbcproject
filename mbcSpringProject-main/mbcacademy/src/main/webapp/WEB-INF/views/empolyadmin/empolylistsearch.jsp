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
<style>
    .boldth {
        font-weight: bold; 
        width: 150px;
        
    }
        .detail{
        cursor: pointer; 
    }
    .detail:hover {
  background: silver;
}

.search-btn {
 margin-bottom: 5px;
}

.inline-container {
	display: flex;
	align-items: center;
	justify-content: flex-end;
	gap: 5px; /* 각 요소 간의 간격 조정 */
	width: 100%;
	margin-bottom: 10px;
}

</style>

<script>
function search() {
    var searchLength = document.getElementById("searchText").value.length;
    if (searchLength <= 0) {
        alert("검색어를 입력해주세요");
        return false;
    } else {
        return true;
    }
}
</script>

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
									<h2>
										<a href="/adminempolylist">사원 정보 관리</a>
									</h2>
								</div>
							</div>
						</div>
						<!-- row -->
						<div class="row column1">
							<div class="col-md-12">
								<div class="white_shd full margin_bottom_30">
									<div class="full graph_head">
										<div class="margin_0">
											<div class="inline-container">
												<form action = "/adminempolylistsearch" method="get" onsubmit = "return search()">
													<select name="searchSelect" id="searchSelect">
													    <option value="detpsearch">부서</option>
													    <option value="namesearch">이름</option>
													</select>
												  	<input type="text" placeholder="검색 입력" name="searchText" ID="searchText" >
												  	<input type="submit" class="btn btn-info" value="검색"/>
												</form>
											</div>
										</div>
									</div>
									<div class="full price_table padding_infor_info">
										<div class="row">
											<div class="col-lg-12">
												<div class="table-responsive-sm">
													<table class="table table-bordered" style="text-align: center;" >
														<thead>
															<tr>
					                                           <th class = "boldth">부서</th>
					                                           <th class = "boldth">직급</th>
					                                           <th class = "boldth">이름</th>
					                                           <th class = "boldth">내선 번호</th>
					                                           <th class = "boldth">지각</th>
					                                           <th class = "boldth">무단 결근</th>
					                                        </tr>
														</thead>
														<tbody>
															<c:forEach var="empoly" items="${list}">
																<tr class=detail onclick="location.href='/adminempolydetail?empno=${empoly.empno}'">
																	<td>${empoly.codenm}</td>
						                                       		<td>${empoly.ranks}</td>
						                                       		<td>${empoly.ename}</td>
						                                       		<td>${empoly.ctel}</td>
						                                       		<td>${empoly.cump}</td>
                                       								<td>${empoly.cuma}</td>
																</tr>
															</c:forEach>
														</tbody>
													</table>
												</div>
											</div>
										</div>
									</div>
									<!-- 페이징 -->
									<div class="paging">
									    <div class="text-center clearfix">
									 		<ul class="pagination">
											    <c:if test="${pageMaker.prev }">
												    <li class="page-item">
												        <a class="page-link" href='<c:url value="/adminempolylistsearch?searchSelect=${searchSelect}&searchText=${searchText}&page=${pageMaker.startPage-1 }"/>'><i class="fa fa-chevron-left"></i></a>
												    </li>
												</c:if>
												<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="pageNum">
												    <li class="${pageNum == pageMaker.cri.page ? 'active' : ''}">
												        <a class="page-link" href='<c:url value="/adminempolylistsearch?searchSelect=${searchSelect}&searchText=${searchText}&page=${pageNum}"/>' class="page-link"><i class="fa">${pageNum}</i></a>
												    </li>
												</c:forEach>
												<c:if test="${pageMaker.next && pageMaker.endPage >0 }">
												    <li class="page-item">
												        <a class="page-link" href='<c:url value="/adminempolylistsearch?searchSelect=${searchSelect}&searchText=${searchText}&page=${pageMaker.endPage+1 }"/>'><i class="fa fa-chevron-right"></i></a>
												    </li>
											    </c:if>
											</ul>
									    </div>
									</div>
									<!-- end 페이징 -->
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
</body>
</html>