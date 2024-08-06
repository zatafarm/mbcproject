<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<%@ page session="true"%>

<% String source = request.getParameter("source"); %>

<!DOCTYPE html>
<html lang="en">
<head>
<jsp:include page='/WEB-INF/views/include/head.jsp' />
<title>Board aumRegister</title>
<style>
.cntdiv{
    width:700px;
    height:400px;
    border: 1px solid #ccc;
     overflow-y: auto;
}

.input-file-button{
  padding: 6px 25px;
  background-color:#8BC34A;
  border-radius: 4px;
  color: white;
  cursor: pointer;
  margin-left: 10px;
}
.input-file-button2{
  padding: 6px 25px;
  border :0px;
  background-color:  #EF5350;
  border-radius: 4px;
  color: white;
  cursor: pointer;
    margin-left: 10px;
}
.input-file-button3{
  padding: 6px 25px;
  border :0px;
  background-color:#2196F3;
  border-radius: 4px;
  color: white;
  cursor: pointer;
    margin-left: 10px;
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
                           <h2>공지사항 작성</h2>
                        </div>
                     </div>
                  </div>
                  <!-- row -->
                  <form action="/aumregister" method="post" enctype="multipart/form-data" id="registerForm">
                  <input type="hidden" name="frm" value="${board.frm}">
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
                                             <td>${user}</td>                                       
                                          </tr>
                                          <tr>
                                             <th>제목</th>
                                             <td colspan="5" align="left"><input type="text" size="80" name="ttl" placeholder="제목을 입력해주세요." value="${board.ttl}" required="required"/>
                                             	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                             	<span style="font-size: 11px; color: red;">중요*&nbsp;&nbsp;<input type="checkbox" id="chk" name="chk" value="1" onchange="updateValue(this)"></span>
                                             </td>
                                          </tr>
                                         <tr>
                                               <th>내용</th>
											  <td colspan="2">
											  
											    <div contentEditable="true" class="cntdiv" id="cntdiv"></div>
											    <input type="hidden" id="cnt" name="cnt" />
											    <div class="photo-placeholder"></div>
											  </td>
											</tr>
                                          <tr>
									        <th>첨부파일</th>
									        <td colspan="3">
									            <div class="file_list">
									                <div>
									                    <div class="file_input">
									                        <input type="text" readonly />
									                        <label class="input-file-button" for="input-file">
																  파일 선택
																</label>
									                            <input type="file" name="files" id="input-file" onchange="selectFile(this);" style="display:none;"/>
									                    
									                    <button class="input-file-button2" type="button" onclick="removeFile(this);" ><span>삭제</span></button>
									                    <button class="input-file-button3" type="button" onclick="addFile();" ><span>파일 추가</span></button>
									                    </div>
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
                                                <button type="submit" class="btn btn-success">저장</button>
                                                <button type="reset" class="btn btn-secondary">초기화</button>
                                                <button type="button" class="btn btn-info" onclick="location.href='aumlist'">목록</button>
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
        if (!checkbox.checked) {
            checkbox.value = 0;
        }
    }

</script>
      <%
        // 현재 날짜와 시간 가져오기
        Date today = new Date();
        
        // 날짜 형식 지정
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyMMdd");
        
        // 오늘 날짜를 지정된 형식으로 변환
        String todayStr = dateFormat.format(today);
    %>
      <script>


   // 폼 제출 이벤트 리스너 등록
document.addEventListener('DOMContentLoaded', function() {
	const form = document.getElementById('registerForm');
    form.addEventListener('submit', function(event) {
        event.preventDefault(); // 폼 제출 시 기본 동작 방지

        const element = document.getElementById('cntdiv');
        const images = element.getElementsByTagName('img');
        for (let i = 0; i < images.length; i++) {
            var imgtext = images[i].alt;
            images[i].src = imgtext; // 새로운 이미지 경로로 변경
        }

        const element2 = element.innerHTML;
        document.getElementById('cnt').value = element2;

        form.submit(); // 수정된 내용을 포함하여 폼 제출
    });
});



   </script>
   <script>
// 이미지 리사이징 함수
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
 function selectFile(element) {
  const file = element.files[0];
  const filename = element.closest('.file_input').firstElementChild;

  // 1. 파일 선택 창에서 취소 버튼이 클릭된 경우
  if (!file) {
    filename.value = '';
    return false;
  }

  // 2. 파일 크기가 10MB를 초과하는 경우
  const fileSize = Math.floor(file.size / 1024 / 1024);
  if (fileSize > 10) {
    alert('10MB 이하의 파일로 업로드해 주세요.');
    filename.value = '';
    element.value = '';
    return false;
  }


  // 3. 파일명 지정
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

   // 파일 추가
function addFile() {
  const fileDiv = document.createElement('div');
  const inputId = 'input-file-' + Math.random().toString(36).substring(2, 7); // 랜덤한 ID 생성
  
  let html = '<div class="file_input">';
  html += '  <input type="text" readonly />';
  html += '  <label class="input-file-button" for="' + inputId + '">파일 선택</label>';
  html += '  <input type="file" id="' + inputId + '" name="files" onchange="selectFile(this);" style="display:none;" />';
  html += '  <button type="button" onclick="removeFile(this);" class="input-file-button2"><span>삭제</span></button>';
  html += '</div>';

  fileDiv.innerHTML = html;
  document.querySelector('.file_list').appendChild(fileDiv);
}


   // 파일 삭제
function removeFile(element) {
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
</script>
</body>
</html>