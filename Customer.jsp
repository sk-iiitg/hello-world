<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%@ page import="java.sql.*,java.io.*" %>
<%vcbc
try{
String user=request.getParameter("user");
String Name  =request.getsssParameter("Name");
String Add=request.getParameter("Add");
String pwd=request.getParameter("pwd");

Connection connect=null;
PreparedStatement preparedStatement=null;
Statement statement=null;
Class.forName("com.mysql.jdbc.Driver");
connect=DriverManager.getConnection("jdbc:mysql://localhost:3306/sushil","root","");

preparedStatement = connect.prepareStatement("insert into  SK values (?,?,?,?,?)");
preparedStatement.setString(1,user);
preparedStatement.setString(2,Name);
out.println(user);
preparedStatement.setString(3,pwd);
preparedStatement.setString(4,"Customer");
preparedStatement.setString(5,Add);
preparedStatement.executeUpdate();
}
catch(Exception e)
{out.println(e);
	
}
%>

<h1 align="center">Your Account is Registered </h1><br>
<a href="Hello.jsp">Go To Login Page </a>
</body>
</html>
