<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page session="true"%>
<!DOCTYPE html>
<html>
<head>
</head>
<body>
<table class="table table-striped table-hover projects">  
	<thead class="thead-dark">
		<tr align="center">
			<th id="bno">글번호</th>
			<th id="ttl">제목</th>
			<th id="udtcnt">조회수</th>
		</tr>
	</thead>
	   <tbody align="center">
	       <c:forEach var="board" items="${getaumlist}">
			<tr align="center" class="record" onclick="location.href='detail?bno=${board.bno}&source=aumlist'">
				<td>${board.bno}</td>
				<c:choose>
					<c:when test="${board.chk == 1}">
						<td style="font-weight: bold; color: red;">${board.ttl}</td>
					</c:when>
					<c:otherwise>
						<td >${board.ttl}</td>
					</c:otherwise>
				</c:choose>
				<td>${board.udtcnt}</td>
				
			</tr>
			</c:forEach>
	  
	   </tbody>
</table>
<div align="right">
    <a href="${contextPath}/aumlist">더보기+</a>
</div>

</body>
</html>