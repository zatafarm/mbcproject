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
<title>사내게시판 List</title>
<style>
.inline-container {
	display: flex;
	align-items: center;
	justify-content: flex-end;
	gap: 5px;
	width: 100%;
	margin-bottom: 10px;
}

.search-condition {
	color: gray;
	text-align: left;
	font-size: 15px;
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
				<form id="searchForm">
					<div class="midde_cont">
						<div class="container-fluid">
							<div class="row column_title">
								<div class="col-md-12">
									<div class="page_title">
										<h2>
											<a href="/list">사내게시판</a>
										</h2>
										<div>${msg}</div>
									</div>
								</div>
							</div>
							<!-- row -->
							<div class="row column1">
								<div class="col-md-12">
									<div class="white_shd full margin_bottom_30">
										<div class="full graph_head">
											<div class="margin_0">
												<div class="search-condition" id="searchConditionDisplay">${cri.resultSearch}</div>
												<div class="inline-container">
													<select id="searchSelect" name="searchSelect">
														<option value="" selected>--조건--</option>
														<option value="ttl">제목</option>
														<option value="cnt">내용</option>
														<option value="ename">작성자</option>
													</select>
													<div>
														<input type="text" id="keyword" placeholder="검색어 입력"
															name="keyword" maxlength="100">
													</div>
													<button type="submit" class="btn cur-p btn-info searchbt">
														<i class="fa fa-search"></i>
													</button>
													<c:if test="${admns != '1'}">
														<button type="button" class="btn btn-success"
															onclick="location.href='register'">작성</button>
														<button type="button" class="btn btn-outline-primary"
															onclick="location.href='mylist'">내 글 보기</button>
													</c:if>
												</div>
											</div>
										</div>
										<div class="full price_table padding_infor_info">
											<div class="row">
												<div class="col-lg-12">
													<div class="table-responsive-sm">
														<table class="table table-striped table-hover projects">
															<thead class="thead-dark">
																<tr align="center">
																	<th id="bno">글번호</th>
																	<th id="ttl">제목</th>
																	<th id="regdt">작성일</th>
																	<th id="ename">작성자</th>
																	<c:choose>
																		<c:when test="${id eq 'admin'}">
																			<th id="rprb">신고수</th>
																		</c:when>
																		<c:otherwise>
																			<th id="udtcnt">조회수</th>
																		</c:otherwise>
																	</c:choose>
																</tr>
															</thead>
															<tbody>
																<c:forEach var="board" items="${list}">
																	<tr align="center" class="record"
																		onclick="location.href='detail?bno=${board.bno}&source=list'">
																		<td>${board.bno}</td>
																		<td>${board.ttl}</td>
																		<td>${board.regdt}</td>
																		<td>${board.ename}</td>
																		<c:choose>
																			<c:when test="${id eq 'admin'}">
																				<c:if test="${board.rprb >= 10}">
																					<td style="font-weight: bold; color: red;">${board.rprb}</td>
																				</c:if>
																				<c:if test="${board.rprb < 10}">
																					<td>${board.rprb}</td>
																				</c:if>
																			</c:when>
																			<c:otherwise>
																				<td>${board.udtcnt}</td>
																			</c:otherwise>
																		</c:choose>
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
												<ul class="pagination" id="pagination">
													<!-- 첫 페이지 링크 -->
													<c:if test="${pageMaker.cri.page > 1}">
														<li class="page-item"><a class="page-link"
															href="javascript:void(0);"
															onclick="loadPage(1); return false;">First</a></li>
													</c:if>
													<!-- 이전 페이지 링크 -->
													<c:if test="${pageMaker.prev}">
														<li class="page-item"><a class="page-link"
															href="javascript:void(0);"
															onclick="loadPage(${pageMaker.startPage - 1}); return false;">Prev</a></li>
													</c:if>
													<!-- 페이지 번호 링크 -->
													<c:forEach var="num" begin="${pageMaker.startPage}"
														end="${pageMaker.endPage}">
														<li
															class="${pageMaker.cri.page == num ? 'page-item active' : 'page-item'}">
															<a class="page-link" href="javascript:void(0);"
															onclick="loadPage(${num}); return false;">${num}</a>
														</li>
													</c:forEach>
													<!-- 다음 페이지 링크 -->
													<c:if test="${pageMaker.next}">
														<li class="page-item"><a class="page-link"
															href="javascript:void(0);"
															onclick="loadPage(${pageMaker.endPage + 1}); return false;">Next</a></li>
													</c:if>
													<!-- 마지막 페이지 링크 -->
													<c:if test="${pageMaker.cri.page < pageMaker.totalPage}">
														<li class="page-item"><a class="page-link"
															href="javascript:void(0);"
															onclick="loadPage(${pageMaker.totalPage}); return false;">Last</a></li>
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
				</form>
				<!-- end dashboard inner -->
				<!-- footer -->
				<jsp:include page='/WEB-INF/views/include/footer.jsp' />
			</div>
		</div>
	</div>

	<script>
       let savedSearchSelect;
       let savedKeyword;
   
       $(document).ready(function() {
           const urlParams = new URLSearchParams(window.location.search);
           let searchSelect = urlParams.get('searchSelect');
           let keyword = urlParams.get('keyword');
   
           savedSearchSelect = searchSelect;
           savedKeyword = keyword;
   
           // 검색 버튼 클릭 이벤트
           $(document).on('click', '.searchbt', function() {
               let search = $("#searchSelect").val();
               let keyword = $("#keyword").val();
               if (!keyword) {
                   alert("검색어 입력이 필요합니다.");
                   return false; // 검색 중단
               }
               loadPage(1);
           });
           
   
           // 검색 조건 변경 시
          $(document).on("change", "#searchSelect", function() {
               let searchSelect = $(this).val();
               if (searchSelect) {
                   $("#keyword").prop("disabled", false);
                   savedSearchSelect = searchSelect;
                   savedKeyword = "";
               } else {
                   $("#keyword").prop("disabled", true);
                   savedSearchSelect = searchSelect;
                   savedKeyword = $("#keyword").val();
               }
           });
           
   
           // 검색 조건 및 키워드 초기화
           if (savedSearchSelect) {
               $("#searchSelect").val(savedSearchSelect);
           }
           if (savedKeyword) {
               $("#keyword").val(savedKeyword);
           }
   
           // 최초 접속 시 페이지 로드
           loadPage(1);
   
           // 뒤로가기/앞으로가기 이벤트 처리
           $(window).on('popstate', function(event) {
               if (event.originalEvent.state) {
                   loadPage(event.originalEvent.state.page);
               }
           });
   
           // 모달 관련 설정
           setupModal();
       });
   
       function loadPage(page) {
           const searchSelect = savedSearchSelect || "";
           const keyword = savedKeyword || "";
           const perPageNum = 10;
   
           $.ajax({
               url: "/getMbcListPage",
               type: "GET",
               data: { page, perPageNum, searchSelect, keyword },
               success: function(data) {
                   $('#content').html($(data).find('#content').html());
                   const newUrl = new URL(window.location.href);
                   newUrl.searchParams.set('page', page);
                   newUrl.searchParams.set('perPageNum', perPageNum);
                   newUrl.searchParams.set('searchSelect', searchSelect);
                   newUrl.searchParams.set('keyword', keyword);
                   window.history.pushState({ page: page }, "", newUrl.toString());
               },
               error: function(xhr) {
                   console.error("Error in loadPage:", xhr.responseText);
                   alert('페이징 비동기처리 실패');
               }
           });
       }
   
       function setupModal() {
           let checkedCount = 0;
   
           $('#chkAll').click(function() {
               $('input[name="chk"]').prop('checked', this.checked);
               checkedCount = $('input[name="chk"]:checked').length;
               updateModalText();
           });
   
           $('input[name="chk"]').change(function() {
               checkedCount = $('input[name="chk"]:checked').length;
               updateModalText();
           });
   
           function updateModalText() {
               $('#cancelModalBody').text("체크된 " + checkedCount + "건에 대하여 삭제 처리 하시겠습니까?");
           }
   
           $('.ptocancle').on('click', function(event) {
               event.preventDefault();
               if ($('input[name="chk"]:checked').length === 0) {
                   alert('삭제할 항목을 선택하세요.');
               } else {
                   $('#cancelModal').modal('show');
               }
           });
   
           $('#confirmDelete').on('click', function(event) {
               event.preventDefault();
               let deleteList = $('input[name="chk"]:checked').map(function() {
                   return $(this).val();
               }).get();
   
               $.ajax({
                   url: '/ptoDel',
                   type: 'POST',
                   data: JSON.stringify(deleteList),
                   contentType: 'application/json',
                   success: function(response) {
                       alert(response.msg);
                       location.reload();
                   },
                   error: function() {
                       alert('서버에 오류가 발생했습니다.');
                   }
               });
           });
       }
   </script>


	<!-- 삭제 모달 -->
	<div class="modal fade" id="cancelModal" tabindex="-1"
		aria-labelledby="cancelModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="cancelModalLabel">게시글 삭제</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body" id="cancelModalBody" align="center"></div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">취소</button>
					<button type="button" class="btn btn-danger" id="confirmDelete">삭제</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>