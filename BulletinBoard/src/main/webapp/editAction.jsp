<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="bbs.Bbs" %>
    <%@ page import="bbs.BbsDAO" %>
    <%@ page import="java.io.PrintWriter" %>
    
    <!--enables encoding Korean texts-->
    <% request.setCharacterEncoding("UTF-8"); %>
    
<!DOCTYPE html>
<html>
<head>
<title>Welcome to My Bulletin Board</title>
</head>
<body>
<% 
int bbsIndex = 0;
//if there exists a parameter named "bbsIndex" meaning there was an input aka there is an article to be opened
if (request.getParameter("bbsIndex") != null) {
	// set the page number equal to the fed page number
	bbsIndex = Integer.parseInt(request.getParameter("bbsIndex"));
}
//there is no such article
if (bbsIndex == 0) {
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('no such article exists')");
	script.println("location.href = 'bbs.jsp'");
	script.println("</script>");
}
Bbs bbs = new BbsDAO().getBbs(bbsIndex);
// if there is no input made by the user:
String emp = "";
if (bbs.getBbsTitle() == null || bbs.getBbsContent() == null || bbs.getBbsAuthor() == null ||  bbs.getBbsDate() == null ||
emp.equals(bbs.getBbsTitle()) || emp.equals(bbs.getBbsContent()) || emp.equals(bbs.getBbsAuthor()) || emp.equals(bbs.getBbsDate())) {
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('Cannot upload an empty article.')");
	script.println("history.back()");
	script.println("</script>");
} 
// if there is input:
else {
	BbsDAO bbsDAO = new BbsDAO();
	System.out.println("bbsAuthor="+bbs.getBbsAuthor());
	int result = bbsDAO.edit(bbs.getBbsIndex(), bbs.getBbsTitle(), bbs.getBbsContent(), bbs.getBbsAuthor(), bbs.getBbsDate());
	// edit method threw an exception, failed to insert data to db
	if (result == -1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('Failed to edit. Please try again.')");
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