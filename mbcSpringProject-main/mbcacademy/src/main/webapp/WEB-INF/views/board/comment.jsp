<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page session="true"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Comments Section</title>
    <style>
    .cmt,
    .cmtbt {
        display: inline-block;
       	vertical-align: middle; /* 상하 정렬 설정 */
    }
    
    .rpl,
    .rplbt {
        display: inline-block;
        vertical-align: middle; /* 상하 정렬 설정 */
        margin-bottom: 10px;
    }

    
    
</style>
</head>
<body>
<div class="container">
    <!-- Comments Section -->
    <div class="comments-section">
        <c:forEach var="comment" items="${cmtList1}">
            <div class="full graph_head">
	            <c:if test="${comment.delc1 == 0}">
	                <strong>${comment.ename}</strong>&nbsp;
	                <c:if test="${board.ename eq comment.ename}">
	                	<small>작성자</small>
	                </c:if><br> ${comment.cmt1} <br>
	                <div class="cmt"><small>${comment.cmtdt1}</small></div>
	                <div class="cmtbt">
	                    <c:choose>
	                        <c:when test="${user eq comment.ename}">
	                            <button type="button" class="btn btn-link" onclick="showEditForm(${comment.cno1})">
	                            	<small>수정</small></button>
	                            <form action="delc1" method="post" style="display:inline;">
	                                <input type="hidden" name="cno1" value="${comment.cno1}">
	                                <input type="hidden" name="bno" value="${param.bno}">
	                                <button type="submit" class="btn btn-link"><small>삭제</small></button>
	                            </form>
	                        </c:when>
	                    </c:choose>
                   		<button class="btn btn-link" onclick="showReplyForm(${comment.cno1})"><small>답글달기</small></button>
					</div>
	            </c:if>
	            <c:if test="${comment.delc1 == 1}"><span style="color: gray;">삭제된 댓글입니다.</span></c:if>
	            
                <!-- 댓글 수정 -->
                <div id="editForm${comment.cno1}" class="edit-form" style="display:none;">
                    <form action="cmtUpdate1" method="post">
                        <input type="hidden" name="cno1" value="${comment.cno1}">
                        <input type="hidden" name="bno" value="${param.bno}">
                        <div><em>댓글 수정</em><button type="submit" class="btn btn-link">수정</button></div>
                        <div><textarea class="form-control" name="cmt1" required>${comment.cmt1}</textarea></div>
                    </form>
                </div>
	                
                <!-- 대댓글 작성 -->
                <div id="replyForm${comment.cno1}" class="reply-form" style="display:none;">
                    <form action="cmtRegister2" method="post">
                        <input type="hidden" name="bno" value="${param.bno}">
                        <input type="hidden" name="cno1" value="${comment.cno1}">
                        <input type="hidden" name="empno" value="${id}">
                        <div><em>답글 작성</em><button type="submit" class="btn btn-link">등록</button></div>
                        <div><textarea class="form-control" name="cmt2" required></textarea></div>
                    </form>
                </div>
	
                <!-- 대댓글 목록 -->
				<c:forEach var="reply" items="${cmtList2}">
	                <c:if test="${comment.cno1 eq reply.cno1}">
			            <div class="full graph_head">	
				            └<c:if test="${reply.delc2 == 0}">
								<strong>${reply.ename}&nbsp;</strong>
								<c:if test="${board.ename eq reply.ename}">
									<small>작성자</small></c:if><br>
								<strong style="font-size:13px; margin-left: 15px;">${comment.ename}</strong>
								&nbsp;&nbsp;${reply.cmt2}<br>
				                <div class="rpl"><small>${reply.cmtdt2}</small></div>
				                <div class="rplbt">
				                    <c:choose>
				                        <c:when test="${user eq reply.ename}">
				                            <button type="button" class="btn btn-link" onclick="showEditForm2(${reply.cno2})">
				                            	<small>수정</small></button>
				                            <form action="/delc2?bno=${comment.bno}&&?cno2=${reply.cno2}" method="post" style="display:inline;">
				                                <input type="hidden" name="cno2" value="${reply.cno2}">
				                                <button type="submit" class="btn btn-link"><small>삭제</small></button>
				                            </form>
				                        </c:when>
				                    </c:choose>
				                </div>	
				            </c:if><br>
				            <c:if test="${reply.delc2 == 1}">
				            	<div class="rpl"><span style="color: gray;">삭제된 댓글입니다.</span></div>
				            </c:if>
				            
				            <!-- 대댓글 수정 -->
			                <div id="editForm2${reply.cno2}" class="edit-form2" style="display:none;">
			                    <form action="cmtUpdate2" method="post">
			                        <input type="hidden" name="cno2" value="${reply.cno2}">
			                        <input type="hidden" name="bno" value="${param.bno}">
			                        <div><em>답글 수정</em><button type="submit" class="btn btn-link">수정</button></div>
			                        <div><textarea class="form-control" name="cmt2" required>${reply.cmt2}</textarea></div>
			                    </form>
			                </div>
               		 	</div>
	              	</c:if>

                </c:forEach>
            </div>
        </c:forEach>
    </div>
</div>

<!-- New Comment Form -->
<div class="container">

<div class="comments-section">
<div class="full graph_head">
    <form action="cmtRegister1" method="post">
        <input type="hidden" name="bno" value="${param.bno}">
        <input type="hidden" name="empno" value="${id}">
        <div><em>댓글 작성</em><button type="submit" class="btn btn-link">등록</button></div>
        <div><textarea class="form-control" name="cmt1" placeholder="댓글 내용을 입력해주세요." required></textarea></div>
    </form>
</div>
</div>
</div>

<script>
    function showReplyForm(commentId) {
        var replyForm = document.getElementById('replyForm' + commentId);
        replyForm.style.display = replyForm.style.display === 'none' ? 'block' : 'none';
    }
    function showEditForm(commentId) {
        var editForm = document.getElementById('editForm' + commentId);
        editForm.style.display = editForm.style.display === 'none' ? 'block' : 'none';
    }
    function showEditForm2(commentId) {
        var editForm = document.getElementById('editForm2' + commentId);
        
        editForm.style.display = editForm.style.display === 'none' ? 'block' : 'none';
    }
</script>
</body>
</html>