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
<title>직원 등록</title>
<style type="text/css">
.signUp_form {
        display: flex;
        justify-content: center;
        align-items: center;
        margin: auto;
        padding: 20px;
        max-width: 700px;
}

.signUp_form form {
	float: left;
	width: 100%;
}

.signUp_form form .field label.label_field {
	margin: 0 30px 0 0;
	width: 115px;
	line-height: 45px;
	text-align: right;
	height: 45px;
	font-weight: 300;
	font-size: 15px;
}

.signUp_form form .adrField label.label_field {
	margin: 0 30px 0 0;
	width: 115px;
	line-height: 45px;
	text-align: right;
	height: 45px;
	font-weight: 300;
	font-size: 15px;
}

.signUp_form form .field {
	display: flex;
	margin: 0 0 20px;
	align-items: center;
}

.signUp_form form .field input[type="text"],
.signUp_form form .field input[type="email"] {
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

.signUp_form form .field select {
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

.signUp_form form .field input:hover, .login_form form .field input:focus
	{
	box-shadow: none;
}

.signUp_form .field label.form-check-label .form-check-input {
	width: auto;
}

.hidden {
	visibility: hidden;
}

.signUp_form .field label.form-check-label {
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
									<h2>직원등록</h2>
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
												<div class="signUp_form">
													<form action="/signUp" method="post" enctype="multipart/form-data">
														<fieldset>
															<div class="field">
																<label class="label_field">사진업로드</label>
																<div class="photo-container">
																	<c:if test="${empty photo}">
																		<div class="photo-placeholder"></div>
																	</c:if>
																	<c:if test="${not empty photo}">
																		<div class="photo-placeholder">
																			<img src="data:image/jpeg;base64,${photo}" alt="사진">
																		</div>
																	</c:if>
																	<br>
																	<input type="file" id="photo" name="photo" accept="image/*" readonly>
																</div>
															</div>
															<br><br>
															<div class="field">
																<label class="label_field">입사일자</label> <input type="text"
																	name="hrdt" id="hrdt" placeholder="날짜를 선택해주세요"
																	readonly/>
															</div>
															<div class="field">
																<label class="label_field">사번</label> <input type="text"
																	name="empno" id="empno" placeholder="입사일자를 입력하시면 자동생성됩니다." readonly />
															</div>
															<div class="field">
																<label class="label_field">이름</label> <input type="text"
																	name="ename" id="ename" placeholder="이름을 입력하세요" />
															</div>
															<div class="field">
																<label class="label_field">생년월일</label> <input type="text"
																	name="bri" id="bri" placeholder="날짜를 선택해주세요" readonly/>
															</div>
															<div class="field">
																<label class="label_field">휴대전화번호</label> <input type="text"
																	name="tel" id="tel" placeholder="010-0000-0000" maxlength="13" />
															</div>
															<div class="field">
																<label class="label_field">내선번호</label> <input type="text"
																	name="ctel" id="ctel" placeholder="내선번호 4자리를 입력하세요" maxlength="4" />
															</div>
															<div class="field">
																<label class="label_field">이메일</label> <input type="email"
																	name="email" id="email" placeholder="mbc@mbc.com" />
															</div>
															<div class="field">
																<label class="label_field">주소</label> <input type="text"
																	name="dftAdr" id="dftAdr" placeholder="주소를 입력하세요" readonly/>&nbsp;&nbsp;
																<button type="button" class="btn cur-p btn-info" onclick="sample3_execDaumPostcode()">주소검색</button>
															</div>
															<div class="field">
																<label class="label_field"></label> <input type="text"
																	name="dtlAdr" id="dtlAdr" placeholder="상세주소를 입력하세요" />
															</div>
															<div class="field">
																<label class="label_field"></label> <input type="text"
																	name="etrAdr" id="etrAdr" placeholder="주소 참고항목" readonly/>
															</div>
															<div id="wrap" style="display:none;border:1px solid;width:500px;height:300px;margin:5px 0;position:relative">
																<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnFoldWrap" style="cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1" onclick="foldDaumPostcode()" alt="접기 버튼">
															</div>
															<!-- ADR를 저장하기 위한 hidden 필드 추가 -->
															<input type="hidden" name="adr" id="adr" />
															<div class="field">
																<label class="label_field">부서</label> <select name="dept"
																	id="dept">
																	<option selected="selected">선택하여주세요</option>
																	<option value="E0">경영지원팀</option>
																	<option value="E1">인사팀</option>
																	<option value="E2">재무팀</option>
																	<option value="E3">영업팀</option>
																	<option value="E4">마케팅팀</option>
																</select>
															</div>
															<div class="field">
																<label class="label_field">직급</label> <select name="ranks"
																	id="ranks">
																	<option selected="selected">선택하여주세요</option>
																	<option value="사원">사원</option>
																	<option value="대리">대리</option>
																	<option value="과장">과장</option>
																	<option value="차장">차장</option>
																	<option value="부장">부장</option>
																	<option value="이사">이사</option>
																	<option value="대표">대표</option>
																</select>
															</div>
															<div class="field">
																<label class="label_field">직책</label> <select name="pstn"
																	id="pstn">
																	<option selected="selected">선택하여주세요</option>
																	<option value="2">팀원</option>
																	<option value="1">팀장</option>
																	<option value="0">총책</option>
																</select>
															</div>
															<div class="field">
																<label class="label_field">연차부여</label> <input type="text"
																	name="pto" id="pto" placeholder="부여한 연차를 입력하여 주세요" />
															</div>
															<div class="field">
																<label class="label_field">기본급</label> <input type="text"
																	name="sal" id="sal" placeholder="협의된 기본급을 입력하여 주세요" />
															</div>
															<div class="field">
																<label class="label_field">관리권한</label> <select
																	name="admns" id="admns">
																	<option selected="selected">선택하여주세요</option>
																	<option value="0">권한없음</option>
																	<option value="3">소속팀원관리</option>
																	<option value="2">전직원관리</option>
																</select>
															</div>
															<div class="field margin_0">
																<label class="label_field hidden">hidden label</label>
																<button class="btn btn-success" type="submit">등록완료</button>&nbsp;&nbsp;&nbsp;
																<button class="btn btn-info" type="button" onclick="location.href='main'">취소</button>
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
	<!-- signUp script -->
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script type="text/javascript">		
		$(function() {
			$("#hrdt").datepicker({
				dateFormat : 'yy-mm-dd',
				showOtherMonths : true,
				showMonthAfterYear : true,
				changeYear : true,
				changeMonth : true,
				showOn : "both",
				buttonImage : "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif",
				buttonImageOnly : true,
				buttonText : "선택",
				yearSuffix : "년",
				monthNamesShort : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월' ],
				monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월' ],
				dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ],
				dayNames : [ '일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일' ],
				yearRange : '1900:' + (new Date().getFullYear() + 1),
				onSelect: function(dateText, inst) {
					//사번 자동생성 로직
					let year = dateText.split('-')[0];
					$.ajax({
						url: '/atGnrEmpno',
						type: 'GET',
						data: { year: year },
						success: function(data) {
							 $('#empno').val(data);
						}
					});
					// 이름 입력 필드로 포커스를 이동
					$('#ename').focus();
				}
			});
			$("#bri").datepicker({
				dateFormat : 'yy-mm-dd',
				showOtherMonths : true,
				showMonthAfterYear : true,
				changeYear : true,
				changeMonth : true,
				showOn : "both",
				buttonImage : "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif",
				buttonImageOnly : true,
				buttonText : "선택",
				yearSuffix : "년",
				monthNamesShort : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월' ],
				monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월' ],
				dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ],
				dayNames : [ '일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일' ],
				yearRange : '1900:' + (new Date().getFullYear() + 1),
				onSelect: function() {
					// 휴대전화 입력 필드로 포커스를 이동
					$('#tel').focus();
				}
			});
		});
		
		// tel 필드에 숫자가 아닌 값 입력 방지 및 "-" 추가
		const hypenTel = (target) => {
			target.value = target.value
				.replace(/[^0-9]/g, '')
				.replace(/^(\d{2,3})(\d{3,4})(\d{4})$/, `$1-$2-$3`);
		};
		
		document.addEventListener('DOMContentLoaded', () => {
			const tel = document.querySelector('#tel');
			tel.addEventListener('input', (event) => {
				hypenTel(event.target);
			});
		});
		
		// CTEL 필드에 숫자가 아닌 값 입력 방지
		document.getElementById('ctel').addEventListener('input', function() {
			let cTel = this.value;
			// 입력된 값이 숫자가 아닌 경우
			if (isNaN(cTel)) {
				// 입력값을 초기화하여 숫자만 입력되도록 함
				this.value = '';
			}
		});
		
		// PTO 필드에 숫자가 아닌 값 입력 방지
		document.getElementById('pto').addEventListener('input', function() {
			let pto = this.value;
			// 입력된 값이 숫자가 아닌 경우
			if (isNaN(pto)) {
				// 입력값을 초기화하여 숫자만 입력되도록 함
				this.value = '';
			}
		});
		
		// SAL 필드에 숫자가 아닌 값 입력 방지 및 천 단위 구분 기호 추가 
		document.getElementById('sal').addEventListener('input', function() {
			let crn = this.value;
			// 숫자 이외의 모든 문자 제거
			let num = crn.replace(/[^0-9]/g, '');
			// 숫자를 천 단위 구분 기호로 포맷팅
			let adth = num.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
			
			// 입력된 값 업데이트
			this.value = adth;
		});
		
		// 폼 제출 시 SAL 필드의 천 단위 구분 기호 제거
		document.querySelector('form').addEventListener('submit', function() {
			let sal = document.getElementById('sal');
			// 천 단위 구분 기호 제거
			let rmvt = sal.value.replace(/,/g, '');
			// 제거된 값으로 SAL 필드 업데이트
			sal.value = rmvt;
		});
		
		// 우편번호 찾기 찾기 화면을 넣을 element
		let element_wrap = document.getElementById('wrap');
		
		function foldDaumPostcode() {
			// iframe을 넣은 element를 안보이게 한다.
			element_wrap.style.display = 'none';
		}
		
		//DaumAPI
		function sample3_execDaumPostcode() {
			// 현재 scroll 위치를 저장해놓는다.
			let currentScroll = Math.max(document.body.scrollTop, document.documentElement.scrollTop);
			new daum.Postcode({
				oncomplete: function(data) {
					// 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
					// 각 주소의 노출 규칙에 따라 주소를 조합한다.
					// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
					let dftAdr = ''; // 주소 변수
					let etrAdr = ''; // 참고항목 변수
					
					//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
					if (data.userSelectedType === 'R') {
						dftAdr = data.roadAddress;
					} else { // 사용자가 지번 주소를 선택했을 경우(J)
						dftAdr = data.jibunAddress;
					}
					
					// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
					if(data.userSelectedType === 'R'){
						 // 법정동명이 있을 경우 추가한다. (법정리는 제외)
						 // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
						if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
							etrAdr += data.bname;
						}
						// 건물명이 있고, 공동주택일 경우 추가한다.
						if(data.buildingName !== '' && data.apartment === 'Y') {
							etrAdr += (etrAdr !== '' ? ', ' + data.buildingName : data.buildingName);
						}
						// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
						if(etrAdr !== ''){
							etrAdr = ' (' + etrAdr + ')';
						}
						// 조합된 참고항목을 해당 필드에 넣는다.
						document.getElementById("etrAdr").value = etrAdr;
					} else {
						document.getElementById("etrAdr").value = '';
					}
					
					// 우편번호와 주소 정보를 해당 필드에 넣는다.
					document.getElementById("dftAdr").value = dftAdr;
					// 커서를 상세주소 필드로 이동한다.
					document.getElementById("dtlAdr").focus();
					
					// iframe을 넣은 element를 안보이게 한다.
					// (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
					element_wrap.style.display = 'none';
					
					// 우편번호 찾기 화면이 보이기 이전으로 scroll 위치를 되돌린다.
					document.body.scrollTop = currentScroll;
				},
				// 우편번호 찾기 화면 크기가 조정되었을때 실행할 코드를 작성하는 부분. iframe을 넣은 element의 높이값을 조정한다.
				onresize : function(size) {
					element_wrap.style.height = size.height+'px';
				},
				width : '100%',
				height : '100%'
			}).embed(element_wrap);
			
			// iframe을 넣은 element를 보이게 한다.
			element_wrap.style.display = 'block';
		}
		
		// 이미지 리사이즈 함수
		function resizeImage(file, maxWidth, maxHeight, callback) {
			const reader = new FileReader();
			reader.onload = function(event) {
				const img = new Image();
				img.onload = function() {
					let width = img.width;
					let height = img.height;
					
					// 이미지의 측면 비율 유지하면서 크기를 조정
					 if (width > maxWidth || height > maxHeight) {
						 const ratio = Math.min(maxWidth / width, maxHeight / height);
						 width *= ratio;
						 height *= ratio;
					 }
					
					const canvas = document.createElement('canvas');
					canvas.width = width;
					canvas.height = height;
					const ctx = canvas.getContext('2d');
					ctx.drawImage(img, 0, 0, width, height);
					
					// 캔버스 이미지를 base64 문자열로 변환하여 콜백 함수로 전달
					callback(canvas.toDataURL(file.type));
				};
				img.src = event.target.result;
			};
			reader.readAsDataURL(file);
		}
		
		// 파일 선택 시 이미지 리사이즈 후 sessionStorage에 저장
		document.getElementById('photo').addEventListener('change', function(event) {
			const file = event.target.files[0];
			if (file) {
				resizeImage(file, 100, 150, function(resizedImageData) {
					sessionStorage.setItem('photo', resizedImageData);
					const photoPlaceholder = document.querySelector('.photo-placeholder');
					// 이미지 요소를 생성하여 src 속성을 설정하고 삽입합니다.
					const img = document.createElement('img');
					img.src = resizedImageData;
					img.alt = "사진";
					// 기존 내용을 모두 지우고 이미지 요소를 삽입합니다.
					photoPlaceholder.innerHTML = '';
					photoPlaceholder.appendChild(img);
				});
			}	
		});
		
		// form 제출 시 sessionStorage의 이미지 데이터를 hidden input으로 추가
		document.querySelector('form').addEventListener('submit', function(event) {
			const photoData = sessionStorage.getItem('photo');
			if (photoData) {
				const photoInput = document.createElement('input');
				photoInput.type = 'hidden';
				photoInput.name = 'photoData';
				photoInput.value = photoData;
				this.appendChild(photoInput);
			}
			sessionStorage.removeItem('photo');
		});
		
		// 최종 유효성 검사
		document.querySelector('form').addEventListener('submit', function(event) {
			let isValid = true;
			let errMsg = "";
			
			if (document.getElementById('hrdt').value === "") {
				errMsg += "입사일자를 선택하세요.\n";
				isValid = false;
			}
			
			if (document.getElementById('ename').value === "") {
				errMsg += "사원명을 입력하세요.\n";
				isValid = false;
			}
			
			if (document.getElementById('bri').value === "") {
				errMsg += "생년월일을 선택하세요.\n";
				isValid = false;
			}
			
			if (document.getElementById('tel').value === "") {
				errMsg += "휴대전화번호를 입력하세요.\n";
				isValid = false;
			}
			
			if (document.getElementById('ctel').value === "") {
				errMsg += "내선번호를 입력하세요.\n";
				isValid = false;
			}
			
			if (document.getElementById('email').value === "") {
				errMsg += "이메일을 입력하세요.\n";
				isValid = false;
			}
			
			if (document.getElementById('dftAdr').value === "") {
				errMsg += "주소를 입력하세요.\n";
				isValid = false;
			}
			
			if (document.getElementById('dept').value === "선택하여주세요") {
				errMsg += "부서를 선택하세요.\n";
				isValid = false;
			}
			
			if (document.getElementById('ranks').value === "선택하여주세요") {
				errMsg += "직급을 선택하세요.\n";
				isValid = false;
			}
			
			if (document.getElementById('pstn').value === "선택하여주세요") {
				errMsg += "직책을 선택하세요.\n";
				isValid = false;
			}
			
			if (document.getElementById('pto').value === "") {
				errMsg += "부여할 연차를 입력하세요.\n";
				isValid = false;
			}
			
			if (document.getElementById('sal').value === "") {
				errMsg += "협의된 기본급을 입력하세요.\n";
				isValid = false;
			}
			
			if (document.getElementById('admns').value === "선택하여주세요") {
				errMsg += "관리권한을 선택하세요.\n";
				isValid = false;
			}
			
			 if (!isValid) {
				 alert(errMsg);
				 event.preventDefault();
			 } else {
				// dftAdr, dtlAdr, etrAdr 값을 조합하여 ADR 값 생성
				let dftAdr = document.getElementById('dftAdr').value;
				let dtlAdr = document.getElementById('dtlAdr').value;
				let etrAdr = document.getElementById('etrAdr').value;
				let adr = dftAdr + "," + dtlAdr + " " + etrAdr;
				// 생성된 ADR 값을 hidden 필드에 설정
				document.getElementById('adr').value = adr;
			 }
		});
	</script>
</body>
</html>