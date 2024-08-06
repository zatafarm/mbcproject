<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
    .boldth {
        font-weight: bold; 
        width: 150px;
        
    }
        .detailmodal{
        cursor: pointer; 
    }
    .detailmodal:hover {
  background: silver;
}

.custom-modal-size {
    width: 800px;
    max-width: 800px;
    height: 600px;
    max-height: 600px;
}

.search-btn {
 margin-bottom: 5px;
}
</style>

<script>
$(document).ready(function(){
    $('.search-btn').on('click', function(event) {
        event.preventDefault(); 
        var searchText =  document.getElementById('searchText').value;
        var searchSelect = document.getElementById('searchSelect').value;
        $.ajax({
            url: "/empolylistsearch", 
            type: "get",
            data: { searchText: searchText,
            		searchSelect: searchSelect },
            success: function(data){
            	 $('#modalContent').html(data);
               
      			
            },
            error: function(xhr, status, error){
                console.error("Error: " + status + " " + error);
            }
        });
    });
});
</script>

</head>
<body>
                     <div align="right">
                     <form>
					  <select name="languages" id="searchSelect">
					    <option value="detpsearch">부서</option>
					    <option value="namesearch">이름</option>
					  </select>
					  <input type="text" placeholder="검색 입력" name="searchText" id="searchText" >
					  <button type="submit" class="btn btn-info search-btn"><i class="fa fa-search"></i></button>
					</form>
                     </div>
									<div class="table-responsive-sm">
                                    <table class="table table-bordered" style="background-color: white; text-align: center; ">
                                       <thead>
                                          <tr>
                                             <th class = "boldth">부서</th>
                                             <th class = "boldth">직급</th>
                                             <th class = "boldth">이름</th>
                                             <th class = "boldth">번호</th>
                                          </tr>
                                       </thead>
                                       <tbody>
                                       
                                       
      									<c:forEach var="employ" items="${list}">
      									<tr class="detailmodal" data-url="/empolydetail?empno=${employ.empno}">
                                       		<td>${employ.codenm}</td>
                                       		<td>${employ.ranks}</td>
                                       		<td>${employ.ename}</td>
                                       		<td>${employ.ctelf}</td>
                                       	</tr>
                                       	</c:forEach>
                                       </tbody>
                                    </table>
                                 </div>
                                 <div class="paging">
    <div class="text-center clearfix">
      <ul class="pagination">
    <c:if test="${pageMaker.prev }">
    <li class="page-item">
        <a class="page-link" href='<c:url value="/empolylistsearch?searchSelect=${searchSelect}&searchText=${searchText}&page=${pageMaker.startPage-1 }"/>'><i class="fa fa-chevron-left"></i></a>
    </li>
    </c:if>
 <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="pageNum">
    <li class="${pageNum == pageMaker.cri.page ? 'active' : ''}">
        <a class="page-link" href='<c:url value="/empolylistsearch?searchSelect=${searchSelect}&searchText=${searchText}&page=${pageNum}"/>'><i class="fa">${pageNum}</i></a>
    </li>
</c:forEach>

    <c:if test="${pageMaker.next && pageMaker.endPage >0 }">
    <li class="page-item">
        <a class="page-link" href='<c:url value="/empolylistsearch?searchSelect=${searchSelect}&searchText=${searchText}&page=${pageMaker.endPage+1 }"/>'><i class="fa fa-chevron-right"></i></a>
    </li>
    </c:if>
</ul>

    </div>
</div>
  <!-- Modal -->
<div class="modal fade" id="empolydetailModal" tabindex="-1" aria-labelledby="empolyModalLabel" aria-hidden="true">
    <div class="modal-dialog  modal-dialog-centered custom-modal-size">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="empolydetailModalLabel">사원</h5>
                <button type="button" class="close" id="closeModalX" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body" id="modalContents">
            
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary"  id="closeModal">닫기</button>
            </div>
        </div>
    </div>
</div>
                                 
          <script>
          $(document).ready(function() {
        	    $('#closeModal').click(function() {
        	        $('#empolydetailModal').modal('hide');
        	    });

        	    $('#closeModalX').click(function() {
        	        $('#empolydetailModal').modal('hide');
        	    });

        	    $('.detailmodal').on('click', function(event) {
        	        event.preventDefault(); // 기본 이벤트를 막음
        	        
        	        var $this = $(this);
        	        var url = $this.data('url');
        	        
        	        $.ajax({
        	            url: url,
        	            method: 'GET',
        	            success: function(data) {
        	                $('#modalContents').html(data);
        	                $('#empolydetailModal').modal({
        	                    backdrop: 'static',
        	                    keyboard: false // Esc 키로 닫히는 것도 방지하려면 추가
        	                });
        	            },
        	            error: function() {
        	                alert("데이터를 불러오는 데 실패했습니다.");
        	            }
        	        });
        	    });
        	});

             </script>
<script>
$(document).ready(function(){
    $('.page-link').on('click', function(event) {
        event.preventDefault();
      
        var url = $(this).attr("href");

        var pageMatch = url.match(/page=(\d+)/);
        var page = pageMatch ? pageMatch[1] : undefined;
        $.ajax({
            url: url, 
            type: "get",
            data: { page : page }, // 정의된 page 변수 사용
            success: function(data){
                $('#modalContent').html(data);
            },
            error: function(xhr, status, error){
                console.error("Error: " + status + " " + error);
            }
        });
    });
});
</script>

           </body>               
           </html>       