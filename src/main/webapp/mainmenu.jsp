<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<style>
	a{
		text-decoration: none;
		color: #000000;
		font-weight: bold;
	}
</style>
<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
	<div class="container-fluid container">
		<ul class="navbar-nav">
			<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/boardList.jsp">리스트로</a></li>
			
			<!-- 
				로그인전 : 회원가입 
				로그인후 : 회원정보 / 로그아웃 (로그인정보 세션 loginMemberId
			-->
			<%
				if(session.getAttribute("loginMemberId")==null){ //로그인 전
			%>
					<li class="nav-item">
						<a class="nav-link" href="<%=request.getContextPath()%>/login.jsp">로그인</a>
					</li>
			<%
				} else { //로그인 후
			%>
					<li class="nav-item">
						<a class="nav-link" href="<%=request.getContextPath()%>/logout.jsp">로그아웃</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="<%=request.getContextPath()%>/addBoard.jsp">게시글 추가</a>
					</li>
			<%
				}
			%>
		</ul>
	</div>
</nav>