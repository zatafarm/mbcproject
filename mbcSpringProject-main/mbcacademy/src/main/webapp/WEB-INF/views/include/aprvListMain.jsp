<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page session="true"%>
<table class="table table-striped table-hover1 projects">
	<thead class="thead-dark" align="center">
		<tr>
			<th>신청자</th>
			<th>구분</th>
			<th>신청일자</th>
		</tr>
	</thead>
	<tbody id="aprvListTableBody" align="center">
		<c:forEach var="aprv" items="${aprvlist}">
			<tr class="record"
				onclick="location.href='aprvDetail?pno=${aprv.pno}&source=aprvList'">
				<td>${aprv.reqnm}</td>
				<td>${aprv.ptotpnm}</td>
				<td>${aprv.reqdt}</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
<div align="right">
<a href="${contextPath}/aprvList">더보기+</a>
</div>