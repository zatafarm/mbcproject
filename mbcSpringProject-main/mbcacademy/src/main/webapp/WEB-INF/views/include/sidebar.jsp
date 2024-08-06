<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
 <%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
   <head>
       <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
      <meta charset="UTF-8">
<style>    
 .clickable-text {
        cursor: pointer; 
        text-decoration: underline;
 }
 .modal-dialog {
    display: flex;
    align-items: center; /* 세로 중앙 정렬 */
    min-height: calc(100% - (.5rem * 2)); /* 상단 및 하단 여백 조정 */
}

.modal {
    overflow-y: auto;
}

.custom-modal-size {
    width: 800px;
    max-width: 800px;
    height: 600px;
    max-height: 600px;
}
 
</style>
   </head>
   <body>
       <%
        String timestamp = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()); // 현재 시간을 포맷팅합니다.
    %>

            <div class="modal fade" id="empolyModal" tabindex="-1" aria-labelledby="empolyModalLabel" aria-hidden="true">
    <div class="modal-dialog  modal-dialog-centered custom-modal-size" >
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="empolyModalLabel">사원 검색</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body" id="modalContent">
            
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
            </div>
        </div>
    </div>
</div>
<script>

$(document).ready(function() {
    $('.clickable-text').on('click', function(event) {
        event.preventDefault();
        var url = $(this).data('url');
        $.ajax({
            url: url,
            method: 'GET',
            success: function(data) {
                $('#modalContent').html(data);
                $('#empolyModal').modal({
                    keyboard: false    // Esc 키로 닫힘 방지
                });
            },
            error: function(jqXHR, textStatus, errorThrown) {
                console.error("AJAX 요청 실패: ", textStatus, errorThrown);
            }
        });
    });
});

 </script>
       <nav id="sidebar">
         <div class="sidebar_blog_1">
            <div class="sidebar-header">
               <div class="logo_section">
                  <a href="index.html"><img class="logo_icon img-responsive" src="/resources/bootstrap/images/logo/logo_icon.png" alt="#" /></a>
               </div>
            </div>
            <div class="sidebar_user_info">
               <div class="icon_setting"></div>
               <div class="user_profle_side">
                  <div class="user_img"><img class="img-responsive" src="/resources/emp_pic/pic_${id}.jpg?<%= timestamp %>" alt="#" /></div>
                  <div class="user_info">
                     <h6>${user}</h6>
                  <p><span class="online_animation"></span> Online</p>
                  </div>
               </div>
            </div>
         </div>
      		<div class="sidebar_blog_2">
			<h4>Mbc Academy</h4>
			<ul class="list-unstyled components">
				<c:if test="${admns != '1' }">
					<li><a class="clickable-text" data-url="/empolylist"><i
							class="fa fa-search white_color"></i> <span>사원 검색</span></a></li>
						<c:if test="${admns != '0' }">
							<li><a href="#employ_setting_page" data-toggle="collapse"
								aria-expanded="false" class="dropdown-toggle"><i
									class="fa fa-user white_color"></i><span>사원 관리</span></a>
								<ul class="collapse list-unstyled" id="employ_setting_page">
									<li><a href="${contextPath}/empChnApply"><span>정정 신청</span></a></li>
									<li><a href="${contextPath}/empChnList"><span>신청 내역</span></a></li>
								</ul></li>
						</c:if>
					<li class="active"><a href="#additional_page"
						data-toggle="collapse" aria-expanded="false"
						class="dropdown-toggle"><i
							class="fa fa-paper-plane blue1_color"></i><span>휴가 관리</span></a>
						<ul class="collapse list-unstyled" id="additional_page">
							<li><a href="${contextPath}/ptoApply"><span>휴가 신청</span></a></li>
							<li><a href="${contextPath}/ptoList"><span>휴가
										내역</span></a></li>
							<c:if test="${admns != '0' }">
								<li><a href="${contextPath}/aprvList"><span>휴가
											승인</span></a></li>
							</c:if>
						</ul></li>
					<li><a href="#board_page" data-toggle="collapse"
						aria-expanded="false" class="dropdown-toggle"><i
							class="fa fa-table orange_color"></i><span>커뮤니티</span></a>
						<ul class="collapse list-unstyled" id="board_page">
							<li><a href="${contextPath}/aumlist"><span>공지사항</span></a></li>
							<li><a href="${contextPath}/list"><span>사내 게시판</span></a></li>
							<li><a href="${contextPath}/mylist"><span>내 글 보기</span></a></li>
						</ul></li>
				</c:if>
				<c:if test="${admns == '1' }">
					<li><a aria-expanded="false"><i
							class="fa fa-cogs yellow_color"></i><span>관리자</span></a>
						<ul id="setting_page">
							<li><a href="#employ_setting_page" data-toggle="collapse"
								aria-expanded="false" class="dropdown-toggle"><i
									class="fa fa-user white_color"></i><span>사원 관리</span></a>
								<ul class="collapse list-unstyled" id="employ_setting_page">
									<li><a href="/signUp"><span>사원 등록</span></a></li>
									<li><a href="/adminempolylist"><span>사원 정보 관리</span></a></li>
									<li><a href="/admintimeset"><span>출퇴근 시간 설정</span></a></li>
									<li><a href="/empChnList"><span>정보 변경 요청 내역</span></a></li>
								</ul></li>
							<li><a href="#board_setting_page" data-toggle="collapse"
								aria-expanded="false" class="dropdown-toggle"><i
									class="fa fa-table white_color"></i><span>게시판 관리</span></a>
								<ul class="collapse list-unstyled" id="board_setting_page">
									<li><a href="${contextPath}/aumlist"><span>공지사항 관리</span></a></li>
									<li><a href="${contextPath}/list"><span>게시판 관리</span></a></li>
								</ul></li>
						</ul></li>
				</c:if>
			</ul>
		</div>
	</nav>
      
      
      <!-- end sidebar -->

   
   </body>
</html>