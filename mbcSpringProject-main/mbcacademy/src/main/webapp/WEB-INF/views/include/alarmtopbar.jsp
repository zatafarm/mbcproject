<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Alarm Notification</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <style>
        .alarm-list {
            padding: 10px;
        }
        .alarm-item {
            padding: 10px;
            border-bottom: 1px solid #e0e0e0;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .alarm-item:last-child {
            border-bottom: none;
        }
        .recent-alarm {
            font-weight: bold;
        }
        .alarm-content {
            font-size: 14px;
            color: #333;
            text-decoration: none;
            transition: color 0.3s, background-color 0.3s;
        }
        .alarm-content:hover {
            color: #007bff;
            background-color: #f0f8ff;
        }
        .alarm-date {
            font-size: 10px;
            color: #808080;
            margin-left: 10px;
        }
        .alarm h2 {
            text-align: center;
            font-size: 24px;
            color: #333;
            padding-bottom: 10px;
            border-bottom: 2px solid #007bff;
            display: inline-block;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="alarm-list">
        <c:choose>
            <c:when test="${not empty alarmlist}">
                <h2 class="alarm">알람 목록</h2>
             <c:forEach var="alarm" items="${alarmlist}" varStatus="status">
    <div class="alarm-item <c:if test="${status.index == 0}">recent-alarm</c:if>">
        <a href="
            <c:choose>
                <c:when test="${alarm.prefixcontent == '휴가'}">
                    /aprvDetail?pno=${alarm.url}&source=ptoList
                </c:when>
                <c:when test="${alarm.prefixcontent == '댓글'}">
                    /detail?bno=${alarm.url}&source=list
                </c:when>
                <c:when test="${messagetype == 'warning'}">
                    /warning-page
                </c:when>
            </c:choose>
        " id = ${alarm.bno} class="alarm-content" onclick="handleAlarmClick(event)">
            ${alarm.content}
            <input type="hidden" id= ${alarm.bno} value = ${alarm.bno}/>
        </a>
        <span class="alarm-date">${alarm.adates}</span>
    </div>
</c:forEach>
     <div>
                  <a href="/alarmlist" class="btn btn-primary">알림 리스트 보기</a>
        </div>
            </c:when>
            <c:otherwise>
                <div class="alarm-item">
                    <span style="font-size: 15px;  font-weight: bold;">최근에 온 알림이 없습니다.</span>
                </div>
            </c:otherwise>
        </c:choose>


    	</div>
    </div>

<script>// 알람 삭제 링크 선택
function handleAlarmClick(event) {
	  event.preventDefault();
	  var alarmId = event.currentTarget.id; 
	  var alarmUrl = event.currentTarget.getAttribute('href');
	  $.ajax({
	    url: '/alarmdelete',
	    type: 'POST',
	    data: { alarmId: alarmId },
	    success: function(response) {
	      // 서버로부터 성공적으로 응답을 받은 경우
	      console.log('Server response:', response);
	      window.location.href = alarmUrl;
	    },
	    error: function(xhr, status, error) {
	      // 에러 발생 시 처리
	      console.error('Error:', error);
	    }
	  });
	}


</script>
<script>
</script>
</body>
</html>

