<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
.boldth {
	font-weight: bold;
	width: 150px;
}

.detailmodal {
	cursor: pointer;
}

.detailmodal:hover {
	background: silver;
}

.custom-modal-size {
	width: 800px;
	max-width: 800px;
	height: 600px;
	max-height: 600px;
}

.search-btn {
	margin-bottom: 5px;
}
</style>

<script>
	$(document).ready(function() {
		$('.search-btn').on('click', function(event) {
			event.preventDefault();
			var searchText = document.getElementById('searchText').value;
			var searchSelect = document.getElementById('searchSelect').value;
			$.ajax({
				url : "/emplistmodalsearch",
				type : "get",
				data : {
					searchText : searchText,
					searchSelect : searchSelect
				},
				success : function(data) {
					$('#modalContent').html(data);

				},
				error : function(xhr, status, error) {
					console.error("Error: " + status + " " + error);
				}
			});
		});
	});
</script>

<script>
$(document).ready(function() {
    $('.detailmodal').on('click', function() {
        let empno = $(this).data('empno'); // 사원 번호 추출
        $.ajax({
            url: "/searchEmpChn",
            type: 'GET',
            data: { empno: empno },
            success: function(response) {
                // 서버에서 반환된 JSON 데이터를 사용하여 폼 필드를 업데이트
                $('#whochn').val(response.empno);
                $('#ename').val(response.ename);
                $('#dept').val(response.codenm);
                $('#pstn').val(response.pstnm);
                // 모달창 닫기
                $('#empolyModal').modal('hide');
            },
            error: function(xhr, status, error) {
                console.error("에러 발생: " + error);
            }
        });
    });
});

</script>

</head>
<body>
	<div align="right">
		<form>
			<select name="languages" id="searchSelect">
				<option value="detpsearch">부서</option>
				<option value="namesearch">이름</option>
			</select> <input type="text" placeholder="검색 입력" name="searchText"
				id="searchText">
				<button type="submit" class="btn btn-info search-btn"><i class="fa fa-search"></i></button>
		</form>
	</div>
	<div class="table-responsive-sm">
		<table class="table table-bordered"
			style="background-color: white; text-align: center;">
			<thead>
				<tr>
					<th class="boldth">사번</th>
					<th class="boldth">이름</th>
					<th class="boldth">부서</th>
					<th class="boldth">직책</th>
				</tr>
			</thead>
			<tbody>


				<c:forEach var="employ" items="${list}">
					<tr class="detailmodal" data-empno="${employ.empno}">
						<td>${employ.empno}</td>
						<td>${employ.ename}</td>
						<td>${employ.codenm}</td>
						<td>${employ.pstn}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<div class="paging">
		<div class="text-center clearfix">
			<ul class="pagination">
				<c:if test="${pageMaker.prev }">
					<li class="page-item"><a class="page-link"
						href='<c:url value="/empolylistsearch?searchSelect=${searchSelect}&searchText=${searchText}&page=${pageMaker.startPage-1 }"/>'><i
							class="fa fa-chevron-left"></i></a></li>
				</c:if>
				<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}"
					var="pageNum">
					<li class="${pageNum == pageMaker.cri.page ? 'active' : ''}">
						<a class="page-link"
						href='<c:url value="/empolylistsearch?searchSelect=${searchSelect}&searchText=${searchText}&page=${pageNum}"/>'><i
							class="fa">${pageNum}</i></a>
					</li>
				</c:forEach>

				<c:if test="${pageMaker.next && pageMaker.endPage >0 }">
					<li class="page-item"><a class="page-link"
						href='<c:url value="/empolylistsearch?searchSelect=${searchSelect}&searchText=${searchText}&page=${pageMaker.endPage+1 }"/>'><i
							class="fa fa-chevron-right"></i></a></li>
				</c:if>
			</ul>

		</div>
	</div>
	<script>
		$(document).ready(function() {
			$('.page-link').on('click', function(event) {
				event.preventDefault();

				var url = $(this).attr("href");

				var pageMatch = url.match(/page=(\d+)/);
				var page = pageMatch ? pageMatch[1] : undefined;
				$.ajax({
					url : url,
					type : "get",
					data : {
						page : page
					}, // 정의된 page 변수 사용
					success : function(data) {
						$('#modalContent').html(data);
					},
					error : function(xhr, status, error) {
						console.error("Error: " + status + " " + error);
					}
				});
			});
		});
	</script>

</body>
</html>
