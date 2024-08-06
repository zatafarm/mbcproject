    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
    <%@ page session="true"%>
    <c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page='/WEB-INF/views/include/head.jsp' />
    <title>메인</title>
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background-color: #f0f2f5;
            margin: auto;
        }
        
        .container {
            background-color: #ffffff;
            border: 1px solid #ddd;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin-top: 50px;
        }

        .container h2 {
            text-align: center;
            font-size: 2em;
            color: #333;
            margin-bottom: 30px;
        }

        .time-setting {
            background-color: #f9f9f9;
            border: 1px solid #ddd;
            padding: 20px;
            margin: 20px 0;
            border-radius: 8px;
        }

        .time-setting h3 {
            margin-top: 0;
            margin-bottom: 15px;
            font-size: 1.5em;
            color: #333;
            text-align: center;
        }

        .time-input {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 10px;
        }

        .time-input label, .time-label {
            margin-right: 10px;
            font-weight: bold;
        }

        .time-input input {
            width: 60px;
            padding: 5px;
            font-size: 1em;
            border: 1px solid #ccc;
            border-radius: 4px;
            text-align: center;
        }

        .time-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        button[type="submit"] {
            display: block;
            width: 100%;
            padding: 10px 20px;
            font-size: 1.2em;
            color: #fff;
            background-color: #007bff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        button[type="submit"]:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body class="dashboard dashboard_1">
    <jsp:include page='/WEB-INF/views/include/body.jsp' />
    <div class="full_container">
        <div class="inner_container">
            <jsp:include page='/WEB-INF/views/include/sidebar.jsp' />
            <div id="content">
                <jsp:include page='/WEB-INF/views/include/topbar.jsp' />
                <div class="container">
                    <h2>출퇴근 시간 설정</h2>
                    <form action="/timesetattd" method="get">
                        <div class="time-setting">
                            <h3>출퇴근 시간</h3>
                            <div class="time-row">
                                <label for="sthour">출근 시간</label>
                                <input type="number" id="sthour" name="sthour" min="0" max="23" required> 시
                                <input type="number" id="stminute" name="stminute" min="0" max="59" required> 분
                                <span style="margin: 0 20px;">-</span>
                                <label for="enhour">퇴근 시간</label>
                                <input type="number" id="enhour" name="enhour" min="0" max="23" required> 시
                                <input type="number" id="enminute" name="enminute" min="0" max="59" required> 분
                            </div>
                        </div>
                        <button type="submit" >설정</button>
                    </form>
                </div>
                <jsp:include page='/WEB-INF/views/include/footer.jsp' />
            </div>
        </div>
    </div>
    <script>
        function padInput(input) {
            input.addEventListener('input', () => {
                let value = parseInt(input.value, 10);
                
                if (!isNaN(value)) {
                    value = Math.max(input.min, Math.min(input.max, value)); // 최소값과 최대값 사이로 제한
                    input.value = value.toString().padStart(2, '0'); // 값이 두 자리수가 되도록 조정
                }
            });
        }

        const stHourInput = document.getElementById('sthour');
        const stMinuteInput = document.getElementById('stminute');
        const enHourInput = document.getElementById('enhour');
        const enMinuteInput = document.getElementById('enminute');

        [stHourInput, stMinuteInput, enHourInput, enMinuteInput].forEach(padInput);
    </script>
</body>
</html>
