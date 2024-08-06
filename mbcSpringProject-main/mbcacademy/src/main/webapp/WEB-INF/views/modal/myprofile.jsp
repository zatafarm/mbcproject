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
.pwdiv {
text-align: center;}
        body {
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
<body>
    <%
        String timestamp = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()); // 현재 시간을 포맷팅합니다.
    %>
<script>
var phonetel = document.getElementById('p0').value;
document.getElementById('p1').value = phonetel.substring (0,3);
document.getElementById('p2').value = phonetel.substring (4,8);
document.getElementById('p3').value = phonetel.substring (9,13);
</script>  
                 <div class="container">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="employee-card2">
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
				            <td class="info-title title-column spacing-column">급여:</td>
				        <td class="content-column">
				        	${emp.fmtSal}
				        </td>
				    </tr>
				    
				</table>

                        </div>
                    </div>
                </div>
                <!-- 추가 정보 -->
                <div class="additional-info">
                    <div class="row" style="margin-left: auto">
                        <p class= "info-title">내선 번호: </p>
                        <div style="margin-left: 10px;">
                        <input class="info-input" type="text" value="031" maxlength="3" readonly />
					    <span class="hyphen">-</span>
					    <input class="info-input" type="text" value="2222" maxlength="4" readonly />
					    <span class="hyphen">-</span>
					    <input class="info-input" type="text" value="<c:out value='${emp.ctel}' />" maxlength="4" readonly />		    
					    </div>
                    </div>  
                    <div class="row" style="margin-left: auto">
                        <p class= "info-title">휴대폰 번호:</p>
                             <div style="margin-left: 10px">
                        <input class="info-input" type="text" maxlength="3"id = "p1" name = "p1" readonly />
					    <span class="hyphen">-</span>
					    <input class="info-input" type="text" maxlength="4" id = "p2" name = "p2" readonly  />
					    <span class="hyphen">-</span>
					    <input class="info-input" type="text" maxlength="4" id = "p3" name = "p3" readonly />
					    </div>
                    </div>
                    <div class="row" style="margin-left: auto">
                        <p class= "info-title">이메일:</p>
                        <input type="email" value="<c:out value='${emp.email}' />" style="width: 300px; height: 25px; margin-left: 10px; font-size: 12px" id = "email" name = "email" readonly >
                    </div>
                    <div class="row" style="margin-left: auto">
                       <p class= "info-title">주소:</p>
                       <input type="email" value="<c:out value='${emp.adr}' />" style="width: 500px; height: 25px; margin-left: 10px; font-size: 12px" id = "adress" name = "adress"  readonly >
                    </div>
                    
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
