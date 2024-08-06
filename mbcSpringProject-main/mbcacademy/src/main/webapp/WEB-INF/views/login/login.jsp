<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page session="true" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
    <jsp:include page='/WEB-INF/views/include/head.jsp'/>
    <title>Login</title>
    <style>
      .checktable {
         width: 100%;
      }
      
      .checktd {
         padding: 5px 0;
      }
      
      .checklabel {
         display: inline-block;
         width: 80px;
         text-align: right;
         margin-right: 10px;
      }
      
      .checkinput {
         width: calc(100% - 150px);
         box-sizing: border-box;
      }
      .errormsg {
      color : red;
      font-size : 12px;
      margin: 0 0 20px 20px;
      }
      .signup {
         width: 80%;
      }
   </style>
    
   </head>
   <body class="inner_page login">
   <jsp:include page='/WEB-INF/views/include/body.jsp' />
      <div class="full_container">
         <div class="container">
            <div class="center verticle_center full_height">
               <div class="login_section">
                  <div class="logo_login">
                     <div class="center">
                        <img width="210" src="/resources/bootstrap/images/logo/logo.png" alt="#" />
                     </div>
                  </div>
                  <div class="login_form">
                     <div class="errormsg">${msg}</div>
                     <form action="/login" method="post" name="form">
                        <fieldset>
                           <div class="field">
                              <label class="label_field">ID</label>
                              <c:choose>
                                  <c:when test="${not empty rememberCookie}">
                                      <input type="text" name="empno" placeholder="ID" value="${rememberCookie}" />
                                  </c:when>
                                  <c:otherwise>
                                      <input type="text" name="empno" placeholder="ID" value="" />
                                  </c:otherwise>
                              </c:choose>
                           </div>
                           <div class="field">
                              <label class="label_field">PW</label>
                              <input type="password" name="pwd" placeholder="Password" />
                           </div>
                           <div class="field">
                              <label class="label_field hidden">hidden label</label>
                              <label class="form-check-label">
                                 <input type="checkbox" class="form-check-input" id="customCheck" name="customCheck" value="true"
                                 <c:if test="${rememberCheckCookie eq 'true' }">checked</c:if> /> Remember Me
                              </label>
                              <a class="forgot reset" data-url="checkEmail">Forgotten Password?</a>
                           </div>
                           <div class="center">
                              <input type="submit" class="main_bt signup" onclick="return loginCheck()" value="Sign In">
                           </div>
                        </fieldset>
                     </form>
                  </div>
               </div>
            </div>
         </div>
      </div>

      <!-- 아이디 존재 확인 모달 -->
      <div class="modal fade" id="idCheckModal" tabindex="-1" role="dialog" aria-labelledby="idCheckModalLabel" aria-hidden="true">
         <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
               <div class="modal-header">
                  <h5 class="modal-title" id="idCheckModalLabel">본인 확인</h5>
                  <button type="button" class="close reset" data-dismiss="modal" aria-label="Close">
                     <span aria-hidden="true">&times;</span>
                  </button>
               </div>
               <div class="modal-body">
                     <table class="checktable">
                  <tr>
                     <td class="checktd"><label for="inputId" class="checklabel">ID</label>
                        <input class="checkinput" type="text"
                        placeholder="아이디 입력" name="inputId" id="inputId"
                        style="margin-bottom: 10px;" />
                     </td>
                  </tr>
                  <tr>
                     <td class="checktd"><label for="inputEmail" class="checklabel">Email</label>
                        <input class="checkinput" type="text"
                        placeholder="이메일 입력" name="inputEmail" id="inputEmail" /></td>
                  </tr>
               </table>
               </div>
               <div class="modal-footer">
                  <button type="button" class="btn btn-success" id="idCheckSubmit">전송</button>
               </div>
            </div>
         </div>
      </div>

     <!-- 비밀번호 모달 -->
      <div class="modal fade" id="resetPwModal" tabindex="-1" role="dialog"
      aria-labelledby="resetPwModalLabel" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered">
         <div class="modal-content">
            <div class="modal-header">
               <h5 class="modal-title" id="resetPwModalLabel">비밀번호 재설정</h5>
               <button type="button" class="close reset" data-dismiss="modal"
                  aria-label="Close">
                  <span aria-hidden="true">&times;</span>
               </button>
            </div>
            <div class="modal-body" id="resetPwContents"></div>
            <div class="modal-footer">
               <button type="submit" class="btn btn-success resetnewpw">Reset Password</button>
            </div>
         </div>
      </div>
   </div>


      <script>
      
      function loginCheck() {

           var empno = $('input[name="empno"]').val();
           var pwd = $('input[name="pwd"]').val();

           if (empno.trim() === '' || pwd.trim() === '') {
               alert('아이디와 비밀번호를 모두 입력해주세요.');
               return false;
           }

           return true;
       }
      
         $(document).ready(function() {
            // Forgotten Password 클릭 이벤트
            $('.reset').on('click', function(event) {
               event.preventDefault();
               $('#resetPwModal').modal('hide');
               $('#idCheckModal').modal('show');
            });

            $('#idCheckSubmit').on('click', function(event) {
                event.preventDefault();
                var inputId = $('#inputId').val();
                var inputEmail = $('#inputEmail').val();
                $.ajax({
                    url: '/ajax/resetPw',
                    type: 'POST',
                    data: { empno: inputId, email: inputEmail },
                    success: function(response) {
                        if (response === 'exists') {
                            // 비밀번호 재설정 모달을 로드하고 표시
                            $.ajax({
                                url: '/ajax/resetPw',
                                type: 'GET',
                                success: function(data) {
                                    $('#idCheckModal').modal('hide');
                                    $('#resetPwContents').html(data);
                                    $('#resetPwModal').modal('show');
                                    $('#resetPwModal').append('<input type="hidden" id="hiddenEmpno" value="' + inputId + '"/>');
                                },
                                error: function() {
                                    alert('본인 인증 모달을 불러오는 데 실패했습니다.');
                                }
                            });
                        } else {
                            alert('해당 아이디 또는 이메일이 존재하지 않습니다.');
                        }
                    },
                    error: function() {
                        alert('서버에 오류가 발생했습니다.');
                    }
                });
            });
            
           function check(reg, str, message) {
              if(reg.test(str)) {
                 return true;
              } else{
                 alert(message);
                 str.focus();
                 return false;
              }
           }
           
            $('.resetnewpw').on('click', function() {
                var npw1 = $('#npw1').val();
                var npw2 = $('#npw2').val();
                var regPw = /^[a-z0-9~!@#$%^&*]{6,15}$/;
                
                var empno = $('#hiddenEmpno').val();  // hidden input에서 empno를 가져옴
                if (npw1 !== npw2){
                   alert('비밀번호가 일치하지 않습니다.');
                   return;
                }
                if(!check(regPw,npw1,"PW는 6~15자의 영문자와 숫자, 특수문자('~ ! @ # $ % ^ & * ')로만 입력해주세요.")){
                 return false;
              }
                $.ajax({
                    url: '/newPwUpdate',
                    type: 'POST',
                    data: { empno: empno, newPw: npw1 },
                    success: function(response) {
                        if (response === 'success') {
                           alert('비밀번호가 성공적으로 변경 되었습니다.');
                           $('#resetPwModal').modal('hide');
                        } else {
                           alert('비밀번호 변경에 실패했습니다.');
                        }
                    },
                    error: function() {
                        alert('서버에 오류가 발생했습니다.');
                    }
                });
            });
         });
      </script>
   </body>
</html>