<%@ page import="bbs.BbsDAO"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Welcome to My Bulletin Board</title>
<style>
table {
width: 300px;
height: 200px;
}
</style>
</head>
<body>
<%
int bbsIndex = 0;
//if there exists a parameter named "bbsIndex" meaning there was an input aka there is an article to be opened
if (request.getParameter("bbsIndex") != null) {
	// set the page number equal to the fed page number
	bbsIndex = Integer.parseInt(request.getParameter("bbsIndex"));
}
// there is no such article
if (bbsIndex == 0) {
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('no such article exists')");
	script.println("location.href = 'bbs.jsp'");
	script.println("</script>");
}
Bbs bbs = new BbsDAO().getBbs(bbsIndex);
%>
	<!-- writing page -->
	<div class="container">
		<div class="row">
				<table class="table" style="text-align: left; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="3" style="background-color: #eeeeee; text-align:center;">View Article</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width:20%;"> Title </td>
						<td colspan="2"> <%=bbs.getBbsTitle() %> </td>
					</tr>
					<tr>
						<td> Author </td>
						<td colspan="2"> <%=bbs.getBbsAuthor() %> </td>
					</tr>
					<tr>
						<td> Date </td>
						<td colspan="2"> <%=bbs.getBbsDate() %> </td>
					</tr>
					<tr>
						<td> Content </td>
						<td colspan="2" style="min-height: 200px; text-align: left;"> <%=bbs.getBbsContent() %> </td>
					</tr>
				</tbody>
			</table>
			<a href="bbs.jsp" class="btn btn-primary">back to list</a>
			<a href="edit.jsp?bbsIndex=<%=bbsIndex %>" class="btn btn-primary">edit</a>
			<a href="deleteAction.jsp?bbsIndex=<%=bbsIndex %>" class="btn btn-primary">delete</a>
		</div>
	</div>
	<!-- end of writing page -->
</body>
</html>