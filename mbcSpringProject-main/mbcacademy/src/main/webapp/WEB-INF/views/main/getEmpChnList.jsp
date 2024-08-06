<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page session="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
	<table class="table table-striped table-hover projects">
		<thead class="thead-dark">
		    <tr align="center">
		        <th id="reqnm">신청자</th>
		        <th id="typchn">변경종류</th>
		        <th id="reqdt">신청일</th>
		    </tr>
		</thead>
		<tbody align="center">
		    <c:forEach var="chninfo" items="${chninfo}">
		         <tr class="record" onclick="location.href='empChnDetail?chno=${chninfo.chno}'">
		            <td>${chninfo.reqnm}</td>
		            <td><c:if test="${chninfo.typchn == 0 }">정보 변경</c:if>
						<c:if test="${chninfo.typchn == 1 }">퇴사</c:if></td>
					<td>${chninfo.reqdt}</td>
		         </tr>
			</c:forEach>
	    </tbody>
	</table>
</body>
</html>