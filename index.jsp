<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login Page</title>
<link rel="stylesheet" href="Form.css">
</head>
<body >
<div class=form-area>
<form action="Login.jsp" method=post>
<h1 align="center">Login Page</h1>
			<p>USERID: </p>
			<input type="text" name="user" placeholder="Enter your userid" required>
		<br>
		<p>PASSWORD:</p> 
			<input type="password" name="pwd" placeholder="Enter your Password" required>
		<br>
		
	
			<input type="submit" value="Login">
			
	</form>
	<form action="Reg.html">
	<input type="submit" value="Registration">
	</form>
	</div>
	<h2>
	<%
    if(null!=request.getAttribute("errorMessage"))
    {
        out.println(request.getAttribute("errorMessage"));
    }
%></h2>
</body>
</html>