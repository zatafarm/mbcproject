<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<%@ page session="true"%>

<%
String source = request.getParameter("source");
%>
<%
    int bno = Integer.parseInt(request.getParameter("bno"));
%>

<!DOCTYPE html>
<html lang="en">
<head>
<jsp:include page='/WEB-INF/views/include/head.jsp' />
<title>Board Detail</title>
<style>
.boardcss {
	padding: 0 60px;
}
.boardcsscnt {
	padding: 0 150px;
}
.cmtt {
	padding: 15px 15px;
}

.cntdiv{
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
                           <h2><c:if test="${board.empno eq 'admin'}"><a href="/aumlist">공지사항</a></c:if>
                           	   <c:if test="${board.empno ne 'admin'}"><a href="/list">사내게시판</a></c:if>
                           	   - 상세
                           </h2>
                           <div>${msg}</div>
                        </div>
                     </div>
                  </div>
                  <!-- row -->
                  <div class="row column1">
                     <div class="col-md-12">
                        <div class="white_shd full margin_bottom_30">
                        	<div class="full price_table padding_infor_info">
								<div align="center">
									<c:if test="${board.chk == 1}">
		                          		<span style="font-weight: bold; font-size: small; color: red;">[필독]</span>
		                            </c:if>
		                            <span style="font-weight: bold; font-size:x-large;">${board.ttl}</span>
								</div>
							</div>
                           <div class="full graph_head">
                              <div class="boardcss">
                                 <div class="col-lg-12">
                                 	<div align="right">
                                    	<label class="label_field">작성자</label>
                                        <span style="font-style: oblique;">${board.ename}</span>
                                    </div>
                                    <div style="font-size:small;" align="right">
                                    	<label class="label_field">작성일자</label>
                                        <span style="font-style: oblique;">${board.regdt}</span>
                                    </div>
                                    <div style="font-size:small;" align="right">
                                    	<c:if test="${board.udtdt ne null}">
	                                    	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	                                    	<label class="label_field">수정일자</label>
	                                        <span style="font-style: oblique;">${board.udtdt}</span>
                                        </c:if>
                                    </div>
                                 </div>
                              </div>
                           </div>
                           <div class="full price_table padding_infor_info">
                           	  <div class="container" style="font-size:medium; white-space: pre;">${board.cnt}</div>
                           </div>
                           <div class="container" >
                           <table>
                            <tr>
							        <th scope="row">첨부파일</th>
							        <td id="files" colspan="3">
							    
							        </td>
							   
							    </tr>
							    </table>
							</div>
                           <div class="full graph_head">
                              <div class="boardcss" align="right">
                                 <c:if test="${admns == '1'}">
                                    <c:choose>
                                       <c:when test="${id eq board.empno}">
                                          <button type="button" class="btn btn-success"
                                             onclick="location.href='update?bno=${board.bno}&source=aumlist'">수정</button>
                                          <button type="button" class="btn btn-danger"
                                             onclick="location.href='delete?bno=${board.bno}&source=aumlist'">삭제</button>
                                       </c:when>
                                       <c:otherwise>
                                          <button type="button" class="btn btn-warning">신고&nbsp;${board.rprb}</button>

                                          <button type="button" class="btn btn-danger"
                                             id="admnDel" onclick="showModal(${board.bno})">삭제</button>
                                       </c:otherwise>
                                    </c:choose>
                                 </c:if>
                                
                                 <c:if test="${admns != '1'}">
                                    <c:choose>
                                       <c:when test="${id eq board.empno}">
                                          <c:if test="${board.del == '0'}">
                                             <button type="button" class="btn btn-success"
                                                onclick="location.href='update?bno=${board.bno}&source=list'">수정</button>
                                             <button type="button" class="btn btn-danger"
                                                onclick="confirmDeletion('<%= request.getContextPath() %>/delete?bno=${board.bno}&source=list')">삭제</button>
                                          </c:if>
                                          <c:if test="${board.del == '1'}">
                                             <button type="button" class="btn btn-danger"
                                                onclick="confirmDeletion('<%= request.getContextPath() %>/delete?bno=${board.bno}&source=mylist')">삭제</button>
                                          </c:if>
                                       </c:when>
                                       <c:when test="${board.ename ne '관리자'}">
                                          <button type="button" class="btn btn-danger"
                                             id="rprb" onclick="showModal2(${board.bno})">신고</button>
                                       </c:when>
                                    </c:choose>
                              </c:if>
                              </div>
                           </div>
                           <div class="full cmtt">
	                           <c:choose>
	                              <c:when test="${id ne 'admin'}">
	                                  <c:if test="${board.ename ne '관리자'}">
	                                 	<jsp:include page='/WEB-INF/views/board/comment.jsp' />
	                                  </c:if>
	                              </c:when>
	                           </c:choose>
                           </div>
                           <div align="center" style="margin-bottom: 10px;">
	                              <button type="button" class="btn btn-info"
                                         onclick="location.href='<%=source != null ? source : "dafaultPage"%>'">목록</button>
                           </div>
                        </div>
                     </div>
                  </div>
                  <!-- end row -->
               </div>
            </div>
            <!-- end dashboard inner -->
            <!-- footer -->
            <jsp:include page='/WEB-INF/views/include/footer.jsp' />
         </div>
      </div>
   </div>

   <!-- 삭제 확인 모달 -->
   <div class="modal fade" id="delCheckModal" tabindex="-1" role="dialog"
      aria-labelledby="delCheckModalLabel" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered">
         <div class="modal-content">
            <div class="modal-header">
               <h5 class="modal-title" id="delCheckModalLabel">관리자 권한 삭제</h5>
               <button type="button" class="close reset" data-dismiss="modal"
                  aria-label="Close">
                  <span aria-hidden="true">&times;</span>
               </button>
            </div>
            <div class="modal-body">
               <table class="checktable">
                  <tr>
                     <td class="checktd"><label for="delrea" class="checklabel">삭제
                           사유</label> <select id="delrea" name="delrea">
                           <option value="" selected>사유 선택</option>
                           <option value="게시판 규정 위반">게시판 규정 위반</option>
                           <option value="기타(관리자에게 문의)">기타(관리자에게 문의)</option>
                     </select></td>
                  </tr>
               </table>
            </div>
            <div class="modal-footer">
               <button type="button" class="btn btn-danger" id="confirmDelete">삭제</button>
            </div>
         </div>
      </div>
   </div>

   <!-- 신고 모달 -->
   <div class="modal fade" id="rprbModal" tabindex="-1" role="dialog"
      aria-labelledby="rprbModalLabel" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered">
         <div class="modal-content">
            <div class="modal-header">
               <h5 class="modal-title" id="rprbModalLabel">게시글 신고</h5>
               <button type="button" class="close reset" data-dismiss="modal"
                  aria-label="Close">
                  <span aria-hidden="true">&times;</span>
               </button>
            </div>
            <div class="modal-body" align="center">
               해당 게시글을 신고 하시겠습니까?
               <p>
                  <span style="font-size: x-small;"> 무분별한 신고는 지양 바랍니다.</span>
               </p>
            </div>
            <div class="modal-footer">
               <button type="button" class="btn btn-danger" id="confirmrprb">신고</button>
            </div>
         </div>
      </div>
   </div>


   <script>
   // 모달 표시 함수
   function showModal(bno) {
       $('#delCheckModal').data('bno', bno).modal('show');
   }

   // 모달에서 삭제 사유 입력 후 삭제 요청
   document.getElementById('confirmDelete').addEventListener('click', function() {
       var reason = document.getElementById('delrea').value;
       var bno = $('#delCheckModal').data('bno');
       if (reason.trim() === '') {
           alert('삭제 사유를 입력해주세요.');
           return;
       }
       // 서버로 삭제 요청 및 삭제 사유 전송 (GET 방식)
       window.location.href = 'delete?bno=' + bno + '&delrea=' + encodeURIComponent(reason) + '&source=list';
   });
   
   // 신고 모달 표시 함수
   function showModal2(bno) {
       $('#rprbModal').data('bno', bno).modal('show');
   }

// 신고 요청
   document.getElementById('confirmrprb').addEventListener('click', function() {
       var bno = $('#rprbModal').data('bno');
       $.ajax({
           type: 'POST',
           url: '/detail',
           data: { bno: bno },
           success: function(response) {
               alert('신고가 접수되었습니다.');
               // 신고가 접수되었으므로 모달을 닫거나 다른 동작을 수행할 수 있음
               $('#rprbModal').modal('hide');
           },
           error: function(xhr, status, error) {
               alert('오류가 발생했습니다. 다시 시도해주세요.');
           }
       });
   });
   function confirmDeletion(url) {
       if (confirm('정말 삭제하시겠습니까?')) {
           window.location.href = url;
       }
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


   async function findAllFile() {
	   try {
	     // 1. API 호출
	     const postId = <%= bno %>;
	     const response = await getJson(`/api/detail?bno=<%=bno%>`);
	     // 2. 로직 종료
	     if (!response.length) {
	    	  let fileHtml = '<div class="file_down"><div class="cont">';
	    	  fileHtml += '<span style="color:gray; margin-left:10px">첨부파일이 존재하지 않습니다.</span>';
	    	  fileHtml += '</div></div>';
	    	  document.getElementById('files').innerHTML = fileHtml;
	       return;
	     }
	  // 3. 파일 영역 추가
	     let fileHtml = '<div class="file_down"><div class="cont">';
	     response.forEach(row => {
	       fileHtml += ' <a href="/detail/${board.bno}/files/'+row.id+'/download"  style="margin-left:10px;"><span>' + row.originalName + '</span></a>';
	   
	     });
	     fileHtml += '</div></div>';

	     // 4. 파일 HTML 렌더링
	     document.getElementById('files').innerHTML = fileHtml;
	   } catch (error) {
	     console.error('Error fetching files:', error);
	   }
	 }


   </script>
</body>
</html>