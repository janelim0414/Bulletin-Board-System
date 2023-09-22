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
	String userID = null;
	BbsDAO bbsDAO = new BbsDAO();
	PrintWriter script = response.getWriter();
	
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	
	if (userID != null) {
		script.println("<script>");
		script.println("alert('you're already logged in. please logout and try again.')");
		script.println("location.href = 'bbs.jsp'");
		script.println("</script>");
	}
	
	int result = bbsDAO.login(user.getUserID(), user.getUserPassword());
	if (result == 1) {
		// create session
		session.setAttribute("userID", user.getUserID());
		
		script.println("<script>");
		script.println("alert('successfully logged in!')");
		script.println("location.href = 'bbs.jsp'");
		script.println("</script>");
	}
	else if (result == 0) {
		script.println("<script>");
		script.println("alert('uh-oh wrong password!')");
		script.println("history.back()");
		script.println("</script>");
	}
	else if (result == -1) {
		script.println("<script>");
		script.println("alert('seems you're new. please register to get logged in!')");
		script.println("history.back()");
		script.println("</script>");
	}
	else if (result == -2) {
		script.println("<script>");
		script.println("alert('sorry, our database threw an error')");
		script.println("history.back()");
		script.println("</script>");
	}
	%>
</body>
</html>