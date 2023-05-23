<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String msg = request.getParameter("msg");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		if(msg != null) {
	%>
			<%=msg%>
	<%
		}
	%>
	
	<!-- 메인메뉴 (가로) -->
	<div>
		<jsp:include page="/mainmenu.jsp"></jsp:include>
	</div>
	
	<%
		if(session.getAttribute("loginMemberId")==null){			
	%>
			<form action="<%=request.getContextPath()%>/loginAction.jsp" method="post">
				<table>
					<tr>
						<th>아이디</th>
						<td><input type="text" name="memberId" required="required"></td>		
					</tr>	
					<tr>
						<th>비밀번호</th>
						<td><input type="password" name="memberPw" required="required"></td>		
					</tr>	
					<tr>
						<td colspan="2">
							<button type="submit">로그인</button>
						</td>
					</tr>	
				</table>
			</form>		
	<%
		} else {
	%>
			<a href="<%=request.getContextPath()%>/addBoard.jsp">파일 업로드</a>	
	<%		
		}
	%>
	


</body>
</html>