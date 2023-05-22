<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "com.oreilly.servlet.MultipartRequest" %>
<%@ page import = "com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.io.*" %>
<%@ page import = "java.sql.*" %>

<%
	String dir = request.getServletContext().getRealPath("/upload");	
	int max = 10 * 1024 * 1024;
	MultipartRequest mRequest = new MultipartRequest(request, dir, max, "utf-8", new DefaultFileRenamePolicy());
		
	int boardNo = Integer.parseInt(mRequest.getParameter("boardNo"));
	String saveFilename = mRequest.getParameter("saveFilename");
	
	System.out.println(boardNo + " <-- boardNo");
	System.out.println(saveFilename + " <--saveFilename");
	
	// 업로드 폴더에 해당 파일 삭제
	File f = new File(dir + "/" + saveFilename);
	if (f.exists()){
		f.delete();
		System.out.println(saveFilename + "파일삭제");
	}
	
	// DB연동
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/fileupload","root","java1234");
	
	// DB 삭제
	String boardSql = "DELETE FROM board WHERE board_no = ?";
	PreparedStatement boardStmt = conn.prepareStatement(boardSql);
	boardStmt.setInt(1, boardNo);
	int boardRow = boardStmt.executeUpdate();
	
	if(boardRow == 1){
		System.out.println("삭제 성공");
		response.sendRedirect(request.getContextPath()+"/boardList.jsp");
	}else{
		System.out.println("삭제 실패");
		response.sendRedirect(request.getContextPath()+"/boardList.jsp");
		
	}




%>