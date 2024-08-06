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
<title>직원 상세 정보</title>
<style type="text/css">
.detail_form {
        display: flex;
        justify-content: center;
        align-items: center;
        margin: auto;
        padding: 20px;
        max-width: 700px;
}

.detail_form form {
	float: left;
	width: 100%;
}

.detail_form form .field label.label_field {
	margin: 0 30px 0 0;
	width: 115px;
	line-height: 45px;
	text-align: right;
	height: 45px;
	font-weight: 300;
	font-size: 15px;
}

.detail_form form .adrField label.label_field {
	margin: 0 30px 0 0;
	width: 115px;
	line-height: 45px;
	text-align: right;
	height: 45px;
	font-weight: 300;
	font-size: 15px;
}

.detail_form form .field {
	display: flex;
	margin: 0 0 20px;
	align-items: center;
}

.detail_form form .field input[type="text"],
.detail_form form .field input[type="email"] {
	border-top: none;
	border-left: none;
	border-right: none;
	border-bottom: solid #ddd 2px;
	width: 395px;
	padding: 10px;
	line-height: normal;
	font-weight: 300;
	transition: ease all 0.5s;
}

.detail_form form .field select {
	border-top: none;
	border-left: none;
	border-right: none;
	border-bottom: solid #ddd 2px;
	width: 395px;
	padding: 10px;
	line-height: normal;
	font-weight: 300;
	transition: ease all 0.5s;
}

.detail_form form .field input:hover, .login_form form .field input:focus
	{
	box-shadow: none;
}

.detail_form .field label.form-check-label .form-check-input {
	width: auto;
}

.hidden {
	visibility: hidden;
}

.detail_form .field label.form-check-label {
	margin-left: 20px;
	position: relative;
	top: 0;
}

.forgot {
	float: right;
	margin: 11px 0;
	position: relative;
	left: 0;
	color: #ff5722;
}

.photo-container {
	width: 100px; /* 증명 사진 크기에 맞게 조절하세요 */
	height: 150px; /* 증명 사진 크기에 맞게 조절하세요 */
	border: 1px solid #ccc; /* 네모 상자의 테두리 */
}

.photo-placeholder {
	width: 100%;
	height: 100%;
	background-color: #ececec; /* 네모 상자의 배경색 */
}

.photo-placeholder img {
	width: 100%;
	height: 100%;
	object-fit: cover;
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
								<div class="page_title">
									<h2>직원 상세 정보</h2>
								</div>
							</div>
						</div>
						<!-- row -->
						<div class="row column1">
							<div class="col-md-12">
								<div class="white_shd full margin_bottom_30">
									<div class="full price_table padding_infor_info">
										<div class="row">
											<div class="col-lg-12">
												<div class="detail_form">
													<form action="/aempolychange" method="post" enctype="multipart/form-data">
														<fieldset>
															<div class="field">
																<label class="label_field">사원 사진</label>
																<div class="photo-container" style= "margin-left: 130px;">
																	<div class="photo-placeholder">
																		<img src="" alt="사진" id = "emppic">
																	</div>
																	<br>
																</div>
															</div>
															<br><br>
															<div class="field">
																<label class="label_field">입사일자</label> <input type="text"
																	name="hrdt" id="hrdt" value="<c:out value="${emp.hrdt}" />"
																	readonly />
															</div>
															<div class="field">
																<label class="label_field">사번</label> <input type="text"
																	name="empno" id="empno" value="<c:out value='${emp.empno}'/>" readonly/>
															</div>
															<div class="field">
																<label class="label_field">이름</label> <input type="text"
																	name="ename" id="ename" value="<c:out value='${emp.ename}'/>" readonly/>
															</div>
															<div class="field">
																<label class="label_field">생년월일</label> <input type="text"
																	name="bri" id="bri" value="<c:out value='${emp.bri}'/>" readonly/>
															</div>
															<div class="field">
																<label class="label_field">휴대전화번호</label> <input type="text"
																	name="tel" id="tel" value="<c:out value='${emp.tel}'/>" maxlength="13" readonly/>
															</div>
															<div class="field">
																<label class="label_field">내선번호</label> <input type="text"
																	name="ctel" id="ctel" value="<c:out value='${emp.ctel}'/>" maxlength="4" readonly/>
															</div>
															<div class="field">
																<label class="label_field">이메일</label> <input type="email"
																	name="email" id="email" value="<c:out value='${emp.email}'/>" readonly/>
															</div>
															<div class="field">
																<label class="label_field">주소</label> <input type="text"
																	name="dftAdr" id="dftAdr" value="<c:out value='${emp.adr1}'/>" readonly="readonly" />&nbsp;&nbsp;
															</div>
															<div class="field">
																<label class="label_field"></label> <input type="text"
																	name="dtlAdr" id="dtlAdr" value="<c:out value='${emp.adr2}'/>" readonly/>
															</div>
															<div class="field">
																<label class="label_field"></label> <input type="text"
																	name="etrAdr" id="etrAdr"  value="<c:out value='${emp.adr3}'/>" readonly="readonly" />
															</div>
															<div id="wrap" style="display:none;border:1px solid;width:500px;height:300px;margin:5px 0;position:relative">
																<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnFoldWrap" style="cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1" onclick="foldDaumPostcode()" alt="접기 버튼">
															</div>
															
															<!-- ADR를 저장하기 위한 hidden 필드 추가 -->
															<input type="hidden" name="adr" id="adr" />
															<div class="field">
																<label class="label_field">부서</label> <select name="dept"
																	id="dept" disabled>
																	<option selected="selected" ></option>
																	<option value="E0" ${emp.codenm == '경영지원팀' ? 'selected' : ''}>경영지원팀</option>
																	<option value="E1" ${emp.codenm == '인사팀' ? 'selected' : ''}>인사팀</option>
																	<option value="E2" ${emp.codenm == '재무팀' ? 'selected' : ''}>재무팀</option>
																	<option value="E3" ${emp.codenm == '영업팀' ? 'selected' : ''}>영업팀</option>
																	<option value="E4" ${emp.codenm == '마케팅팀' ? 'selected' : ''}>마케팅팀</option>
																</select>
															</div>
															<div class="field">
																<label class="label_field">직급</label>
																<select name="ranks" id="ranks" disabled>
																	<option value="사원" ${emp.ranks == '사원' ? 'selected' : ''}>사원</option>
																	<option value="대리" ${emp.ranks == '대리' ? 'selected' : ''}>대리</option>
																	<option value="과장" ${emp.ranks == '과장' ? 'selected' : ''}>과장</option>
																	<option value="차장" ${emp.ranks == '차장' ? 'selected' : ''}>차장</option>
																	<option value="부장" ${emp.ranks == '부장' ? 'selected' : ''}>부장</option>
																	<option value="이사" ${emp.ranks == '이사' ? 'selected' : ''}>이사</option>
																	<option value="대표" ${emp.ranks == '대표' ? 'selected' : ''}>대표</option>
																</select>
															</div>
															<div class="field">
																<label class="label_field">직책</label> <select name="pstn"
																	id="pstn" disabled>
																	<option selected="selected" >선택하여주세요</option>
																	<option value="2" ${emp.pstn == '팀원' ? 'selected' : ''}>팀원</option>
																	<option value="1" ${emp.pstn == '팀장' ? 'selected' : ''}>팀장</option>
																	<option value="0" ${emp.pstn == '총책임자' ? 'selected' : ''}>총책</option>
																</select>
															</div>
																<div class="field">
																<label class="label_field">기본급</label> <input type="text"
																	name="sal" id="sal" value="<c:out value='${emp.fmtSal}'/>" readonly/>
															</div>
															<div class="field">
																<label class="label_field">관리권한</label> <select
																	name="admns" id="admns" disabled>
																	<option selected="selected" >선택하여주세요</option>
																	<option value="0" ${emp.admns == '0' ? 'selected' : ''}>권한없음</option>
																	<option value="3" ${emp.admns == '3' ? 'selected' : ''}>소속팀원관리</option>
																	<option value="2" ${emp.admns == '2' ? 'selected' : ''}>전직원관리</option>
																</select>
															</div>
															<div class="field margin_0">
																<label class="label_field hidden">hidden label</label>
																<button class="btn btn-success " type="submit">수정</button>&nbsp;&nbsp;&nbsp;
																<button class="btn btn-danger delete" type="button" data-toggle="modal" data-target="#deleteModal">삭제</button>
																<button type="button" class="btn btn-info" onclick="location.href='/adminempolylist'" style ="margin-left:10px;">목록</button>
															</div>
														</fieldset>
													</form>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
							<!-- end row -->
						</div>
					</div>
					<!-- end dashboard inner -->
				</div>
				<!-- footer -->
				<jsp:include page='/WEB-INF/views/include/footer.jsp' />
			</div>
		</div>
	</div>
	<!-- Modal -->
	<div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="deleteModalLabel">사원 삭제</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	        해당 사원 정보를 정말 삭제하시겠습니까?
	      </div>
	      <div class="modal-footer">
	      	<button type="button" class="btn btn-danger" onclick = "location.href = '/deleteempoly?empno=${emp.empno}'" >삭제</button>
	       	<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script type="text/javascript">		
	//직원 번호(empno) 설정
	var empno = "<%= request.getParameter("empno") %>";
	// 이미지를 업데이트하는 함수
	function updateEmployeeImage() {
	    var timestamp = new Date().getTime(); // 현재 시간의 타임스탬프를 생성
	    var imagePath = "/resources/emp_pic/pic_" + empno + ".jpg?timestamp=" + timestamp; // 고유 파라미터를 포함한 이미지 경로 생성
	    // 이미지의 src 속성을 새 경로로 업데이트
	    document.getElementById('emppic').src = imagePath;
	}
	
	
	window.onload = function() {
	
	    updateEmployeeImage();
	};
	</script>
</body>
</html>