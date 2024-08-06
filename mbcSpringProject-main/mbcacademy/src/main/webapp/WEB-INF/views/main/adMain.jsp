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

<title>Administer Page</title>
</head>
<body class="dashboard dashboard_1">
    <%
        // 세션에서 userdto 객체를 가져옴
       String user = (String) session.getAttribute("user");
       String id = (String) session.getAttribute("id");
       int admns = (int) session.getAttribute("admns");
        if (user == null || id == null) {
            response.sendRedirect("/login");
        }
    %>
<script type="text/javascript">
    var gowshowAlert = ${gowshowAlert != null ? gowshowAlert : false};
    var message = "${message != null ? message : ''}";

    if (gowshowAlert) {
        alert(message);
        window.location.href = "/";
    }
</script>

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
	        <div class="full graph_head"></div>
            <div class="row column4 graph">
               <div class="col-md-6">
                  <div class="white_shd full margin_bottom_30">
                     <div class="full graph_head">
                        <div class="heading1 margin_0">
                           <h2><a href="/empChnList">사원 정보 변경 요청</a></h2>
                        </div>
                     </div>
                     <div class="full inner_elements">
                        <div class="row">
                           <div class="col-md-12">
                              <div class="tab_style2">
                                 <div class="tabbar padding_infor_info">
                                    <jsp:include page='/WEB-INF/views/main/getEmpChnList.jsp' />
                                 </div>
                              </div>
                           </div>
                        </div>
                     </div>
                  </div>
               </div>
            
               <div class="col-md-6">
                  <div class="white_shd full margin_bottom_30">
                     <div class="full graph_head">
                        <div class="heading1 margin_0">
                           <h2><a href="/list">신고 누적 게시글</a></h2>
                        </div>
                     </div>
                     <div class="full inner_elements">
                        <div class="row">
                           <div class="col-md-12">
                              <div class="tab_style2">
                                 <div class="tabbar padding_infor_info">
                                 	<jsp:include page='/WEB-INF/views/main/getListRprb.jsp' />
                                 </div>
                              </div>
                           </div>
                        </div>
                     </div>
                  </div>
               </div>              
            </div>

            
            
            <!-- footer -->
            <jsp:include page='/WEB-INF/views/include/footer.jsp' />
         </div>
      </div>
   </div>
</body>
</html>