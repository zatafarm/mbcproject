<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<style>

.custom-modal-size2 {
            width:1200px;
    max-width: 1200px;
    height: 800px;
    max-height: 800px;
}
.pwctable {
    width: 100%;
    height: 100%;
}

.pwctd {
    padding: 5px 0;
}

.pwclabel {
    display: inline-block;
    width: 150px;
    text-align: right; 
    margin-right: 10px; 
}

.pwcinput {
    width: calc(100% - 170px); 
    box-sizing: border-box;
}
.header_section {
    display: flex;
    align-items: center;
    justify-content: start;
    width: 100%;
}

.logo_section {
    margin-bottom: 10px;
}

.button_section {
    margin-left: auto;
    margin-right: 20px; 
}

.right_topbar {
    display: flex;
    align-items: center;
}

.icon_info ul {
    display: flex;
    list-style: none;
    padding: 0;
    margin: 0;
}

.icon_info ul li {
    margin-left: 20px;
}

.user_profile_dd {
    display: flex;
    align-items: center;
    list-style: none;
    margin: 0;
    padding-left: 20px;
}
.dropdown-menu.alarm {
    left: auto;
    right: 0;
}

.dropdown-menu.alarm a {
color: black;
font-size: 12px;
}

</style>
   <%
    int alarmint = 0;
    String timestamp = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
%>

<script>
    var reconnectTimeout;

    function connectWebSocket() {
        webSocket = new WebSocket("ws://localhost:8080/websocket");

        webSocket.onopen = function() {
            console.log("웹 소켓 연결 성공");
            updateAlarmint();
        };

        webSocket.onmessage = function(event) {
            console.log("알림 수신: ");
            updateAlarmint();
        };

        webSocket.onclose = function(event) {
            console.log("웹 소켓 연결 종료:", event.code, event.reason);
            reconnectWebSocket();
        };

        webSocket.onerror = function(error) {
            console.error("WebSocket 오류:", error);
            webSocket.close();
        };
    }

    function reconnectWebSocket() {
        if (reconnectTimeout) {
            clearTimeout(reconnectTimeout);
        }
        reconnectTimeout = setTimeout(function() {
            console.log("웹 소켓 재연결 시도");
            connectWebSocket();
        }, 5000); // 5초 후에 재연결 시도
    }

    function updateAlarmint() {
        $.ajax({
            url: "/updateAlarmint",
            type: "POST",
            success: function(data) {
                $("#alarmint").text(data.alarmint);
                console.log("Alarmint updated successfully to:", data.alarmint);
            },
            error: function(xhr, status, error) {
                console.error("Error updating alarmint:", error);
                reconnectWebSocket();
            }
        });
    }

    window.onload = function() {
        connectWebSocket();
        checkInterval = setInterval(checkWebSocketStatus, 1000); // 1초마다 세션 상태 확인
    };
</script>

</head>
<body>

 <div class="topbar">
    <nav class="navbar navbar-expand-lg navbar-light">
        <div class="full">
            <div class="header_section">
                <div class="logo_section">
                    <a href="/"><img class="img-responsive" src="/resources/bootstrap/images/logo/logo.png" alt="#" /></a>
                </div>
                <div class="button_section">
                    <c:if test="${!(id eq 'admin') }">
                        <button class="btn btn-primary" type="button" data-toggle="modal" data-target="#gowModal">퇴근 하기</button>
                    </c:if>
                </div>
                <div class="right_topbar">
                    <div class="icon_info">
				   <ul class="alarm">
					    <li>
					        <a href="#" class="dropdown-toggle" id="notificationButton" data-toggle="dropdown">
					            <i class="fa fa-bell-o"></i>
					            <span class="badge" id="alarmint"><%= alarmint %></span>
					        </a>
					        <div class="dropdown-menu alarm" id="alarm" style="width: 380px; text-align: center;">
					        </div>
					    </li>
					</ul>
                        <ul class="user_profile_dd">
                            <li><a class="dropdown-toggle" data-toggle="dropdown"><img class="img-responsive rounded-circle" src="/resources/emp_pic/pic_${id}.jpg?<%= timestamp %>" alt="#" /><span class="name_user">${user}</span></a>
                                <div class="dropdown-menu">
                                    <a class="dropdown-item mypro">내 정보</a>
                                    <a class="dropdown-item pwc">비밀번호 변경</a>
                                    <a class="dropdown-item" href="/logout"><span>로그아웃</span><i class="fa fa-sign-out"></i></a>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </nav>
</div>
<script>
$('#notificationButton').on('click', function(event) {
    event.preventDefault(); // 기본 동작(데이터 제출) 막기
    updateAlarmList();
});

function updateAlarmList() {
    $.ajax({
        url: "/getalarmlist", // 서버에서 알림 목록을 가져올 URL
        type: "GET",
        success: function(data) {
            $('#alarm').html(data); // 서버에서 받은 JSP 내용을 삽입
        },
        error: function(xhr, status, error) {
            console.error("Error updating alarm list:", error);
        }
    });
}
</script>
 <script>
 var isFirstModalPassed = false;

$(document).ready(function() {
	
    $('.profilepw').on('click', function(event) {
        event.preventDefault();
        $('#inputpw').val('');
        $('#myprofilepwModal').modal('show');
    });
    
    
    $('.mypro').on('click', function(event) {
        event.preventDefault();
        $.ajax({
            url: '/myprofile' ,
            method: 'GET',
            success: function(data) {
                $('#modalprofileContents').html(data);
                $('#profileModal').modal('show');
            },
        });
    });
    
     $('.pwForm').on('click', function(event) {
         event.preventDefault();
         var inputpw = document.getElementById('inputpw').value; 
         if (inputpw.length != 0) {
         $.ajax({
             url: '/myprofilepw',
             type: 'POST',
             data: { inputpw: inputpw },
             success: function(response) {
                 if (response === 'success') {
                     $.ajax({
                         url: '/myprofilechange', 
                         type: 'GET',
                         success: function(data) {
                             $('#myprofilepwModal').modal('hide');
                             $('#profileModal').modal('hide');
                             $('#myprofilepwModal').one('hidden.bs.modal', function () {
                                 $('#modalchangeContents').html(data);
                                 $('#changeprofileModal').modal('show');
                             });
                         },
                         error: function() {
                             alert('콘텐츠를 불러오는 데 실패했습니다.');
                         }
                     });
                 } else {
                     alert('비밀번호가 틀렸습니다.');
                 }
             },
             error: function() {
                 alert('서버에 오류가 발생했습니다.');
             }
         });
         }
         else {
        	 alert ("비밀번호를 입력해주세요");
         }
     });

   $('#myprofilepwModal').on('hidden.bs.modal', function () {
         if (isFirstModalPassed) {
             $('#profileModal').modal('show');
         }
         isFirstModalPassed = false;
     });

     $('#profileModal').on('hidden.bs.modal', function () {
         isFirstModalPassed = false;
     });





     

 });
 </script>
 
 <script>
 $(document).ready(function() {
 $('.cpw').on('click', function(event) {
	    event.preventDefault();
	  

	    var cpw1 = document.getElementById('cpw1').value; 
	    var cpw2 = document.getElementById('cpw2').value;
	    var cpw3 = document.getElementById('cpw3').value;
	    if ((cpw1.length >= 6 && cpw1.length <= 15) && (cpw2.length >= 6 && cpw2.length <= 15) && (cpw3.length >= 6 && cpw3.length <= 15)) {
	        if (cpw2 === cpw3) {
	            $.ajax({
	                url: '/changepw',
	                type: 'POST',
	                data: { 
	                    cpw1: cpw1,
	                    cpw2: cpw2,
	                    cpw3: cpw3
	                },
	                success: function(response) {
	                    if (response === "success") {
	                        alert('비밀번호가 성공적으로 변경되었습니다.');
	                        $('#pwcModal').modal('hide');
	                        window.location.reload();
	                    } else {
	                        alert('현재 비밀번호를 다시 확인해주세요.');
	                    }
	                },
	                error: function() {
	                    alert('서버에 오류가 발생했습니다.');
	                }
	            });
	        } else {
	            alert('중복 비밀번호를 다시 확인해주세요.');
	        }
	    } else {
	        alert('비밀번호를 6~15자리로 입력해주세요.');
	    }

	});
 

	});

     $('.pwc').on('click', function(event) {
         event.preventDefault();
         $('#cpw1').val('');
         $('#cpw2').val('');
         $('#cpw3').val('');
         $('#pwcModal').modal('show');
     });
     
</script>
<script>
$(document).ready(function() {
    $('.changemyprofile').on('click', function(event) {
        event.preventDefault();
        var chemail = document.getElementById('email').value; 
        var chadr = document.getElementById('adress').value; 
        var chp1 = document.getElementById('p1').value; 
        var chp2 = document.getElementById('p2').value; 
        var chp3 = document.getElementById('p3').value;
        var chp0 = chp1 + "-" + chp2 + "-" + chp3;
       
        var chctel = document.getElementById('ctel').value;
        
        $.ajax({
            url: '/updateprofile',
            type: 'POST',
            data: { 
                chemail: chemail,
                chadr: chadr,
                chp0: chp0,
                chctel: chctel
            },
            success: function(response) {
                if (response === "success") {
                    $('#changeprofileModal').modal('hide');
                    alert("수정 완료");
                    location.reload();
                } 
            },
            error: function() {
                alert('서버에 오류가 발생했습니다.');
            }
        });
    });
});

</script>

            <div class="modal fade" id="pwcModal" tabindex="-1" aria-labelledby="pwcModalLabel" aria-hidden="true">
    <div class="modal-dialog  modal-dialog-centered" >
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="pwcModalLabel">비밀번호 변경</h5>
                <button type="button" class="close pwc" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body" id="pwcModal">
			        <table class="pwctable">
			    <tr>
			        <td class ="pwctd">
			            <label for="cpw1" class="pwclabel">현재 비밀번호:</label>
			            <input class = "pwcinput" type="password" placeholder="현재 비밀번호 입력" name="cpw1" id="cpw1" style="margin-bottom: 10px;"/>
			        </td>
			    </tr>
			    <tr>
			       <td class ="pwctd">
			            <label for="cpw2" class="pwclabel">새 비밀번호:</label>
			            <input class = "pwcinput" type="password" placeholder="비밀번호 입력" name="cpw2" id="cpw2" style="margin-bottom: 10px;"/>
			        </td>
			    </tr>
			    <tr>
			        <td class ="pwctd">
			            <label for="cpw3" class="pwclabel">새 비밀번호 재확인:</label>
			            <input   class = "pwcinput" type="password" placeholder="비밀번호 재확인 입력" name="cpw3" id="cpw3"/>
			        </td>
			    </tr>
			</table>
            </div>
            <div class="modal-footer">
                 <button type="submit" class="btn btn-success cpw" >수정 하기</button>
            </div>
        </div>
    </div>
</div>


    <div class="modal fade" id="changeprofileModal" tabindex="-1" role="dialog" aria-labelledby="profileModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered custom-modal-size2">
            <div class="modal-content" >
                <div class="modal-header">
                    <h5 class="modal-title" id="changeModalLabel">내 정보 수정</h5>
                    <button type="button" class="close profile" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body" id = "modalchangeContents" >
                </div>
                <div class="modal-footer">
                <button type="submit" class="btn btn-success changemyprofile"  data-url="">수정 완료</button>
                </div>
            </div>
        </div>
    </div>
        <div class="modal fade" id="profileModal" tabindex="-1" role="dialog" aria-labelledby="profileModalLabel" aria-hidden="true" >
        <div class="modal-dialog modal-dialog-centered custom-modal-size2">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="profileModalLabel">내 정보</h5>
                    <button type="button" class="close profile" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body" id = "modalprofileContents"  >
                </div>
                <div class="modal-footer">
                <button type="submit" class="btn btn-success profilepw">수정 하기</button>
                </div>
            </div>
        </div>
    </div>
    
                <div class="modal fade" id="myprofilepwModal" tabindex="-1" aria-labelledby="empolyModalLabel" aria-hidden="true">
    <div class="modal-dialog  modal-dialog-centered" style="width: 300px;" >
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="myprofilepwModalLabel">본인 확인</h5>
              <button type="button" class="close myprofile" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body" id="modalContentmyprofilepw">
            <div style="text-align: center;">
    		 <input type="password" placeholder="비밀번호 입력" name="inputpw" id="inputpw" >
    		 </div>
            </div>
            <div class="modal-footer">
                <button type="submit" class="btn btn-success pwForm">전송</button>
            </div>
            
        </div>
    </div>
</div>
<div class="modal fade" id="gowModal" tabindex="-1" role="dialog" aria-labelledby="gowModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="gowModalLabel">퇴근 하기</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        정말 퇴근 하시겠습니까 ?
      </div>
      <div class="modal-footer">
      	<button type="button" class="btn btn-primary" onclick = "location.href = '/gtw?empno=${id}'" >퇴근 하기</button>
       	<button type="button" class="btn btn-secondary" data-dismiss="modal">취소하기</button>
      </div>
    </div>
  </div>
</div>
</body>
</html>