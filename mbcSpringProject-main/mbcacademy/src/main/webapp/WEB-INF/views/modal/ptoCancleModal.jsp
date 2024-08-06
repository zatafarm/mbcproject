<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
	</head>
	<body>
	<!-- 모달 기능 ON -->
		<div class="modal_bg" onClick="javascript:popClose();"></div>
		<!-- // 모달 기능 -->
		<form>
			<div class="modal_wrap">
				<div class="modal_form">
					<h1 class="padding-bottom_1">신청 내역 삭제</h1>
					<div class="modal-title">
						<p>선택하신 n건에 대한 휴가 신청을 삭제하시겠습니까?</p>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-danger" onClick="location.href='ptoDel'">삭제</button>
					<button type="button" class="btn btn-secondary" onClick="javascript:popClose();">닫기</button>
				</div>
			</div>
		</form>
	</body>
</html>