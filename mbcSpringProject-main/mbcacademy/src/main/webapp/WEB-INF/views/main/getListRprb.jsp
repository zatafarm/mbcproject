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
		        <th id="bno">글번호</th>
		        <th id="ttl">제목</th>
		        <th id="rprb">신고수</th>
		    </tr>
		</thead>
		<tbody>
		    <c:forEach var="board" items="${listrprb}">
		       <c:if test="${board.rprb >= 10}">
		         <tr align="center" class="record" onclick="location.href='detail?bno=${board.bno}&source=list'">
		            <td>${board.bno}</td>
		            <td>${board.ttl}</td>
		            <td>${board.rprb}</td>
		         </tr>
				</c:if>
			</c:forEach>
	    </tbody>
	</table>
</body>
</html>