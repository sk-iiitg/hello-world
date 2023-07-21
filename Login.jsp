<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Welcome Page</title>
</head>
<body style="background-color:powderblue">
<%@ page import="java.sql.*,java.io.*"%>
<%int flag1=0,flag2=0; %>
<%String usercvcvName=null; %>
<h2 align="center">
<%
response.setHeader("Cachccvce-Control","no-cache,no-store,must-revalidate");
	// TODO Auto-generated method stub
		// get request parameters for userID and password
		String id = request.getParameter("usrnm");
		String pwd = request.getParameter("psw");
		//String type=request.getParameter("type");		
		Connection connect = null;
		Statement statement = null;
		ResultSet resultSet = null;

		try {

			// set path
			Class.forName("com.mysql.jdbc.Driver");

			connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/sushil","root","");
			statement = connect.createStatement();

			// prepare query for first result
			resultSet = statement.executeQuery("select * from SK where userID = '" + id +"'");
			//resultSet.next();

			 flag1 = 0;
			while(resultSet.next()){
			String userId = resultSet.getString(1);
			 userName = resultSet.getString(2);
			 out.println(userName);
			String userPwd = resultSet.getString(3);
			String Type = resultSet.getString(4);
			if(pwd.equals(userPwd)){
              
			
	
			//session.setAttribute("uName",userName); 
			//String redirectURL = "welcome.jsp";
				//response.sendRedirect(redirectURL);
				flag1 =1;
			}
				
				
			}
				
			
			//if(flag1==0){
				//out.println("Wrong user id or password");
			//response.sendRedirect("Hello.jsp");
// session.invalidate();
  //                  request.setAttribute("errorMessage", "Invalid user or password");
    //                RequestDispatcher rd = request.getRequestDispatcher("/Hello.jsp");
      //              rd.forward(request, response); 
			//String redirectURL = "Hello.jsp";
			
			//}


			statement.close();
			connect.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
	%></h2>	
	
	<% if(flag1==1&&flag2==1){ %>
	
<div class=form-area>;
<h1 align="center" style="color:red;">Welcome: <%=id %> </h1>
<h1> Enter your journey detail</h1>
<form action="Show.jsp">
<p>FROM:</p>
			 
			<input type="text" name="from" placeholder="Enter your place">
		<br>
		<p>TO:</p> 
			<input type="text" name="to" placeholder="Enter your destination">
		<br>
	<p> 	No of Ticket</p>
	<input type="text" name="no" placeholder="No of Ticket do you want">
		
	<p>	Date of journey</p>
	<input type="text" name="date" placeholder="dd/mm/yyyy">
			<input type="submit" value=" Show ">
	<a href="Hello.jsp">SignOut</a>		
	</form>
	
	</div>
	<% }else if(flag1==1&&flag2==0) { %>
	<h1 align="center"> Ready For Exam :<%=id %></h1><br>
	
	<%}else{ %>
	<h1 align="center" >Wrong UserId or Password </h1>
	
	<a href="Hello.jsp">Go to login page </a>
	<%} %>
	
	
	
</body>
</html>
