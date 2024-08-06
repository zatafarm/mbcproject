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
	        <c:forEach var="board" items="${getlist}">
	            <tr class="record" onclick="location.href='detail?bno=${board.bno}&source=list'">
	                <td>${board.bno}</td>
	                <td >${board.ttl}</td>
	                <td>${board.udtcnt}</td>
	            </tr>
	        </c:forEach>
	    </tbody>
</table>
<div align="right">
    <a href="${contextPath}/list">더보기+</a>
</div>

</body>
</html>