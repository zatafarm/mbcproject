<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<%@ page session="true"%>

<% String source = request.getParameter("source"); %>
<%
    int bno = Integer.parseInt(request.getParameter("bno"));
%>
<!DOCTYPE html>
<html lang="en">
<head>
<jsp:include page='/WEB-INF/views/include/head.jsp' />
<title>Board Detail</title>
<style>
.input-file-button{
	
  padding: 6px 25px;
  background-color:#8BC34A;
  border-radius: 4px;
  color: white;
  cursor: pointer;
  margin-left:10px;}
.input-file-button2 {
  padding: 6px 25px;
  background-color: #EF5350;
  border-radius: 4px;
  border :0px;
  color: white;
  cursor: pointer;
  margin-left: 10px;
}

.input-file-button3 {
  padding: 6px 25px;
  background-color: #2196F3;
  border-radius: 4px;
  color: white;
  border :0px;
  cursor: pointer;
  margin-left: 10px;
}


.input-file-button4{
	
  padding: 6px 25px;
  background-color:#8BC34A;
  border-radius: 4px;
  color: white;
  border :0px;
  cursor: pointer;
  margin-left:6px;}
  
  .input-file-button5 {
  padding: 6px 25px;
  background-color: #EF5350;
  border-radius: 4px;
  color: white;
  border :0px;
  cursor: pointer;
  margin-left: 6px;
}
  .cntdiv{
    width:700px;
    height:400px;
    border: 1px solid #ccc;
     overflow-y: auto;
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
									<h2>게시글 수정</h2>
									<div>${msg}</div>
								</div>
							</div>
						</div>
						<!-- row -->
						<form id="myForm" action="/update" method="post" enctype="multipart/form-data" autocomplete="off" >
<input type="hidden" id="id" name="id" <c:if test="${not empty board}">value="${board.bno}"</c:if> />

					    <!--/* 서버로 전달할 공지글 여부 */-->
					    <input type="hidden" id="noticeYn" name="noticeYn" />
					    
					    <!--/* 삭제 처리할 파일 번호 */-->
					    <input type="hidden" id="removeFileIds" name="removeFileIds" />						
						<input type="hidden" name="bno" value="${board.bno}">
						<c:if test="${admns == '1'}">
							<input type="hidden" name="source" value="aumlist">
						</c:if>
						<div class="row column1">
							<div class="col-md-12">
								<div class="white_shd full margin_bottom_30">
									<div class="full price_table padding_infor_info">
										<div class="row">
											<div class="col-lg-12">
												<div class="table-responsive-sm">
													<table class="table projects" >
														<tr>
															<th>작성자</th>
															<td>${board.ename}</td>
															<th>작성일자</th>
															<td>${board.regdt}</td>
															<th>수정일자</th>
															<td>${board.udtdt}</td>
														</tr>
														<tr>
															<th>제목</th>
															<td colspan="5" align="left"><input type="text" size="80" name="ttl" placeholder="제목을 입력해주세요." value="${board.ttl}"/>
																<c:if test="${admns == '1'}">
																	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
																	<span style="font-size: 11px; color: red;">중요*&nbsp;&nbsp;
																		<input type="checkbox" name="chk" id="chk" value="1" ${board.chk == '1' ? 'checked' : ''}>
																	</span>
																</c:if>
															</td>
														</tr>
														<tr>
														</tr>
														     <tr>
                                               <th>내용</th>
											  <td colspan="2">
											    <div contentEditable="true" class="cntdiv" id="cntdiv">${board.cnt}</div>
											    <input type="hidden" id="cnt" name="cnt" />
											   
											    <div class="photo-placeholder"></div>
											  </td>
											</tr>
														<tr>
														<th rowspan="9">첨부파일</th>
														<td colspan="3">
									            <div class="file_list">
									                <div>
									                    
									                    </div>
									                </div>
									        </td>
													    </tr>
													</table>
												</div>
											</div>
										</div>
									</div>
									<div class="full price_table padding_infor_info">
										<div class="row">
											<div class="col-lg-12">
												<div class="table-responsive-sm">
													<table class="table projects">
														<tr>
															<td colspan="4" align="center">
																<button type="submit" class="btn btn-success" id = "saveBtn">저장</button>
																<button type="reset" class="btn btn-secondary">초기화</button>
																<button type="button" class="btn btn-info" onclick="location.href='<%= source != null ? source : "dafaultPage" %>'">목록</button>
															</td>
														</tr>
													</table>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						</form>
						<!-- end row -->
					</div>
				</div>
				<!-- end dashboard inner -->
				<!-- footer -->
				<jsp:include page='/WEB-INF/views/include/footer.jsp' />
			</div>
		</div>
	</div>
<script>

function updateValue(checkbox) {
   checkbox.value = checkbox.checked ? 1 : 0;
}

</script>
<script>
async function getJson(url) {
	   try {
	     const response = await fetch(url);
	     if (!response.ok) {
	       throw new Error(`HTTP error ${response.status}`);
	     }
	     return await response.json();
	   } catch (error) {
	     console.error('Error fetching JSON:', error);
	     throw error;
	   }
	 }

window.onload = () => {

    findAllFile();
}

const form = document.getElementById('myForm');
const saveBtn = document.getElementById('saveBtn');

form.addEventListener('submit', function(event) {
    event.preventDefault(); // 기본 폼 제출 동작 막기
    const element = document.getElementById('cntdiv');
    const images = element.getElementsByTagName('img');
    for (let i = 0; i < images.length; i++) {
        var imgtext = images[i].alt;
        images[i].src = imgtext; // 새로운 이미지 경로로 변경
    }

    const element2 = element.innerHTML;
    document.getElementById('cnt').value = element2;
    saveBtn.disabled = true; // 중복 클릭 방지
    form.removeFileIds.value = removeFileId.getAll().join();
    alert(removeFileId.getAll().join());
    form.action = '/update';
    form.submit(); // 폼 제출
});

// 전체 파일 조회
 async function findAllFile() {
    // 1. 신규 등록/수정 체크
    // 2. API 호출
    const response = await getJson(`/api/detail?bno=<%=bno%>`);
    // 3. 로직 종료
    if (!response.length) {
        const fileDiv = document.createElement('div');
        const inputId = 'input-file-' + Math.random().toString(36).substring(2, 7); // 랜덤한 ID 생성
        let html = '<div class="file_input">';
        html += '  <input type="text" readonly />';
        html += '  <label class="input-file-button4" for="' + inputId + '">파일 선택</label>';
        html += '  <input type="file" id="' + inputId + '" name="files" onchange="selectFile(this);" style="display:none;" />';
        html += '  <button type="button" onclick="removeFile(this);" class="input-file-button5"><span>삭제</span></button>';
        html += '<button class="input-file-button3" type="button" onclick="addFile();"><span>파일 추가</span>';
        html += '</div>';

        fileDiv.innerHTML = html;
        document.querySelector('.file_list').appendChild(fileDiv);
        return false;
    }
    


    
    // 4. 업로드 영역 추가
    const fileListDiv = document.querySelector('.file_list');
    for (let i = 0, len = response.length ; i < len; i++) {
        const fileDiv = document.createElement('div');
        fileDiv.classList.add('file_input_wrapper');

        let fileInputHTML = '<div class="file_input">' +
        '<input type="text" value="' + response[i].originalName + '" readonly />' +
        '<label class="input-file-button" for="input-file-' + i + '">' +
            '파일 선택' +
        '</label>' +
        '<input type="file" name="files" id="input-file-' + i + '" onchange="selectFile(this, \'' + response[i].id + '\');" style="display:none;"/>' +
        '<input type="hidden" id=" + response[i].id +" value="' + response[i].id + '">';

    fileInputHTML += '<button class="input-file-button2" type="button" onclick="removeFile(this, \'' + response[i].id + '\');">' +
        '<span>삭제</span>' +
    '</button>';

    if (i === 0) {
        fileInputHTML += '<button class="input-file-button3" type="button" onclick="addFile();">' +
            '<span>파일 추가</span>' +
        '</button>';
    }
    


        fileDiv.innerHTML = fileInputHTML;
        fileListDiv.appendChild(fileDiv);
    }


}
 function resizeImage(file, maxWidth, maxHeight, callback) {
     const img = new Image();
     img.src = URL.createObjectURL(file);
     img.onload = function() {
       let width = img.width;
       let height = img.height;

       if (width > height) {
         if (width > maxWidth) {
           height *= maxWidth / width;
           width = maxWidth;
         }
       } else {
         if (height > maxHeight) {
           width *= maxHeight / height;
           height = maxHeight;
         }
       }

       const canvas = document.createElement('canvas');
       canvas.width = width;
       canvas.height = height;
       const ctx = canvas.getContext('2d');
       ctx.drawImage(img, 0, 0, width, height);

       const dataUrl = canvas.toDataURL('image/jpeg', 0.7);
       callback(dataUrl);
     };
   }
 // 파일 선택
    // 파일 선택
function selectFile(element, id) {
    const file = element.files[0];
    const filename = element.closest('.file_input').firstElementChild;
    const prevFileName = filename.value; // 이전 파일명 저장

    // 1. 파일 선택 창에서 취소 버튼이 클릭된 경우
    if (!file) {
        // 이전 파일명 복원
        filename.value = prevFileName;
        return false;
    }

    // 2. 파일 크기가 10MB를 초과하는 경우
    const fileSize = Math.floor(file.size / 1024 / 1024);
    if (fileSize > 10) {
        alert('10MB 이하의 파일로 업로드해 주세요.');
        filename.value = prevFileName; // 이전 파일명 복원
        element.value = ''; // 선택한 파일 값 초기화
        return false;
    }

    // 기존에 선택된 파일이 있었다면, 이전 파일의 ID를 removeFileId에 추가
    if (prevFileName) {
        removeFileId.add(id);
    }

    // 3. 파일명 지정
    filename.value = file.name;
    
	 const previousFileName = filename.value;
 	 filename.value = file.name;
 	 deleteImageByAlt(previousFileName);
  if (file.type.startsWith('image/')) {
    resizeImage(file, 700, 400, function(resizedImageData) {

      const photoDiv = document.querySelector('#cntdiv');
      const img = document.createElement('img');

      img.src = resizedImageData;
      img.alt = file.name;
      img.classList.add("inserted-photo");
      img.style.maxWidth = "700px";
      img.style.maxHeight = "400px";
      photoDiv.innerHTML += "<br>"; // <br> 태그 추가
      photoDiv.innerHTML += img.outerHTML;
      photoDiv.innerHTML += "<br>"; // <br> 태그 추가
    });
  }
}

   // 파일 삭제 처리용 익명 함수
    const removeFileId = (function() {
        const ids = [];
        return {
            add(id) {
                if (ids.includes(id)) {
                    return false;
                }
                ids.push(id);
            },
            getAll() {
                return ids;
            }
        }
    }());

function addFile() {
	  const fileDiv = document.createElement('div');
	  const inputId = 'input-file-' + Math.random().toString(36).substring(2, 7); // 랜덤한 ID 생성
	  
	  let html = '<div class="file_input">';
	  html += '  <input type="text" readonly />';
	  html += '  <label class="input-file-button4" for="' + inputId + '">파일 선택</label>';
	  html += '  <input type="file" id="' + inputId + '" name="files" onchange="selectFile(this);" style="display:none;" />';
	  html += '  <button type="button" onclick="removeFile(this);" class="input-file-button5"><span>삭제</span></button>';
	  html += '</div>';

	  fileDiv.innerHTML = html;
	  document.querySelector('.file_list').appendChild(fileDiv);
	}

function removeFile(element, id) {
	  if (id) {
        removeFileId.add(id);
      }
	  const fileAddBtn = element.nextElementSibling;
      const inputs = element.closest('div').querySelectorAll('input');
      const inputValues = [];
inputs.forEach(input => {
          inputValues.push(input.value);    
      });       
     if (fileAddBtn) {
             deleteImageByAlt(inputValues[0]);
              inputs.forEach(input => {
          input.value = ''; 
      }); 

      return false;
  }
      deleteImageByAlt(inputValues[0]);
  element.parentElement.remove();
}

function deleteImageByAlt(alt) {
	  const photoDiv = document.querySelector('#cntdiv');
	  const imgs = photoDiv.querySelectorAll("img[alt='" + alt + "']");
	  console.log(imgs);
	  imgs.forEach(img => img.remove());
	}

</script>
</body>
</html>