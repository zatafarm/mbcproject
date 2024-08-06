<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page session="true"%>
<!DOCTYPE html>
<html lang="en">
<head>
<style>
    .boldth {
        font-weight: bold; 
        width: 150px;
        }
</style>
<script>
</script>
</head>
<body class="dashboard dashboard_1">
<div class="table-responsive-sm">
                                    <table class="table table-bordered" style="background-color: white; text-align: center; ">
                                       <thead>
                                          <tr>
                                             <th class = "boldth">날짜</th>
                                             <th class = "boldth">출근 시간</th>
                                             <th class = "boldth">퇴근 시간</th>
                                             <th class = "boldth">근무 상태</th>
                                          </tr>
                                       </thead>
                                       <tbody>
                                       
                                       
      									<c:forEach var="attd" items="${attdlist}">
      									<tr>
                                       		<td>${attd.ATTDT}</td>
                                       		<td>${attd.STRTM}</td>
                                       		<td>${attd.ENTM}</td>
                                       		<td>${attd.codenm}</td>
                                       	</tr>
                                       	</c:forEach>
                                       </tbody>
                                    </table>
                                    </div>
                                        <div align="right">
				                   <a href="${contextPath}/gtwpluslist?month=1">더보기+</a>
				                </div>
</body>
</html>