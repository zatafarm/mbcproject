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
    <title>Main</title>
    <style>
        .boldth {
            font-weight: bold; 
            width: 150px;
        }
        .detail {
            cursor: pointer; 
        }
        .detail:hover {
            background: silver;
        }
        .search-btn {
            margin-bottom: 5px;
        }
        .inline-container {
            display: flex;
            align-items: center;
            justify-content: flex-end;
            gap: 5px;
            width: 100%;
            margin-bottom: 10px;
        }
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }
        h1 {
            background-color: #4CAF50;
            color: white;
            padding: 20px;
            text-align: center;
        }
        .button-container {
            display: flex;
            justify-content: center;
            margin: 20px 0;
        }
        .button-container button {
            background-color: #f1f1f1;
            border: none;
            color: #333;
            padding: 10px 20px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            margin: 4px 2px;
            cursor: pointer;
            border-radius: 4px;
        }
        .button-container button:hover {
            background-color: #e6e6e6;
        }
        #attendanceRecordContainer {
            padding: 20px;
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
        }
        .card {
            background-color: white;
            border: 1px solid #ddd;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            margin: 10px;
            padding: 20px;
            width: 300px;
            text-align: center;
        }
        .card h3 {
            margin-top: 0;
        }
        .card p {
            color: #666;
        }
        .card button {
            background-color: #4CAF50;
            border: none;
            color: white;
            padding: 10px 20px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            margin: 4px 2px;
            cursor: pointer;
            border-radius: 4px;
        }
        .card button:hover {
            background-color: #45a049;
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
                <div class="midde_cont">
                    <div class="container-fluid">
                        <div class="row column_title">
                            <div class="col-md-12">
                                <h1>출근 기록부</h1>
                                <div class="button-container">
                                    <% for (int i = 1; i <= 12; i++) { %>
                                        <button onclick="location.href='/gtwpluslist?month=<%= i %>'"><%= i %>월</button>
                                    <% } %>
                                </div>
                                <div id="attendanceRecordContainer"></div>
                               <div class="table-responsive-sm">
                                    <table class="table table-bordered" style="background-color: white; text-align: center; ">
                                   		<c:choose>
			      							<c:when test="${!empty attdlistmonth}"> 
												<thead>
												   <tr>
												      <th class = "boldth">날짜</th>
												      <th class = "boldth">출근 시간</th>
												      <th class = "boldth">퇴근 시간</th>
												      <th class = "boldth">근무 상태</th>
												   </tr>
												</thead>
												<tbody>
													<c:forEach var="attd" items="${attdlistmonth}">
														<tr>
															<td>${attd.ATTDT}</td>
															<td>${attd.STRTM}</td>
															<td>${attd.ENTM}</td>
															<td>${attd.codenm}</td>
														</tr>
													</c:forEach>
												</tbody>
											</c:when>
	                                       	<c:otherwise>
		                                       	<div class="white_shd full">
		                                       		<div class="full price_table padding_infor_info" align="center">
		                                       			출근 기록 없음
		                                       		</div>
	                                       		</div>
	                                       	</c:otherwise>
                                      	</c:choose>
                                    </table>
                                    </div>
                                        <div align="right">
				                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- end dashboard inner -->
                <!-- footer -->
                <jsp:include page='/WEB-INF/views/include/footer.jsp' />
            </div>
        </div>
    </div>
</body>
</html>
