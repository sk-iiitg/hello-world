<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Show</title>
</head>
<body  style="background-color:red;">
<%@ page import="java.sql.*,java.io.*"%>
<%int flag=1,fare=1,sheat=0; %>
<%String busid=null; %>
	
		
	<% 	String from = request.getParameter("from");%>
	<% 	String to = request.getParameter("to"); %>
	<% 	String date=request.getParameter("date");	%>	
	<%  String no=request.getParameter("no");    %>
	<% 	Connection connect = null;              %>
		<% Statement statement = null; %>
	<% 	ResultSet resultSet = null; %>
	<%	try {

		// set path
		Class.forName("com.mysql.jdbc.Driver");

		connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/sushil","root","");
		statement = connect.createStatement();

		// prepare query for first result
		resultSet = statement.executeQuery("select * from transport where place = '" + from +"'and dest= '" +to+ "'and doj= '" +date+"'and St>= '" +no+ "' ");
		//resultSet.next();

		
		while(resultSet.next()){
		String place = resultSet.getString(1);
		String  dest= resultSet.getString(2);
		String doj = resultSet.getString(3);%>
		 
	<% 	 sheat = resultSet.getInt(4);%>
	<% 	 busid=resultSet.getString(5);
		  fare=resultSet.getInt(6);
		fare=fare*Integer.parseInt(no);
		
		//out.println("Welcome: "+ userName);
		
		
		//session.setAttribute("uNa",userName); 
		//String redirectURL = "welcome.jsp";
			//response.sendRedirect(redirectURL);
			flag =1;
		}
			
		
	//	if(flag==0){
			//out.println("Wrong user id or password");
		//response.sendRedirect("Hello.jsp");
//session.invalidate();
  //              request.setAttribute("errorMessage", "Invalid user or password");
    //            RequestDispatcher rd = request.getRequestDispatcher("/Hello.jsp");
      //          rd.forward(request, response); 
		//String redirectURL = "Hello.jsp";
		
		//}


		statement.close();
		connect.close();
	} catch (Exception e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}  
		// TODO Auto-generated catch block
		
	
%>
<% if(flag==1) {%>
<h2 align="center"><%=sheat %>  vacant Sheat is available for you </h2>
 <h2>     Fare is=         <%=fare %>  </h2>
 <%session.setAttribute("from",from); %> 
  <%session.setAttribute("to",to); %>
   <%session.setAttribute("date",date); %>
    <%session.setAttribute("busid",busid); %>
    <% session.setAttribute("no",no); %>                  
<a href="Book.jsp">Click here for confirm</a>
<%}else { %>
<h2 align="center">No available Sit  </h2>
<p> go back and Redecide your Schedule</p>
<%} %>


			
			

</body>
</html>