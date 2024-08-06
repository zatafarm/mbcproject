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
<title>Employee information change request list</title>
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
											<a href="/empChnList">정보 변경 요청 현황</a>
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
												<div class="search-condition" id="searchConditionDisplay">
													${cri.resultSearch}</div>

												<div class="inline-container">

													<select id="searchField" name="searchField"
														onchange="selectChanged()">
														<option value="" selected>--조건--</option>
														<option value="reqnm">신청자</option>
														<option value="whochnnm">대상자</option>
														<option value="typchn">변경 종류</option>
														<option value="reqdt">신청일</option>
														<option value="resdt">결재일</option>
													</select>

													<div id="keywordContainer">
														<!-- 선택된 조건에 따라 동적으로 변경될 입력 필드를 이곳에 추가합니다. -->
													</div>
													<button type="submit" class="btn btn-info"
														id="searchbt"><i class="fa fa-search"></i></button>
													<c:if test="${id ne 'admin'}">
														<button type="button" class="btn btn-success"
															onclick="location.href='empChnApply'">변경 요청</button>
														<button type="button"
															class="btn btn-danger ptocancle">요청 취소</button>
													</c:if>
												</div>
											</div>
										</div>
										<div class="full price_table padding_infor_info">
											<div class="row">
												<div class="col-lg-12">
													<div class="table-responsive-sm">
														<table class="table table-striped table-hover projects">
															<thead align="center" class="thead-dark">
																<tr>
																	<c:if test="${id ne 'admin'}">
																		<th><input type="checkbox" id="chkAll"
																			name="chkAll"></th>
																	</c:if>
																	<th onclick="sortColumn('res')">상태&nbsp;<c:choose>
																			<c:when
																				test="${cri.column == 'res' && cri.sortOrder == 'asc'}">∧</c:when>
																			<c:when
																				test="${cri.column == 'res' && cri.sortOrder == 'desc'}">∨</c:when>
																		</c:choose></th>
																	<th onclick="sortColumn('reqnm')">신청자&nbsp;<c:choose>
																			<c:when
																				test="${cri.column == 'reqnm' && cri.sortOrder == 'asc'}">∧</c:when>
																			<c:when
																				test="${cri.column == 'reqnm' && cri.sortOrder == 'desc'}">∨</c:when>
																		</c:choose></th>
																	<th onclick="sortColumn('typchn')">변경종류&nbsp;<c:choose>
																			<c:when
																				test="${cri.column == 'typchn' && cri.sortOrder == 'asc'}">∧</c:when>
																			<c:when
																				test="${cri.column == 'typchn' && cri.sortOrder == 'desc'}">∨</c:when>
																		</c:choose></th>
																	<th onclick="sortColumn('reqdt')">신청일&nbsp;<c:choose>
																			<c:when
																				test="${cri.column == 'reqdt' && cri.sortOrder == 'asc'}">∧</c:when>
																			<c:when
																				test="${cri.column == 'reqdt' && cri.sortOrder == 'desc'}">∨</c:when>
																		</c:choose></th>
																	<th onclick="sortColumn('resdt')">처리일&nbsp;<c:choose>
																			<c:when
																				test="${cri.column == 'resdt' && cri.sortOrder == 'asc'}">∧</c:when>
																			<c:when
																				test="${cri.column == 'resdt' && cri.sortOrder == 'desc'}">∨</c:when>
																		</c:choose></th>
																</tr>
															</thead>
															<tbody align="center">
																<c:forEach var="ch" items="${chninfo}">
																	<tr class="record"
																		onclick="location.href='empChnDetail?chno=${ch.chno}'">
																		<c:if test="${id ne 'admin'}">
																			<td onclick='event.cancelBubble=true;'><input
																				type="checkbox" name="chk" value="${ch.chno}"></td>
																		</c:if>
																		<td><c:choose>
																				<c:when test="${ch.res == 0}">미처리</c:when>
																				<c:otherwise>처리완료</c:otherwise>
																			</c:choose>
																		</td>
																		<td>${ch.reqnm}</td>
																		<td><c:if test="${ch.typchn == 0 }">정보 변경</c:if>
																			<c:if test="${ch.typchn == 1 }">퇴사</c:if></td>
																		<td>${ch.reqdt}</td>
																		<td>${ch.resdt}</td>
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
	            dateFormat: 'yy-mm-dd', // 달력 날짜 형태
	            showOtherMonths: true, // 빈 공간에 현재월의 앞뒤월의 날짜를 표시
	            showMonthAfterYear: true, // 월-년 순서가 아닌 년도-월 순서
	            changeYear: true, // 년 선택 가능
	            changeMonth: true, // 월 선택 가능
	            showOn: "both", // 달력 표시 방법 (button 또는 both)
	            buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif", // 버튼 이미지 경로
	            buttonImageOnly: true, // 버튼 이미지만 표시
	            buttonText: "선택", // 버튼 호버 텍스트
	            yearSuffix: "년", // 년도 부분 뒤 텍스트
	            monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'], // 월 부분 텍스트
	            monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'], // 월 부분 Tooltip
	            dayNamesMin: ['일','월','화','수','목','금','토'], // 요일 텍스트
	            dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'], // 요일 Tooltip
	            minDate: "-1M", // 최소 선택일자 (-1D: 하루전, -1M: 한달전, -1Y: 일년전)
	            maxDate: "+1M" // 최대 선택일자 (+1D: 하루후, -1M: 한달후, -1Y: 일년후)
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

	        // 기존의 입력 필드를 모두 제거합니다.
	        keywordContainer.empty();

	        // 선택된 검색 조건에 따라 적절한 입력 필드를 생성합니다.
	        switch (searchField) {
	            case "reqnm":
	            case "whochnnm":
	            	keywordContainer.html(`<input type="text" id="keyword" name="keyword">`);
	                break;
	            case "typchn":
	                keywordContainer.html(`
	                        <select id="keyword" name="keyword">
	                            <option value="" selected>--구분--</option>
	                            <option value="0">정보변경</option>
	                            <option value="1">퇴사</option>
	                        </select>`);
	                break;
	            case "reqdt":
	            case "resdt":
	                keywordContainer.html(`
	                        <input type="text" class="date" id="date1" name="keyword" placeholder="yyyy-mm-dd">
	                        &nbsp;&nbsp;&nbsp;&nbsp;~&nbsp;&nbsp;&nbsp;
	                        <input type="text" class="date" id="date2" name="keyword2" placeholder="yyyy-mm-dd">`);
	                initializeDatepicker(); // datepicker 초기화
	                break;
	            default:
	                // 기본적으로 텍스트 입력 필드를 생성합니다.
	                
	        }
	    };
	});

	 // 정렬 기능
	let sortedColumn = "res"; // 정렬된 열을 추적하기 위한 변수 추가
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
	        url: "/getEmpChnListPage",
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

	// 체크박스와 모달 이벤트
	$(document).ready(function() {
	    // 페이지가 로드될 때 현재 URL의 쿼리 파라미터를 가져와서 데이터를 로드
	    loadPageFromUrl();

	    // 체크된 항목의 개수를 저장할 변수
	    let checkedCount = 0;

	    $(document).on('click', '#chkAll', function() {
	        $('input[name="chk"]').prop('checked', this.checked);
	        checkedCount = $('input[name="chk"]:checked').length; // 체크된 항목의 개수 업데이트
	        updateModalText(); // 모달 내용 업데이트
	    });

	    // 각 체크박스에 대해 체크 상태 변경 시 체크된 항목의 개수를 업데이트함
	    $(document).on('change', 'input[name="chk"]', function() {
	        checkedCount = $('input[name="chk"]:checked').length;
	        updateModalText();
	    });

	    // 모달 내용 업데이트 함수
	    function updateModalText() {
	        $('#cancelModalBody').text("체크된 " + checkedCount + "건에 대하여 삭제 처리 하시겠습니까?");
	    }

	    // 모달 열기
	    $(document).on('click', '.ptocancle', function(event) {
	        event.preventDefault();
	        let checkedItems = $('input[name="chk"]:checked');
	        let hasNonPending = false; // 대기 상태가 아닌 항목이 있는지 여부를 나타내는 변수

	        // 체크된 항목이 있는지 확인
	        if (checkedItems.length === 0) {
	            alert('삭제할 항목을 선택하세요.');
	            return; // 체크된 항목이 없으면 더 이상 진행하지 않고 함수 종료
	        }

	        checkedItems.each(function() {
	            let row = $(this).closest('tr'); // 체크된 항목의 행을 가져옴
	            let statusCell = row.find("td:nth-child(2)"); // 상태 셀을 가져옴
	            let status = statusCell.text().trim(); // 상태 텍스트를 가져옴

	            if (status !== '미처리') {
	                hasNonPending = true; // 대기 상태가 아닌 항목이 체크되어 있으면 true로 설정
	            }
	        });

	        // 대기 상태가 아닌 항목이 체크되었을 때 모달 열기
	        if (hasNonPending) {
	            alert('처리 완료된 항목은 삭제할 수 없습니다.');
	        } else {
	            $('#cancelModal').modal('show');
	        }
	    });

	    // 삭제 확인
	    $(document).on('click', '#confirmDelete', function(event) {
	        event.preventDefault();
	        let checkedItems = $('input[name="chk"]:checked');
	        let deleteList = [];

	        checkedItems.each(function() {
	            deleteList.push($(this).val());
	        });

	        $.ajax({
	            url: '/empChnDel',
	            type: 'POST',
	            data: JSON.stringify(deleteList), // 삭제할 항목의 ID 목록을 JSON 형식으로 전송
	            contentType: 'application/json',
	            success: function(response) {
	                alert(response.msg);
	                // 성공 시 추가 로직 (예: 페이지 새로고침)
	                location.reload();
	            },
	            error: function() {
	                alert('서버에 오류가 발생했습니다.');
	            }
	        });
	    });

	    // 검색 필드 값이 변경될 때마다 검색 조건에 따른 필드 업데이트 실행
	    $("#searchField").on('change', function() {
	        selectChanged(); // 검색 필드 변경 시 검색어 입력 필드 업데이트
	    });

	    // 검색 버튼 클릭 이벤트 위임
	    $(document).on('click', '#searchbt', function() {
	        let searchField = $("#searchField").val();
	        let keyword = $("#keywordContainer :input[name='keyword']").val(); // keywordContainer 내의 입력 필드 값
	        let keyword2 = $("#keywordContainer :input[name='keyword2']").val();
	        if(searchField === "reqdt" || searchField === "resdt"){
	            if (!keyword || !keyword2) {
	                alert("검색어 입력이 필요합니다.");
	                return false; // 검색 중단
	            }
	        } else {
	            if(!keyword) {
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
	<!-- 신청 취소 모달 -->
	<div class="modal fade" id="cancelModal" tabindex="-1"
		aria-labelledby="cancelModalLabel" aria-hidden="true">
		<div class="modal-dialog  modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="cancelModalLabel">요청 취소</h5>
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