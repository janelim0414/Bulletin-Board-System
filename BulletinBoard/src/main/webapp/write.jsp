<%@ page import="bbs.BbsDAO"%>
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
	<!-- writing page -->
	<div class="container">
		<div class="row">
			<form method="post" action="writeAction.jsp">
				<table class="table" style="text-align: left; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="1" style="background-color: #eeeeee; text-align:center;">Article Format</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><input type="text" class="form-control" placeholder="Author" name="bbsAuthor" maxlength="50"></td>
					</tr>
					<tr>
						<td><input type="text" class="form-control" placeholder="Title" name="bbsTitle" maxlength="50"></td>
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
						<td><textarea class="textbox" placeholder="Content" name="bbsContent" rows="4" cols="30"></textarea></td>
					</tr>
				</tbody>
			</table>
			<input type="submit" class="btn btn-primary pull-right" value="Submit">
			
			</form>
			
		</div>
	</div>
	<!-- end of writing page -->
</body>
</html>