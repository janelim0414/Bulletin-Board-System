<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	BbsDAO bbsDAO = new BbsDAO();
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
	script.println("alert('Error! You're trying to access a post that doesn't exist.')");
	script.println("location.href = 'bbs.jsp'");
	script.println("</script>");
}
	int result = bbsDAO.delete(bbsIndex);
	System.out.println("result="+result);
	// write method threw an exception, failed to insert data to db
	if (result == -1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('Sorry, failed to delete. Please try again.')");
		script.println("history.back()");
		script.println("</script>");
	}
	if (result == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('You're trying to delete a post that doesn't exist. Good try tho :)')");
		script.println("history.back()");
		script.println("</script>");//if result==0, such article dne
	}
	// successfully saved data, update board
	else {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('Woohoo! Successfully deleted :)')");
		script.println("location.href = 'bbs.jsp'");
		script.println("</script>");
	}
%>
</body>
</html>