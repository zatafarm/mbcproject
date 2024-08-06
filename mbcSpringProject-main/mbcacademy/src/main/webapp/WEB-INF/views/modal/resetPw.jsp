<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
.pwctable {
	width: 100%;
}

.pwctd {
	padding: 5px 0;
}

.pwclabel {
	display: inline-block;
	width: 130px;
	text-align: right;
	margin-right: 10px;
}

.pwcinput {
	width: calc(100% - 170px);
	box-sizing: border-box;
}
</style>

</head>
<body>
	<div class="modal-body">
		<table class="pwctable">
			<tr>
				<td class="pwctd"><label for="npw1" class="pwclabel">새 비밀번호:</label>
					<input class="pwcinput" type="password"
					placeholder="비밀번호 입력" name="npw1" id="npw1"
					style="margin-bottom: 10px;" />
				</td>
			</tr>
			<tr>
				<td class="pwctd"><label for="npw2" class="pwclabel">새 비밀번호 재확인:</label>
					<input class="pwcinput" type="password"
					placeholder="비밀번호 재확인 입력" name="npw2" id="npw2" /></td>
			</tr>
		</table>
	</div>
</body>
</html>