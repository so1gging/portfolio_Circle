<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
            background-image: url(resources/img/bg3.jpg);
            background-size: cover;          
            font-family: 'Noto Sans KR', sans-serif;
        }
        .on{
            width: 400px; margin:0px auto;
        }
    </style>
<!-- Jquery -->
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script type="text/javascript">

	$(function(){
		$("#findBtn").click(function(){
			var user_email = $("#user_email").val();
			var user_name = $("#user_name").val();
			
			if(user_email == "" || user_name == ""){
				alert("폼을 모두 입력해주세요.");
				return false;
			}
			
			var data = {
					"user_email":user_email,
					"user_name":user_name		
			};
			
			$.ajax({
				type:'post',
				url:'${pageContext.request.contextPath}/user/find',
				contentType:'application/json',
				dataType:'json',
				data:JSON.stringify(data),
				success:function(data){
					if(data.check == true){
						
						$.ajax({
							type:'post',
							url:'${pageContext.request.contextPath}/mail/mailSending',
							contentType:'application/json',
							dataType:'json',
							data:JSON.stringify({
								"senderName":"Circles",
								"senderMail":"solzy97@gmail.com",
								"receiveName":user_name,
								"receiveMail":user_email}),
								success:function(data){
									if(data){
										alert("해당 이메일로 임시 비밀번호가 발급되었습니다.");
										location.href='main';										
									}else{
										alert("임시비밀번호 발급 오류. 다시 시도해주세요.");
										location.href='findPwd';
									}
								},
								error:function(){
									alert("ajax 통신 오류");
									location.href='findPwd';
								}
							
							
						});
						
						
						
					}else{
						alert("계정이 존재하지 않습니다.");
					}
					
				},
				error:function(data){
					alert("통신 에러");
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
  
    <div class="container mt-5">
        <div class="card on" style="margin-top:150px;">
            <article class="card-body">
                <h4 class="card-title text-center mb-4 mt-1">Find Password</h4>
                <hr>
                <p class="text-success text-center">Find your lost password</p>
                <form>
                <div class="form-group">
                <div class="input-group">
                    <div class="input-group-prepend">
                        <span class="input-group-text"> <i class="fa fa-envelope"></i> </span>
                     </div>
                    <input id="user_email" class="form-control" placeholder="Enter the Your Email" type="email">
                </div> <!-- input-group.// -->
                </div> <!-- form-group// -->
                <div class="form-group">
                <div class="input-group">
                    <div class="input-group-prepend">
                        <span class="input-group-text"> <i class="fa fa-user"></i> </span>
                     </div>
                    <input class="form-control" placeholder="Enter the Your Name" type="text" id="user_name">
                </div> <!-- input-group.// -->
                </div> <!-- form-group// -->
                <div class="form-group">
                <button type="button" class="btn btn-primary btn-block" id="findBtn"> Check  </button>
                </div> <!-- form-group// -->
                </form>
            </article>
            </div> <!-- card.// -->
    </div>
    
<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>
</body>
</html>