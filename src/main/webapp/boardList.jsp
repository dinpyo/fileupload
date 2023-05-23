<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "java.sql.*" %>
<%
	// DB연동
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/fileupload","root","java1234");
	
	String totalSql = "SELECT count(*) FROM board b INNER JOIN board_file f ON b.board_no = f.board_no";
	PreparedStatement totalStmt = conn.prepareStatement(totalSql);
	ResultSet totalRs = totalStmt.executeQuery();
	
	//페이징
	int currentPage = 1;
	if(request.getParameter("currentPage")!=null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	//한페이지 당 출력될 게시물의 수
	int rowPerPage = 5;
	//페이지에서 출력될 게시물의 첫번째 번호
	int startRow = (currentPage-1)*rowPerPage;
	//페이지에서 출력될 게시물의 마지막 번호
	int endRow = startRow+(rowPerPage-1);
	int totalRow = 0;
	int lastPage = 0;
	
	if(totalRs.next()){
		totalRow = totalRs.getInt("count(*)");
		System.out.println(totalRow+"<--totalRow");
	}
	
	/*
		SELECT 
		b.board_title boardTitle, f.origin_filename originFilename, f.save_filename saveFilename, path
		FROM board b INNER JOIN board_file f
		ON b.board_no = f.board_no
		ORDER BY b.createdate DESC
	*/
	
	String sql = "SELECT b.board_no boardNo, b.board_title boardTitle, f.board_file_no boardFileNo, f.origin_filename originFilename, f.save_filename saveFilename, path FROM board b INNER JOIN board_file f ON b.board_no = f.board_no ORDER BY b.createdate DESC LIMIT ? , ?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setInt(1,startRow);
	stmt.setInt(2,rowPerPage);
	ResultSet rs = stmt.executeQuery();
	ArrayList<HashMap<String, Object>> list = new ArrayList<>();
	while(rs.next()) {
		HashMap<String, Object> m = new HashMap<>();
		m.put("boardNo", rs.getInt("boardNo"));
		m.put("boardTitle", rs.getString("boardTitle"));
		m.put("boardFileNo", rs.getInt("boardFileNo"));
		m.put("originFilename", rs.getString("originFilename"));
		m.put("saveFilename", rs.getString("saveFilename"));
		m.put("path", rs.getString("path"));
		list.add(m);
	}
	
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	table, th, td {
		border: 1px solid #FF0000;
	}
</style>
</head>
<body>
	<div>
		<jsp:include page="/mainmenu.jsp"></jsp:include>
	</div>

	<h1>PDF 자료 목록</h1>
	<table>
		<tr>
			<td>boardTitle</td>
			<td>originFilename</td>
			<td>수정</td>
			<td>삭제</td>
		</tr>
		<%
			for(HashMap<String, Object> m : list) {
		%>
				<tr>
					<td><%=(String)m.get("boardTitle")%></td>
					<td>
						<!-- a태그 다운로드 속성을 이용하면 참조주소를 다운로드 한다 -->
						<a href="<%=request.getContextPath()%>/<%=(String)m.get("path")%>/<%=(String)m.get("saveFilename")%>" download="<%=(String)m.get("saveFilename")%>">
							<%=(String)m.get("originFilename")%>
						</a>
					</td>
					<td><a href="<%=request.getContextPath()%>/modifyBoard.jsp?boardNo=<%=m.get("boardNo")%>&boardFileNo=<%=m.get("boardFileNo")%>">수정</a></td>
					<td><a href="<%=request.getContextPath()%>/removeBoard.jsp?boardNo=<%=m.get("boardNo")%>&boardFileNo=<%=m.get("boardFileNo")%>">삭제</a></td>
				</tr>
		<%		
			}
		%>
	</table>
	
	<!-- 페이지 네비게이션 -->
	<%
		int pagePerPage = 5;
		int startPage = (currentPage-1)/pagePerPage*pagePerPage+1;
		int endPage = startPage+(pagePerPage-1);
		lastPage = totalRow/rowPerPage;
		if(totalRow%rowPerPage!=0){
			lastPage++;
		}
		if(endPage > lastPage){
			endPage=lastPage;
		}
		%>
		<%
			if(startPage>1){
					
		%>
				<a href="<%=request.getContextPath() %>/boardList.jsp?currentPage=<%=startPage-pagePerPage%>">이전</a>
		<%	
			}
		%>
		<%
			for(int i = startPage; i<=endPage; i++){
		%>
				<a href="<%=request.getContextPath() %>/boardList.jsp?currentPage=<%=i%>"><%=i%></a>
		<%
			}
			if(endPage<lastPage){
		%>
				<a href="<%=request.getContextPath() %>/boardList.jsp?currentPage=<%=pagePerPage+startPage%>">다음</a>
		<%
			}
		%>
</body>
</html>