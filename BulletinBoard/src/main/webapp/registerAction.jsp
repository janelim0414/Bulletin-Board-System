<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="bbs.BbsDAO" %>
    <%@ page import="java.io.PrintWriter" %>
    
    <!--enables encoding Korean texts-->
    <% request.setCharacterEncoding("UTF-8"); %>
    
    <jsp:useBean id="user" class="bbs.User" scope="page"/>
    <jsp:setProperty name="user" property="userID"/>
    <jsp:setProperty name="user" property="userPassword"/>
    <jsp:setProperty name="user" property="userName"/>
    <jsp:setProperty name="user" property="userGender"/>
    <jsp:setProperty name="user" property="userEmail"/>
<!DOCTYPE html>
<html>
<head>
<title>Welcome to My Bulletin Board</title>
</head>
<body>
	<%
	
	PrintWriter script = response.getWriter();
	
	// if there is no input made by the user:
	if (user.getUserID() == null || user.getUserPassword() == null || user.getUserName() == null || user.getUserGender() == null || user.getUserEmail() == null) {
		script.println("<script>");
		script.println("alert('please fill in all information!')");
		script.println("history.back()");
		script.println("</script>");
	} 
	// if there is input:
	else {
		BbsDAO bbsDAO = new BbsDAO();
		int result = bbsDAO.register(user.getUserID(), user.getUserPassword(), user.getUserName(), user.getUserGender(), user.getUserEmail());
		// register method threw an exception, failed to insert data to db
		if (result == -1) {
			script.println("<script>");
			script.println("alert('failed to register')");
			script.println("history.back()");
			script.println("</script>");
		}
		// successfully saved data, update board
		else {
			// create session
			session.setAttribute("userID", user.getUserID());
			
			script.println("<script>");
			script.println("alert('woohoo! successfully registered')");
			script.println("location.href = 'bbs.jsp'");
			script.println("</script>");
		}
	}
	%>
</body>
</html>