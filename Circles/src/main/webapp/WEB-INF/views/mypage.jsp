<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Circles</title>

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
<!-- main logo font -->
<link href="https://fonts.googleapis.com/css2?family=Righteous&display=swap" rel="stylesheet">
<!-- general font -->
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
<!-- font awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css" />
    <style type="text/css">
        body{
            background-image: url(resources/img/bg2.jpg);
            background-size: cover;       
            font-family: 'Noto Sans KR', sans-serif;
        }


        .main{
 	margin-top: 70px;
    }

    h1.title { 
        font-size: 50px;
        font-family: 'Passion One', cursive; 
        font-weight: 400; 
    }

hr{
	width: 10%;
	color: #fff;
}

.form-group{
	margin-bottom: 15px;
}

label{
	margin-bottom: 15px;
}

input,
input::-webkit-input-placeholder {
    font-size: 11px;
    padding-top: 3px;
}

.main-login{
 	background-color: #fff;
    /* shadows and rounded borders */
    -moz-border-radius: 2px;
    -webkit-border-radius: 2px;
    border-radius: 2px;
    -moz-box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
    -webkit-box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
    box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);

}

.main-center{
 	margin-top: 30px;
 	margin: 0 auto;
 	max-width: 330px;
    padding: 40px 40px;

}

.login-button{
	margin-top: 5px;
}

.login-register{
	font-size: 11px;
	text-align: center;
}

    </style>

<!-- Jquery -->
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script type="text/javascript">
	$(function(){
///////////////////
		
		// 비밀번호 체크
		$("#user_password").keyup(function(){
			var pwd1=$("#user_password").val();
			var pwd2=$("#user_password2").val();
			if(pwd1 != "" || pwd2 != ""){
				if(pwd1 == pwd2){
					$("#passwordChk").css("color","#0275d8");
					$("#passwordChk").html("비밀번호가 일치합니다.");
					$("#isPassword").val("y");
					}
				else{
					$("#passwordChk").css("color","red");
					$("#passwordChk").html("비밀번호가 일치하지 않습니다.");
					$("#isPassword").val("n");
					}
				}
			});
		/////////////////////
		
		$("#user_password2").keyup(function(){
			var pwd1=$("#user_password").val();
			var pwd2=$("#user_password2").val();
			if(pwd1 != "" || pwd2 != ""){
				if(pwd1 == pwd2){
					$("#passwordChk").css("color","#0275d8");
					$("#passwordChk").html("비밀번호가 일치합니다.");
					$("#isPassword").val("y");
					}
				else{
					$("#passwordChk").css("color","red");
					$("#passwordChk").html("비밀번호가 일치하지 않습니다.");
					$("#user_password2").focus();
					$("#isPassword").val("n");
					}
				}
			});
		//////////////////
		
		$("#modifyBtn").click(function(){
			var pwd1=$("#user_password").val();
			var pwd2=$("#user_password2").val();
			
			if(pwd1 == "" || pwd2 == ""){
				alert("비밀번호를 입력하세요.");
				return false;
			}
			if($("#isPassword").val()=='n'){
				alert("비밀번호가 일치하지 않습니다.");
				return false;
			}
			
			var user_email = $('#user_email').val();
			var user_name = $('#user_name').val();
			
			var data = {
					"user_email":user_email,
					"user_name":user_name,
					"user_password":pwd1
			};
			
			$.ajax({
				type:'post',
				url:'${pageContext.request.contextPath}/user/changePwd',
				contentType:'application/json',
				dataType:'json',
				data:JSON.stringify(data),
				success:function(data){
					if(data){
						alert("정보가 수정되었습니다. 다시 로그인해주세요.");
						location.href='logout';
					}else{
						alert("정보 수정 오류! 다시 시도해주세요.");
						location.href='mypage';
					}
				},
				error:function(){
					alert("ajax 통신 오류!");
				}
			});
		});
		
		
	});

</script>

</head>
<body>

  <!-- START nav -->
 <%@ include file="./nav.jsp" %>
  <!-- END nav -->

    <div class="container mt-5 mb-5">
        <div class="row main">
            <div class="main-login main-center">
                <form class="form-horizontal" method="post" action="#">
                <article class="card-body">
	                <h4 class="card-title text-center mb-4 mt-1">Mypage</h4>
	                <hr>
	                <p class="text-success text-center">Check your information</p>
                </article>
                    
                    <div class="form-group">
                        <label for="name" class="cols-sm-2 control-label">Your Name</label>
                        <div class="cols-sm-10">
                            <div class="input-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text"><i class="fa fa-user fa" aria-hidden="true"></i> </span>
                                 </div>
                                <input id="user_name" class="form-control" value="${user.user_name }" type="text" disabled="disabled" style="background-color: white;">
                            </div>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <div class="cols-sm-10" style="text-align: center;">
							<span id="nameChk"></span>
							<input type="hidden" value="n" id="isName" />
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="email" class="cols-sm-2 control-label">Your Email</label>
                        <div class="cols-sm-10">
                            <div class="input-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text"><i class="fa fa-envelope fa" aria-hidden="true"></i></span>
                                 </div>
                                <input id="user_email" class="form-control" value="${user.user_email }" type="email" disabled="disabled" style="background-color: white;">
                            </div>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <div class="cols-sm-10" style="text-align: center;">
							<span id="emailChk"></span>
							<input type="hidden" value="n" id="isEmail" />
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="password" class="cols-sm-2 control-label">Password</label>
                        <div class="cols-sm-10">
                            <div class="input-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text"><i class="fa fa-lock fa-lg" aria-hidden="true"></i></span>
                                 </div>
                                <input id="user_password" class="form-control" placeholder="Enter your Password" type="password">
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="confirm" class="cols-sm-2 control-label">Confirm Password</label>
                        <div class="cols-sm-10">
                            <div class="input-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text"><i class="fa fa-lock fa-lg" aria-hidden="true"></i></span>
                                 </div>
                                <input id="user_password2" class="form-control" placeholder="Enter your Password" type="password">
                            </div>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <div class="cols-sm-10" style="text-align: center;">
							<span id="passwordChk"></span>
							<input type="hidden" value="n" id="isPassword" />
                        </div>
                    </div>

                    <div class="form-group ">
                        <button type="button" class="btn btn-primary btn-lg btn-block login-button" id="modifyBtn">Modify</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>
</body>
</html>