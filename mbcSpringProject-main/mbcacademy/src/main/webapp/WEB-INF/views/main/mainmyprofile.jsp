<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
	.mainprofilebody {
            background-color: #f8f9fa;
        }
        .employee-card2 {
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 20px;
            margin-top: 20px;
        }
        .employee-photo2 {
            width: 150px;
            height: 150px;
            object-fit: cover;
        }
        .info-title {
            font-weight: bold;
            color: #343a40;
        }
        .info-text {
            margin-bottom: 10px;
            color: #495057;
        }
        .additional-info {
            border-top: 1px solid #dee2e6;
            padding-top: 20px;
            margin-top: 20px;
        }
        .main-info {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }
        .info-details {
            margin-left: 50px;
        }
	.table-info .title-column {
    width: 100px;
		}
		.table-info .content-column {
		    width: 200px;
		}
		.table-info .spacing-column {
		    width: 150px;
		}
		.table-info td, .table-info th {
    padding: 8px;
}
.hyphen {
    font-size: 20px; 
    margin-left: 10px;
    margin-right: 10px;
}
.info-input {
    width: 50px; 
    height: 25px;
    font-size: 12px
}
</style>

</head>
<body class="mainprofilebody">
    <%
        String timestamp = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()); // 현재 시간을 포맷팅합니다.
    %>

                <div class="main-info">
                    <!-- 직원 사진 -->
					 <input type="hidden" value ="<c:out value= "${emp.tel}"/>" id = "p0" name = "p0"/>  
                    <img src="/resources/emp_pic/pic_${id}.jpg?<%= timestamp %>" alt="직원 사진" class="employee-photo2">
                    <!-- 기본 정보 -->
                    <div class="info-details">
                        <div class="row">
					    <table class="table-info" style="background-color: white;">
				    <tr>
				        <td class="info-title title-column">사번:</td>
				        <td class="content-column">${emp.empno}</td>
				        <td class="info-title title-column spacing-column">부서:</td>
				        <td class="content-column">${emp.codenm}</td>
				    </tr>
				    <tr>
				        <td class="info-title title-column">직책:</td>
				        <td class="content-column">${emp.pstn}</td>
				        <td class="info-title title-column spacing-column">직급:</td>
				        <td class="content-column">${emp.ranks}</td>
				    </tr>
				    <tr>
				        <td class="info-title title-column">이름:</td>
				        <td class="content-column">${emp.ename}</td>
				            <td class="info-title title-column spacing-column">생년월일:</td>
				        <td class="content-column">${emp.bri}</td>
				    </tr>
				    	<tr>
				        <td class="info-title title-column">입사일:</td>
				        <td class="content-column">${emp.hrdt}</td>
				    </tr>
				    
				</table>

                        </div>
                    </div>
                </div>


</body>
</html>
