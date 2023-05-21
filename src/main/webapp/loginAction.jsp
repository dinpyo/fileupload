<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
<%@ page import="vo.*" %>
<%
	// 세션 유효성 검사
	if(request.getParameter("memberId")==null) {
		response.sendRedirect(request.getContextPath()+"login.jsp");
		return;
	} 

	if(request.getParameter("memberPw")==null) {
		response.sendRedirect(request.getContextPath()+"login.jsp");
		return;
	} 
	
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	
	// DB 연동
	String driver="org.mariadb.jdbc.Driver";
	String dburl="jdbc:mariadb://127.0.0.1:3306/fileupload";
	String dbuser="root";
	String dbpw = "java1234";
	
	Class.forName(driver);
	Connection conn = null;
	conn = DriverManager.getConnection(dburl,dbuser,dbpw);
	
	String sql = "SELECT member_id, member_pw FROM member WHERE member_id = ? AND member_pw = PASSWORD(?)";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1,memberId);
	stmt.setString(2,memberPw);
	ResultSet rs = stmt.executeQuery();
	
	if(rs.next()){ //로그인성공
		//세션에 로그인 정보 (memberId)저장
		session.setAttribute("loginMemberId",rs.getString("member_id"));
		String msg = URLEncoder.encode(memberId+"님 안녕하세요","utf-8");
		response.sendRedirect(request.getContextPath()+"/login.jsp?msg="+msg);
	} else { //로그인실패
		String msg = URLEncoder.encode("ID와 비밀번호가 틀렸습니다","utf-8");
		response.sendRedirect(request.getContextPath()+"/login.jsp?msg="+msg);
	}
	
%>