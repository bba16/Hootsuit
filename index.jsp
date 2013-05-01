 <%@ page import="hoot.suit.*" %>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=utf-8"  
pageEncoding="utf-8" %>
 <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN"
   "http://www.w3.org/TR/html4/strict.dtd">
<html lang="en">
<head>
<link rel="stylesheet" href="hootSuite.css" />

<title>Phone Book</title>
</head>
<body style="color:black;">

<% 
	String action = request.getParameter("action");
	if (action == null) {
 %>
<a href="?action=req_add">Add a new Entry</a> <br/>
<a href="?action=list">List All Entries</a> <br/>
<a href="?action=req_search">Look up a contact</a>
<%
	} else if (action.equals("req_add")) {
		%>
		 <form id="entries">
		<div class="well form-inline" style="background-color:rgba(245, 245, 245, 0); margin-bottom:0px;">
		  <div class="control-group" >  
           
            <div class="controls">  
              <input style ="margin:0px 10px 10px 80px;width: 468px; color:black; " placeholder="Enter Name" size="140" type="text" name="name" class="required"/>  
              </div> 
			 <span class="countdown"></span> 
            <div class="control">  
              <input style="margin:0px 10px 10px 80px;width: 468px;" class="message input-xlarge" placeholder="Enter Phone Number " name="phone"  class="required"/>  
            </div> 	
			<div class="controls">  
              <input style ="margin:0px 10px 10px 80px;width: 468px; color:black; " placeholder="Twitter URL" size="140" type="text" name="twitter" class="required"/>  
              </div>			
          </div>
          	<input type="hidden" name= "action" value="add">
          <input type="submit"/>	
          	<a href="/phone/index.jsp">Go Back</a>	
</div>
</form> 
		<!-- <form>
		Name <input type="text" name="name"/></br>
		Phone <input type="text" name="phone"/></br>
		Twitter <input type="text" name="twitter"/></br>
		<input type="hidden" name= "action" value="add">
		<input type="submit"/>	
		</form> 
		<a href="/phone/index.jsp">Go Back</a>	 -->	
		<%
	} else if (action.equals("add")) {
		try {
			Contact contact = new Contact(request.getParameter("name"), request.getParameter("phone"), request.getParameter("twitter"));
			DataBase db = new DataBase();
			db.open();
			db.add(contact);
			db.close();
			out.println("Contact added successfully<br/>");
		} catch (Exception e){
			out.println("Add Failed<br/>");
			out.println(e.toString());
		}
		%>
		<a href="/phone/index.jsp">Go Back</a>		
		<%
	} else if (action.equals("list")) {
		try {
			DataBase db = new DataBase();
			db.open();
			Vector<Contact> contacts = db.getAll();
			db.close();
			if (!contacts.isEmpty()) {
				%>
					<table>
					<tr><th>Name</th><th>Phone</th><th>Twitter</th></tr>
				<% 
				for (Contact contact: contacts) {
					out.println("<tr><td>" + contact.getName() +
					"</td><td>" + contact.getPhone() +
					"</td><td>" + contact.getTwitter() + "</td></tr>");
				}
				%>
					</table>
				<% 
			} else {
				out.println("Now Entries available</br>");
			}
		} catch (Exception e) {
			out.println("Listing Failed<br/>");
			out.println(e.toString());		
		} 
		%>
		<a href="/phone/index.jsp">Go Back</a>		
		<%
	} else if (action.equals("req_search")) {
		%>
		<form>
		Name <input type="text" name="name"/></br>
				<input type="hidden" name= "action" value="search">
		<input type="submit"/>
		</form>
		<a href="/phone/index.jsp">Go Back</a>		
		<%
	} else if (action.equals("search")) {
		try {
			DataBase db = new DataBase();
			db.open();
			Contact contact = db.getContact(request.getParameter("name"));
			db.close();
			if (contact != null) {
				out.println("Name: " + contact.getName() + "</br>");
				out.println("Phone: " + contact.getPhone() + "</br>");
				out.println("Twitter: " + contact.getTwitter() + "</br>");
			} else {
				out.println("Name not found.</br>");
			}
		} catch (Exception e) {
			out.println("Search Failed<br/>");
			out.println(e.toString());					
		}
		%>
		<a href="/phone/index.jsp">Go Back</a>		
		<%
	}
%>
</body>
</html>