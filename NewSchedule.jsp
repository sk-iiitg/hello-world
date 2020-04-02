<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body style="background-image:green;">

<form action="Registration.jsp" method=post>
<h1 align="center">New Bus Arrangement page</h1>
			<p>BusId: </p>
			<input type="text" name="busid" placeholder="Enter Busid">
		<br>
		<p>From:</p> 
			<input type="text" name="from" placeholder="Enter starting point">
		<br>
		<p>To:</p> 
			<input type="text" name="to" placeholder="Enter destination point"><br>
			<p>Date</p> 
			<input type="text" name="date" placeholder="Enter date"><br>
			<p>No of sit:</p> 
			<input type="text" name="no" placeholder="Enter no sit"><br>
			<p>Fare:</p> 
			<input type="text" name="fare" placeholder="Enter fare">
	
			<input type="submit" value="Submit">
			</form>
</body>
</html>