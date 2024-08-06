<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>직원 정보</title>
<style>
    .sbody {
        font-family: 'Arial', sans-serif;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        margin: 0;
        background-color: #f0f2f5;
    }
    .employee-card {
        display: flex;
        align-items: center;
        background-color: #ffffff;
        border-radius: 10px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        padding: 20px;
        margin: auto;
        width: 80%; 
        max-width: 600px; 
    }
    .employee-photo {
        width: 150px;
        height: 195px;
        margin-right: 20px;
        object-fit: cover;
    }
    .employee-info p{
        margin: 5px 0;
        color: #333;
        font-size: 16px;
    }
</style>

</head>
<body class=".sbody">
    <%
        String timestamp = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()); // 현재 시간을 포맷팅합니다.
    %>
<div class="employee-card">
    <img src="/resources/emp_pic/pic_${emp.empno}.jpg?<%= timestamp %>" alt="직원 사진" class="employee-photo">
    <div class="employee-info">
        <p>부서 :${emp.codenm}</p>
        <p>직책 :${emp.pstn}</p>
        <p>직급 :${emp.ranks}</p>
        <p>이름 :${emp.ename}</p>
        <p>내선번호: ${emp.ctelf}</p>
        <p>회사이메일: ${emp.cmail}</p>
    </div>
</div>

</body>
</html>