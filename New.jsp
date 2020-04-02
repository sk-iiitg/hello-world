<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%int x=5; %>
  <h3>Today's date: <%= x%></h3>
  <% if(x==4){%>
<p> good boy </p>

<% } else  %>

<% { %><p> not a good boy </p>
<%} %>
</body>
</html>