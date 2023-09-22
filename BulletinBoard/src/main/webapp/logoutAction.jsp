<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Welcome to My Bulletin Board</title>
</head>
<body>
	<%
	session.invalidate();
	%>
	<script>
	location.href = 'bbs.jsp';
	</script>
</body>
</html>