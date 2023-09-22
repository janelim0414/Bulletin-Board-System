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
			<form method="post" action="editAction.jsp?bbsIndex=<%= bbs.getBbsIndex()%>">
				<table class="table" style="text-align: left; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="1" style="background-color: #eeeeee; text-align:center;">Edit Article</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><input type="text" class="form-control" placeholder="Author" name="bbsAuthor" maxlength="50" value="<%=bbs.getBbsAuthor()%>"></td>
					</tr>
					<tr>
						<td><input type="text" class="form-control" placeholder="Title" name="bbsTitle" maxlength="50" value="<%=bbs.getBbsTitle()%>"></td>
					</tr>
					<tr>
						<td>
						<input type="text" name="bbsDate" id="bbsDate">
						<script>
  						var today = new Date();
 					 	var now = today.getFullYear()+'-'+(today.getMonth()+1)+'-'+today.getDate()
 					 	+' '+today.getHours()+':'+today.getMinutes()+':'+today.getSeconds();
  						document.getElementById("bbsDate").value = now;
						</script>
						</td>
					</tr>
					<tr>
						<td><textarea class="textbox" placeholder="Content" name="bbsContent" rows="4" cols="30"><%=bbs.getBbsContent()%></textarea></td>
					</tr>
				</tbody>
			</table>
			<input type="submit" class="btn btn-primary pull-right" value="Update">
			
			</form>
			
		</div>
	</div>
	<!-- end of writing page -->
</body>
</html>