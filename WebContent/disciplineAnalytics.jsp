<%@page import="com.cse135project.*, java.util.*, java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Discipline Analytics</title>
		<!-- connect to the database -->
			<% 
				Connection db = DBConnection.dbConnect();
				
			%>
	</head>
	<body>
		<h3>Provide Degrees - Choose University</h3>
		<!-- Provide an option for the user to add his or her own university. -->
		 
		

		<!-- print out a 3-column table of the discipline name and the number of applicants for
		that discipline -->
		<table>
			<tr>
			<% 
				PreparedStatement sql = db.prepareStatement("SELECT t.ID, t.name, count (DISTINCT s.applicant) FROM disciplines t, degrees s WHERE t.ID = s.discipline GROUP BY t.ID, t.name");
				
				ResultSet rset = sql.executeQuery();
			
				int i = 0;
	            while (rset.next()) {
	        %>
	        		<% if (i % 3 == 0 && i > 0) { %>
						</tr><tr>
					<% } %>
					<td>
						<%= rset.getString(2)%>
					</td>
					
					<td>
					<a href = "specializationAnalytics.jsp?chosenDiscipline=<%= rset.getString(1) %>"> 
							<%= rset.getInt(3) %> 
						</a>
					</td>
	        <% 		
	        		i++;
	           } 
	            
	            rset.close();
	            sql.close();
	            db.close();
	        %>
			</tr>
		</table>
	</body>
</html>