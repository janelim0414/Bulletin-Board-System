<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.io.PrintWriter" %>
    <%@ page import="bbs.BbsDAO" %>
    <%@ page import="bbs.Bbs" %>
    <%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<title>Welcome to My Bulletin Board</title>
</head>
<body>
<%
String userID = null;
if (session.getAttribute("userID") != null) {
	userID = (String) session.getAttribute("userID");
}

BbsDAO bbsDAO = new BbsDAO();

String search = "";
if (request.getParameter("search") != null &&
request.getParameter("search") != "") {
	// set the page number equal to the fed page number
	search = request.getParameter("search");
}

int pageNumber = 1; // both when less than 1 and more than valid value
// if there exists a parameter named "pageNumber" meaning there was an input 
if (request.getParameter("pageNumber") != null) {
	// set the page number equal to the fed page number
	pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
}

int postsPerPage = 5;
if (request.getParameter("postsPerPage") != null &&
request.getParameter("postsPerPage") != "") {
	// set the page number equal to the fed page number
	postsPerPage = Integer.parseInt(request.getParameter("postsPerPage"));
}
int PAGE_LIMIT = 5;

ArrayList<Bbs> list = bbsDAO.getList(search, pageNumber, postsPerPage);
System.out.println(list);
int totalPosts = bbsDAO.getBbsCount(search);
int totalPages = (int)Math.ceil((double)totalPosts/postsPerPage);
int startPost = totalPosts-(pageNumber-1)*postsPerPage;
int currentBlock = (int)Math.ceil((double)pageNumber/PAGE_LIMIT);
int endPage = currentBlock*PAGE_LIMIT;
int startPage = endPage-(PAGE_LIMIT-1);
if (totalPages < endPage)
	endPage = totalPages;
int startPageOfTheEnd = totalPages-(totalPages%PAGE_LIMIT-1);
if (totalPages<PAGE_LIMIT) 
	startPageOfTheEnd = totalPages;
%>

<%
if (userID == null) {
%>

<form method="post" action="loginAction.jsp">
Login:
<br />
<input type="text" class="form-control" placeholder="id" name="userID" maxlength="20">
<br />
<input type="password" class="form-control" placeholder="password" name="userPassword" maxlength="20">
<br />
<input type="submit" value="Login">

</form>
<%
} else {
%>
Hi <%=userID %>!
<form method="post" action="logoutAction.jsp">
<input type="submit" value="Logout">
</form>
<%
} if (userID == null) {
%>

<form method="post" action="registerAction.jsp">
Register:
<br />
<input type="text" class="form-control" placeholder="id" name="userID" maxlength="20">
<br />
<input type="password" class="form-control" placeholder="password" name="userPassword" maxlength="20">
<br />
<input type="text" class="form-control" placeholder="name" name="userName" maxlength="20">
<br />
<input type="text" class="form-control" placeholder="gender" name="userGender" maxlength="20">
<br />
<input type="text" class="form-control" placeholder="email" name="userEmail" maxlength="50">
<br />
<input type="submit" value="Register">

</form>

<%
} else {
%>

<%
} if (userID == null) {
%>
You don't have access to view this board. Please login.
<%} else { %>
<%=totalPosts %> posts in total

<form action="bbs.jsp">
Search by author and content: <input type="text" name="search" value=<%=search%>>
<input type ="submit" value="Search">
</form>

<form action="bbs.jsp" target="_blank">
Number of posts to display: <select name="postsPerPage">
	<option
	<%if (postsPerPage == 5) {
	%>selected
	<%} %>>5
	</option>
	<option
	<%if (postsPerPage == 10) {
	%>selected
	<%} %>>10</option>
	<option
	<%if (postsPerPage == 15) {
	%>selected
	<%} %>>15</option>
	<option
	<%if (postsPerPage == 20) {
	%>selected
	<%} %>>20</option>
	<option
	<%if (postsPerPage == 50) {
	%>selected
	<%} %>>50</option>
	<option
	<%if (postsPerPage == 100) {
	%>selected
	<%} %>>100</option>
</select>
<input type="hidden" name="search" value="<%=search %>">
<input type="submit" value="Submit" >
</form>
	<div class="container">
		<div class="row">
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th style="background-color: #eeeeee; text-align: center;">Number</th>
						<th style="background-color: #eeeeee; text-align: center;">Title</th>
						<th style="background-color: #eeeeee; text-align: center;">Author</th>
						<th style="background-color: #eeeeee; text-align: center;">Date</th>
					</tr>
				</thead>
				<tbody>
				<%
				for (int i = 0; i < list.size(); i++) {
				%>
					<tr>
						<td><%= startPost-i%></td>
						<td><a href="view.jsp?bbsIndex=<%= list.get(i).getBbsIndex() %>"> <%= list.get(i).getBbsTitle() %></a></td>
						<td><%= list.get(i).getBbsAuthor() %></td>
						<td><%= list.get(i).getBbsDate() %></td>
					</tr>
					
				<%
				}
				%>
				</tbody>
			</table>
			<%
			if (pageNumber > 1) {%>
			<a href="bbs.jsp?pageNumber=<%=1%>&postsPerPage=<%=postsPerPage%>&search=<%=search%>" class="btn btn-success btn-arrow-left"> first </a>
			<%
			} 
			if (pageNumber > 1) {
			%>
			<a href="bbs.jsp?pageNumber=<%=pageNumber-1%>&postsPerPage=<%=postsPerPage%>&search=<%=search%>" class="btn btn-success btn-arrow-left">prev</a>
			<%
			} 
			for(int j=startPage; j<=endPage; j++) {
			%>
			<a href="bbs.jsp?pageNumber=<%=j %>&postsPerPage=<%=postsPerPage%>&search=<%=search%>"><%=j %></a>
			<% 
			}
			if (pageNumber < totalPages) {
			%>
			<a href="bbs.jsp?pageNumber=<%=pageNumber+1%>&postsPerPage=<%=postsPerPage%>&search=<%=search%>" class="btn btn-success btn-arrow-right">next</a>
			<%
			} 
			if (pageNumber < totalPages) {
			%>
			<a href="bbs.jsp?pageNumber=<%=startPageOfTheEnd%>&startPage=<%=startPageOfTheEnd %>&postsPerPage=<%=postsPerPage%>&search=<%=search%>" class="btn btn-success btn-arrow-left"> last </a>
			<%} %>
			
			<a href="write.jsp" class="btn btn-primary pull-right">Write</a>
		</div>
	</div>
	<%} %>
</body>
</html>