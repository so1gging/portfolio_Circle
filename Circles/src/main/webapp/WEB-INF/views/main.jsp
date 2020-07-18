<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
		font-family: 'Noto Sans KR', sans-serif;
	}
    .h7 {
            font-size: 0.8rem;
        }

        .gedf-wrapper {
            margin-top: 0.97rem;
        }

        @media (min-width: 992px) {
            .gedf-main {
                padding-left: 4rem;
                padding-right: 4rem;
            }
            .gedf-card {
                margin-bottom: 2.77rem;
            }
        }

        /**Reset Bootstrap*/
        .dropdown-toggle::after {
            content: none;
            display: none;
        }
        
        .modify{
        	display:none;
        }
  .img{
    position: relative;
    background-image: url(resources/img/bg.jpg);                                                               
    height: 100vh;
    background-size: cover;
}

.img-cover{
   position: absolute;
   height: 100%;
   width: 100%;
   background-color: rgba(0, 0, 0, 0.2);                                                                 
   z-index:1;
}

.img .content{
     position: absolute;
     top:40%;
     left:50%;
     transform: translate(-50%, -50%);   
     color: white;
     z-index: 2;
     text-align: center;
     font-family: 'Righteous', cursive; 
}
        
</style>
<!-- Jquery -->
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script type="text/javascript">
	// 첫 페이지
	var page = 1;
	
	
	function showModify(guest_no){
		$(".general"+guest_no).css("display","none");
		$(".modify"+guest_no).css("display","block");
	}
	
	function showGeneral(guest_no){
		$(".general"+guest_no).css("display","block");
		$(".modify"+guest_no).css("display","none");
	}	
	
	function modify(guest_no){
		var guest_no = guest_no;
		var guest_title = $("#guest_title"+guest_no).val();
		var guest_content = $("#guest_content"+guest_no).val();
		
		if(guest_title == "" || guest_content == ""){
			alert("폼을 모두 입력해주세요.");
			return false;
		}
		
		var data = {
				"guest_no":guest_no,
				"guest_title":guest_title,
				"guest_content":guest_content
		};
		
		$.ajax({
			type:'put',
			url : '${pageContext.request.contextPath}/guestbook/'+guest_no,
			contentType:'application/json',
			data:JSON.stringify(data),
			success:function(data){
				if(data == 'MOD_SUCCEEDED'){
					alert("수정되었습니다.");
					loadGuestbook();
				}else{
					alert("글 수정 실패!");
				}
			},
			error:function(data){
				alert("ajax 통신실패");
			}
			
		});
		
			
	}
	
	function delGuestbook(guest_no){
		var is = confirm("정말 삭제하시겠습니까?");
		if(is){
			
			$.ajax({
				type:'delete',
				url : '${pageContext.request.contextPath}/guestbook/'+guest_no,
				success:function(data){
					if(data == 'DEL_SUCCEEDED'){
						alert("삭제되었습니다.");
						loadGuestbook();
					}else{
						alert("글 삭제 실패!");
					}
				},
				error:function(data){
					alert("ajax 통신실패");
				}
				
			});
			
		}else{
			return false;
		}
	}
	
	function likeGuestbook(guest_no){
		var user_email = '<c:out value="${user.user_email}"/>';
	
		if(user_email==""){
			alert("로그인이 필요한 서비스 입니다.");
			location.href='login';
			return false;
		}else{
			var data = {
					"user_email":user_email,
					"guest_no":guest_no
			};
			
			$.ajax({
				type:'post',
				url : '${pageContext.request.contextPath}/guestbook/like',
				contentType:'application/json',
				data:JSON.stringify(data),
				success:function(data){
					if(data == 'LIKE_SUCCEEDED'){
						loadGuestbook();		
					}
				},
				error:function(data){
					alert("ajax 통신실패");
				}
				
			});
		}
	}
	
	
	
	function loadGuestbook(){
		page = 1;
		 $("#guestbook_div").html("");
		// 가져오기
		$.ajax({
			url : '${pageContext.request.contextPath}/guestbook/'+page,
			type:'get',
			success : function(msg) {
				var data = msg.list;
				var next = msg.next;
				
				if(next){
					$(".next-btn").css("visibility","visible");
				}
				
				$.each(data , function(i){
					var guest_no = data[i].guest_no;
					var guest_title = data[i].guest_title;
					var user_email = data[i].user_email;
					var user_name = data[i].user_name;
					var guest_content = data[i].guest_content;
					var guest_date = new Date(data[i].guest_date).toLocaleString();
					var guest_status = data[i].guest_status;
					var guest_heart = data[i].guest_heart;
					
					var html = '';
					
					// 일반
					
					html += '<div class="card gedf-card mt-2 general general'+guest_no+'">';
					html += '<div class="card-header">';
					html += '<div class="d-flex justify-content-between align-items-center">';
					html += '<div class="d-flex justify-content-between align-items-center">';
					html +=         '<div class="ml-2">';
					html +=             '<div class="h5 m-0">@'+user_name+'</div>';
					html +=             '<div class="h7 text-muted">'+user_email+'</div>';
					html +=         '</div>';
					html +=     '</div>';
					html += '<div>';
	                            
					html += '</div>';
					html += '</div>';

					html += '</div>';
	                
					html += '<div class="card-body">';
					html += '<div class="text-muted h7 mb-2"> <i class="fa fa-clock-o"></i>'+ guest_date +'</div>';
					html += '<h5 class="card-title text-primary">' + guest_title +'</h5>';

	                html += '<p class="card-text">'+ guest_content+'</p>';
	                
	                if(user_email == '<c:out value="${user.user_email}"/>'){
	                	html += '<div style="text-align: right;">';
	                	html += '<a class="text-secondary" style="cursor:pointer" onclick="showModify('+guest_no+');">수정</a> ' ;           
	                	html += '<a class="text-danger" style="cursor:pointer" onclick="delGuestbook('+guest_no+');">삭제</a>';
	                	html += '</div>';
	                }
	                
	               html += '</div>';
	               html += '<div class="card-footer">';
	               html += '<a style="cursor:pointer" onclick="likeGuestbook('+guest_no+');" class="card-link text-primary"><i class="fa fa-thumbs-up" aria-hidden="true"></i> Like <span>'+guest_heart+'</span></a>';
	               html += '</div>';
	               html += '</div>';
	               
	               /////////////////////////////// 수정
	               
					html += '<div class="card gedf-card mt-2 modify modify'+guest_no+'">';
					html += '<div class="card-header">';
					html += '<div class="d-flex justify-content-between align-items-center">';
					html += '<div class="d-flex justify-content-between align-items-center">';
					html +=         '<div class="ml-2">';
					html +=             '<div class="h5 m-0">@'+user_name+'</div>';
					html +=             '<div class="h7 text-muted">'+user_email+'</div>';
					html +=         '</div>';
					html +=     '</div>';
					html += '<div>';
	                            
					html += '</div>';
					html += '</div>';

					html += '</div>';
	                
					html += '<div class="card-body">';
					html += '<div class="text-muted h7 mb-2"> <i class="fa fa-clock-o"></i>'+ guest_date +'</div>';					
					html += '<h5 class="card-title"><input type="text" class="form-control" id ="guest_title'+guest_no+'" value="'+guest_title+'"/></h5>';

	                html += '<p class="card-text"><textarea class="form-control" style="resize:none;" id ="guest_content'+guest_no+'">'+ guest_content+'</textarea></p>';
	                
	                	html += '<div style="text-align: right;">';
	                	html += '<a class="text-secondary" style="cursor:pointer" onclick="modify('+guest_no+');">수정</a> ' ;           
	                	html += '<a class="text-danger" style="cursor:pointer" onclick="showGeneral('+guest_no+');">취소</a>';
	                	html += '</div>';
	           
	                
	               html += '</div>';
	               html += '<div class="card-footer">';
	               html += '</div>';
	               html += '</div>';
	               
	               $("#guestbook_div").append(html);
					
	           });
				
				}, error : function() {
					alert("ajax 통신에러");
				}
			
		});
	}
	
	
	
	$(function(){

		loadGuestbook();
		
		$("#nextBtn").click(function(){
			page = page+1;
			$.ajax({
				url : '${pageContext.request.contextPath}/guestbook/'+page,
				type:'get',
				success : function(msg) {
					var data = msg.list;
					var next = msg.next;
					
					if(next){
						$(".next-btn").css("visibility","visible");
					}else{
						$(".next-btn").css("visibility","hidden");
					}
					
					$.each(data , function(i){
						var guest_no = data[i].guest_no;
						var guest_title = data[i].guest_title;
						var user_email = data[i].user_email;
						var user_name = data[i].user_name;
						var guest_content = data[i].guest_content;
						var guest_date = new Date(data[i].guest_date).toLocaleString();
						var guest_status = data[i].guest_status;
						var guest_heart = data[i].guest_heart;
						
						var html = '';
						
						html += '<div class="card gedf-card mt-2 general general'+guest_no+'">';
						html += '<div class="card-header">';
						html += '<div class="d-flex justify-content-between align-items-center">';
						html += '<div class="d-flex justify-content-between align-items-center">';
						html +=         '<div class="ml-2">';
						html +=             '<div class="h5 m-0">@'+user_name+'</div>';
						html +=             '<div class="h7 text-muted">'+user_email+'</div>';
						html +=         '</div>';
						html +=     '</div>';
						html += '<div>';
		                            
						html += '</div>';
						html += '</div>';

						html += '</div>';
		                
						html += '<div class="card-body">';
						html += '<div class="text-muted h7 mb-2"> <i class="fa fa-clock-o"></i>'+ guest_date +'</div>';
						html += '<h5 class="card-title text-primary">' + guest_title +'</h5>';

		                html += '<p class="card-text">'+ guest_content+'</p>';
		                
		                if(user_email == '<c:out value="${user.user_email}"/>'){
		                	html += '<div style="text-align: right;">';
		                	html += '<a class="text-secondary" style="cursor:pointer" onclick="showModify('+guest_no+');">수정</a> ' ;           
		                	html += '<a class="text-danger" style="cursor:pointer" onclick="delGuestbook('+guest_no+');">삭제</a>';
		                	html += '</div>';
		                }
		                
		               html += '</div>';
		               html += '<div class="card-footer">';
		               html += '<a href="#" class="card-link"><i class="fa fa-thumbs-up" aria-hidden="true"></i> Like <span>'+guest_heart+'</span></a>';
		               html += '</div>';
		               html += '</div>';
		               
		               /////////////////////////////// 수정
		               
						html += '<div class="card gedf-card mt-2 modify modify'+guest_no+'">';
						html += '<div class="card-header">';
						html += '<div class="d-flex justify-content-between align-items-center">';
						html += '<div class="d-flex justify-content-between align-items-center">';
						html +=         '<div class="ml-2">';
						html +=             '<div class="h5 m-0">@'+user_name+'</div>';
						html +=             '<div class="h7 text-muted">'+user_email+'</div>';
						html +=         '</div>';
						html +=     '</div>';
						html += '<div>';
		                            
						html += '</div>';
						html += '</div>';

						html += '</div>';
		                
						html += '<div class="card-body">';
						html += '<div class="text-muted h7 mb-2"> <i class="fa fa-clock-o"></i>'+ guest_date +'</div>';					
						html += '<h5 class="card-title"><input type="text" class="form-control" value="'+guest_title+'"/></h5>';

		                html += '<p class="card-text"><textarea class="form-control" style="resize:none;">'+ guest_content+'</textarea></p>';
		                
	                	html += '<div style="text-align: right;">';
	                	html += '<a class="text-secondary" style="cursor:pointer" onclick="showModify('+guest_no+');">수정</a> ' ;           
	                	html += '<a class="text-danger" style="cursor:pointer" onclick="showGeneral('+guest_no+');">취소</a>';
	                	html += '</div>';
		           
		                
		               html += '</div>';
		               html += '<div class="card-footer">';
		               html += '</div>';
		               html += '</div>';
		               
		               
		               $("#guestbook_div").append(html);
						
		           });
					
					}, error : function() {
						alert("ajax 통신에러");
					}
				
			});
			
		});
		
		
		// guestbook 카운트
		$("#guest_content").keyup(function(e){
			var content = $(this).val();
			
		    $('#counter').html("("+content.length+" / 350)");    //글자수 실시간 카운팅
		    if(content.length>349){
		    	$(this).val($(this).val().substring(0,349));
		    }
		});
		
		// 작성
		$("#submitBtn").click(function(){
			var guest_title = $("#guest_title").val();
			var guest_content = $("#guest_content").val();
			
			var user_email = '<c:out value="${user.user_email}"/>';
			var user_name = '<c:out value="${user.user_name}"/>';
			
			
			if(user_email==""||user_name==""){
				alert("로그인이 필요한 서비스 입니다.");
				location.href='login';
				return false;
			}
			
			if(guest_title==""){
				alert("제목을 입력해주세요.");
				$("#guest_title").focus();
				return false;
			}
			
			if(guest_content==""){
				alert("내용을 입력해주세요.");
				$("#guest_content").focus();
				return false;
			}	
			
			var data = {
					"guest_title":guest_title,
					"guest_content":guest_content,
					"user_email":user_email,
					"user_name":user_name
			};
			
			$.ajax({
				type:'post',
				url : '${pageContext.request.contextPath}/guestbook',
				contentType:'application/json',
				data:JSON.stringify(data),
				success:function(data){
					if(data == 'ADD_SUCCEEDED'){
						alert("글 등록 성공!");
						
						$("#guest_title").val("");
						$("#guest_content").val("");
						
						loadGuestbook();
					}else{
						alert("글 등록 실패!");
					}
				},
				error:function(data){
					alert("ajax 통신실패");
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
   <div class="img">
        <div class="content">
            <h1 style="font-size: 5em;">Hello!</h1>
            <h2>Welcome to the CIRCLE</h2>
        </div>
        <div class="img-cover"></div>
    </div>
    
    <div class="container p-4">
        <div class="container">
            <div class="row card">
                <div class="card-body bg-light pb-3">
                        <input type="text" id="guest_title" class="card-body container form-control mb-1" placeholder="Type in your title"/>
                        <textarea class="card-body container form-control" id="guest_content" name="new_message" placeholder="Type in your message" style="resize: none;"></textarea>
                        <div style="text-align: right;" class="mt-1">
                        	<span id="counter" class="mb-1" style="display: block; color: slategrey;">( 0 / 350 )</span>
                        	
                            <button class="btn btn-primary" type="button" id="submitBtn">Post New Guestbook</button>
                        </div>
                </div>
            </div>
        </div>
        <div class="mt-5" id="guestbook_div">


            
        </div>
        <div class="next-btn" style="text-align: center; visibility: hidden;" >
            <input type="button" value="next" class="form-control" id="nextBtn">
        </div>
    </div>


<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>
</body>
</html>