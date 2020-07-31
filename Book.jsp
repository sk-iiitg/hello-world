<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Kitab Khuli Hai</title>
</head>
<body style="background-color:tomato;">

<%String from=(String)session.getAttribute("from"); %>
<%String to=(String)session.getAttribute("to"); %>
<% String date=(String)session.getAttribute("date"); %>
<%String busid=(String)session.getAttribute("busid"); %>
<h1>Your Ticket has been booked!!!!! </h1><br>
<h1 align="center">Busid is:<%=busid %> </h1>
<h1>Started from:<%=from %></h1>
<h1>Destination:<%=to %></h1>
<h1> Date of journey<%=date %></h1>

<%@ page import="java.sql.*,java.io.*" %>
<% Connection connect=null;
ResultSet resultSet=null;;
Statement statement=null;
String St=(String)session.getAttribute("busid");
Class.forName("com.mysql.jdbc.Driver");
connect=DriverManager.getConnection("jdbc:mysql://localhost:3306/sushil","root","");
statement=connect.createStatement();
resultSet=statement.executeQuery("select St from transport where busid='"+St+"'");
resultSet.next();
String s=resultSet.getString("St");
int ss=Integer.parseInt(s);
String no=(String)session.getAttribute("no");
int nn=Integer.parseInt(no);
int set=ss-nn;
String val=Integer.toString(set);
statement.executeUpdate("Update transport set St ='"+val+"' where busid='"+St+"'");

 %>

</body>
</html>
