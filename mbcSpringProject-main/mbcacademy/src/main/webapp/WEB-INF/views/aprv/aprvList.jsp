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
<title>Vacation Approval List</title>
<style>
.inline-container {
	display: flex;
	align-items: center;
	justify-content: flex-end;
	gap: 5px; /* 각 요소 간의 간격 조정 */
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
											<a href="/aprvList">결재 요청 현황</a>
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
													<select id="searchField" name="searchField"
														onchange="selectChanged()">
														<option value="" selected>--조건--</option>
														<option value="stts">결재 상태</option>
														<option value="ptotp">연차 종류</option>
														<option value="reqnm">신청자</option>
														<option value="aprvnm">결재자</option>
														<option value="reqdt">신청일</option>
														<option value="apprvldt">결재일</option>
													</select>

													<div id="keywordContainer">
														<!-- 선택된 조건에 따라 동적으로 변경될 입력 필드를 이곳에 추가합니다. -->
													</div>
													<button type="submit" class="btn btn-info"
														id="searchbt"><i class="fa fa-search"></i></button>
												</div>
											</div>
										</div>
										<div class="full price_table padding_infor_info">
											<div class="row">
												<div class="col-lg-12">
													<div class="table-responsive-sm">
														<table class="table table-striped table-hover projects">
															<thead class="thead-dark" align="center">
																<tr>
																	<th onclick="sortColumn('stts')">상태&nbsp;<c:choose>
																			<c:when
																				test="${cri.column == 'stts' && cri.sortOrder == 'asc'}">∧</c:when>
																			<c:when
																				test="${cri.column == 'stts' && cri.sortOrder == 'desc'}">∨</c:when>
																		</c:choose></th>
																	<th onclick="sortColumn('reqnm')">신청자&nbsp;<c:choose>
																			<c:when
																				test="${cri.column == 'reqnm' && cri.sortOrder == 'asc'}">∧</c:when>
																			<c:when
																				test="${cri.column == 'reqnm' && cri.sortOrder == 'desc'}">∨</c:when>
																		</c:choose></th>
																	<th onclick="sortColumn('ptotp')">구분&nbsp;<c:choose>
																			<c:when
																				test="${cri.column == 'ptotp' && cri.sortOrder == 'asc'}">∧</c:when>
																			<c:when
																				test="${cri.column == 'ptotp' && cri.sortOrder == 'desc'}">∨</c:when>
																		</c:choose></th>
																	<th onclick="sortColumn('reqdt')">신청일자&nbsp;<c:choose>
																			<c:when
																				test="${cri.column == 'reqdt' && cri.sortOrder == 'asc'}">∧</c:when>
																			<c:when
																				test="${cri.column == 'reqdt' && cri.sortOrder == 'desc'}">∨</c:when>
																		</c:choose></th>
																	<th onclick="sortColumn('apprvldt')">처리일자&nbsp;<c:choose>
																			<c:when
																				test="${cri.column == 'apprvldt' && cri.sortOrder == 'asc'}">∧</c:when>
																			<c:when
																				test="${cri.column == 'apprvldt' && cri.sortOrder == 'desc'}">∨</c:when>
																		</c:choose></th>
																	<th onclick="sortColumn('aprvnm')">결재자&nbsp;<c:choose>
																			<c:when
																				test="${cri.column == 'aprvnm' && cri.sortOrder == 'asc'}">∧</c:when>
																			<c:when
																				test="${cri.column == 'aprvnm' && cri.sortOrder == 'desc'}">∨</c:when>
																		</c:choose></th>
																</tr>
															</thead>

															<tbody id="aprvListTableBody" align="center">
																<c:forEach var="aprv" items="${list}">
																	<tr class="record"
																		onclick="location.href='aprvDetail?pno=${aprv.pno}&source=aprvList'">
																		<td>${aprv.sttsnm}</td>
																		<td>${aprv.reqnm}</td>
																		<td>${aprv.ptotpnm}</td>
																		<td>${aprv.reqdt}</td>
																		<td>${aprv.apprvldt}</td>
																		<td>${aprv.aprvnm}</td>
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
															onclick="loadPage(${pageMaker.startPage - 1}); return false;">Prev</a>
														</li>
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
															onclick="loadPage(${pageMaker.endPage + 1}); return false;">Next</a>
														</li>
													</c:if>
													<!-- 마지막 페이지 링크 -->
													<c:if test="${pageMaker.cri.page < pageMaker.totalPage}">
														<li class="page-item"><a class="page-link"
															href="javascript:void(0);"
															onclick="loadPage(${pageMaker.totalPage}); return false;">Last</a>
														</li>
													</c:if>
												</ul>
											</div>
										</div>
										<!-- 페이징 끝 -->
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
		let savedSearchField;
		let savedKeyword;
		let savedKeyword2;
		$(function(){
		    // 페이지가 로드될 때 URL에서 검색 필드와 검색어를 가져와 설정합니다.
		    let urlParams = new URLSearchParams(window.location.search);
		    let searchField = urlParams.get('searchField');
		    let keyword = urlParams.get('keyword');
		    let keyword2 = urlParams.get('keyword2');
		    
		    savedSearchField = searchField; // 검색 필드 저장
		    savedKeyword = keyword; // 검색어 저장
		    savedKeyword2 = keyword2; // 검색어2 저장
		    
		    // 날짜 선택기 설정 함수
		    function initializeDatepicker() {
		        $(".date").datepicker({
		            dateFormat: 'yy-mm-dd',
		            showOtherMonths: true,
		            showMonthAfterYear: true,
		            changeYear: true,
		            changeMonth: true,
		            showOn: "both",
		            buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif",
		            buttonImageOnly: true,
		            buttonText: "선택",
		            yearSuffix: "년",
		            monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		            monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		            dayNamesMin: ['일','월','화','수','목','금','토'],
		            dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'],
		            minDate: "-1M",
		            maxDate: "+1M"
		        });
		        $('#date1').datepicker("option", "onClose", function (selectedDate) {
		            $("#date2").datepicker("option", "minDate", selectedDate);
		        });
		        $('#date2').datepicker("option", "onClose", function (selectedDate) {
		            $("#date1").datepicker("option", "maxDate", selectedDate);
		        });
		    }
	
		    // 검색 조건에 따른 입력 필드 업데이트
		    window.selectChanged = function() {
		        let searchField = $("#searchField").val();
		        let keywordContainer = $("#keywordContainer");
	
		        // 기존의 입력 필드를 모두 제거
		        keywordContainer.empty();
	
		        // 선택된 검색 조건에 따라 적절한 입력 필드를 생성
		        switch (searchField) {
		            case "stts":
		                keywordContainer.html(`
		                    <select id="keyword" name="keyword">
		                        <option value="" selected>--상태--</option>
		                        <option value="P0">대기</option>
		                        <option value="P1">1차승인</option>
		                        <option value="P2">최종승인</option>
		                        <option value="P3">반려</option>
		                    </select>`);
		                break;
		            case "ptotp":
		                keywordContainer.html(`
		                    <select id="keyword" name="keyword">
		                        <option value="" selected>--구분--</option>
		                        <option value="T0">연차</option>
		                        <option value="T1">반차</option>
		                        <option value="T2">기타</option>
		                    </select>`);
		                break;
		            case "reqnm":
		            case "aprvnm":
		                keywordContainer.html(`<input type="text" id="keyword" name="keyword">`);
		                break;
		            case "reqdt":
		            case "apprvldt":
		                keywordContainer.html(`
		                    <input type="text" class="date" id="date1" name="keyword" placeholder="yyyy-mm-dd">
		                    &nbsp;&nbsp;&nbsp;&nbsp;~&nbsp;&nbsp;&nbsp;
		                    <input type="text" class="date" id="date2" name="keyword2" placeholder="yyyy-mm-dd">`);
		                initializeDatepicker(); // datepicker 초기화
		                break;
		            default:
		                // 기본적으로 텍스트 입력 필드를 생성
		                
		        }
		    };
		});
	
		// 정렬 기능
		let sortedColumn = "stts"; // 정렬된 열을 추적하기 위한 변수 추가
		let sortedOrder = "asc"; // 초기 정렬 방식 설정
	
		function sortColumn(column) {
		    // 클릭된 열이 현재 정렬된 열인지 확인
		    if (column === sortedColumn) {
		        sortedOrder = (sortedOrder === "asc") ? "desc" : "asc"; // 순서를 토글
		    } else {
		        sortedColumn = column;
		        sortedOrder = "asc"; // 새로운 열은 오름차순으로 정렬
		    }
		    // 서버에 정렬 방식을 전달하고 데이터를 비동기적으로 요청
		    loadPage(1, sortedColumn, sortedOrder);
		}
	
		// 비동기 정렬 및 페이징 처리
		function loadPage(page, column = sortedColumn, sortOrder = sortedOrder) {
			const searchField = savedSearchField || "";
		   	const keyword = savedKeyword || "";
		   	const keyword2 = savedKeyword2 || "";
		   	const perPageNum = 10; // 기본값으로 설정
	
		    $.ajax({
		        url: "/getAprvListPage",
		        type: "GET",
		        data: {
		            page: page,
		            perPageNum: perPageNum,
		            searchField: searchField,
		            keyword: keyword,
		            keyword2: keyword2,
		            column: column,
		            sortOrder: sortOrder
		        },
		        success: function(data) {
		            $('#content').html($(data).find('#content').html());
		            // URL 업데이트
		            const newUrl = new URL(window.location.href);
		            newUrl.searchParams.set('page', page);
		            newUrl.searchParams.set('perPageNum', perPageNum);
		            newUrl.searchParams.set('searchField', searchField);
		            newUrl.searchParams.set('keyword', keyword);
		            if (keyword2) {
		                newUrl.searchParams.set('keyword2', keyword2);
		            }
		            newUrl.searchParams.set('sortedColumn', column);
		            newUrl.searchParams.set('sortedOrder', sortOrder);
		            window.history.pushState({page: page, sortedColumn: column, sortedOrder: sortOrder}, "", newUrl.toString());
		        },
		        error: function(xhr, status, error) {
		            console.error("Error in loadPage:", xhr.responseText);
		            alert('페이징 비동기처리 실패');
		        }
		    });
		}
	
		$(document).ready(function() {
		    // 페이지가 로드될 때 현재 URL의 쿼리 파라미터를 가져와서 데이터를 로드
		    loadPageFromUrl();
		    
		    // 검색 필드 값이 변경될 때마다 검색 조건에 따른 필드 업데이트 실행
		    $("#searchField").on('change', function() {
		        selectChanged(); // 검색 필드 변경 시 검색어 입력 필드 업데이트
		    });

		    // 검색 버튼 클릭 이벤트 위임
		    $(document).on('click', '#searchbt', function() {
		        let SearchField = $("#searchField").val();
		        let Keyword = $("#keywordContainer :input[name='keyword']").val(); // keywordContainer 내의 입력 필드 값
		        let Keyword2 = $("#keywordContainer :input[name='keyword2']").val();
		        if(SearchField === "reqdt" || SearchField === "apprvldt"){
		            if (!Keyword || !Keyword2) {
		                alert("검색어 입력이 필요합니다.");
		                return false; // 검색 중단
		            }
		        } else {
		            if(!Keyword) {
		                alert("검색어 입력이 필요합니다.");
		                return false; // 검색 중단
		            }
		        }
		        // 검색어가 제대로 설정되었으면 데이터를 로드
		        loadPage(1);
		    });

		    // 뒤로가기/앞으로가기 이벤트 처리
		    $(window).on('popstate', function(event) {
		        if (event.originalEvent.state) {
		            loadPage(event.originalEvent.state.page, event.originalEvent.state.sortedColumn, event.originalEvent.state.sortedOrder);
		        }
		    });
		});
	
		// 현재 URL의 쿼리 파라미터를 가져와서 데이터를 로드하는 함수
		function loadPageFromUrl() {
		    const urlParams = new URLSearchParams(window.location.search);
		    const page = urlParams.get('page') || 1;
		    const perPageNum = urlParams.get('perPageNum') || 10;
		    const searchField = urlParams.get('searchField') || "";
		    const keyword = urlParams.get('keyword') || "";
		    const keyword2 = urlParams.get('keyword2') || "";
		    const column = urlParams.get('sortedColumn') || sortedColumn;
		    const sortOrder = urlParams.get('sortedOrder') || sortedOrder;
	
		    $("#searchField").val(searchField).trigger('change');
		    $("#keywordContainer :input[name='keyword']").val(keyword);
		    $("#keywordContainer :input[name='keyword2']").val(keyword2);
	
		    loadPage(page, column, sortOrder);
		}
	</script>
</body>
</html>