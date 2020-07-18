<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<c:if test="${!empty user }">
	<c:set value="${user }" var="user"></c:set>
</c:if>

 	<nav class="navbar"  style="background-color: white;" id="main-nav" >
        <div class="container">
            <div class= "navbar-left">
                <h2 class="logotitlee" style="text-align:center; font-family: 'Righteous', cursive; ">
                <a class="navbar-brand" href="main" style="font-size: 0.8em; color: #0275d8;">Circles</a></h2>
            </div>
            
            <div class="navbar-right">
                <ul class="nav navbar-nav">
                	<c:if test="${empty user }">
	                    <li class="nav-item" style="margin: 20PX;"><a href="login" class="menulink" style="color: #0275d8;">로그인</a>
	                    </li>                	
                	</c:if>
                	<c:if test="${!empty user }">
	                    <li class="nav-item" style="margin: 20PX;"><a href="logout" class="menulink" style="color: #0275d8;">로그아웃</a>
	                    </li>                	
                	</c:if>
                </ul>
            </div>
        </div>
    </nav>