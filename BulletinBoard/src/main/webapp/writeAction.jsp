<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="bbs.BbsDAO" %>
    <%@ page import="java.io.PrintWriter" %>
    
    <!--enables encoding Korean texts-->
    <% request.setCharacterEncoding("UTF-8"); %>
    
    <jsp:useBean id="bbs" class="bbs.Bbs" scope="page"/>
    <jsp:setProperty name="bbs" property="bbsTitle"/>
    <jsp:setProperty name="bbs" property="bbsContent"/>
    <jsp:setProperty name="bbs" property="bbsAuthor"/>
    <jsp:setProperty name="bbs" property="bbsDate"/>
<!DOCTYPE html>
<html>
<head>
<title>Welcome to My Bulletin Board</title>
</head>
<body>
<% 
// if there is no input made by the user:
if (bbs.getBbsTitle() == null || bbs.getBbsContent() == null || bbs.getBbsAuthor() == null ||  bbs.getBbsDate() == null) {
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('Cannot upload an empty article.')");
	script.println("history.back()");
	script.println("</script>");
} 
// if there is input:
else {
	BbsDAO bbsDAO = new BbsDAO();
	int result = bbsDAO.write(bbs.getBbsTitle(), bbs.getBbsContent(), bbs.getBbsAuthor(), bbs.getBbsDate());
	// write method threw an exception, failed to insert data to db
	if (result == -1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('Failed to upload. Please try again.')");
		script.println("history.back()");
		script.println("</script>");
	}
	// successfully saved data, update board
	else {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'bbs.jsp'");
		script.println("</script>");
	}
}
%>
</body>
</html>