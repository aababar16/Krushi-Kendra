<%@page import="java.sql.ResultSet"%>
<%@ include file="header.jsp" %>



<script>
$(document).ready(function(){
	$("#table1").DataTable({
		dom:"Blfrtip",
		buttons:["copy","pdf","excel","print","csv"]
	}); 
	
	
});
</script>
<%
String msg="";
DataAccess db=new DataAccess();
String sql="select * from Users where UserType='Farmer'";
if(request.getParameter("id")!=null)
{
	db.executeSql("delete from Users where MobileNo=?",request.getParameter("id"));
	response.sendRedirect("farmer.jsp");
}

%>
	<!-- Main -->
	<div id="main-wrapper">



		<div class="container">
			<div id="main">
			<div class="row">
			<h1 style="font-size:25pt">Registered Farmers</h1>
			</div>	
				<div class="row">
					<div class="col-md-10 col-md-offset-1">
					<table id="table1" class="table table-bordered table-striped">
					<thead>
					<tr>					
					<td>Name</td>
					<td>Address</td>
					<td>City</td>
					<td>State</td>
					<td>Details</td>
					<td>MobileNo</td>
					<td>EmailID</td>
					</tr>
					</thead>
					<tbody>
					<%
					ResultSet rs=db.getRows(sql);
					while(rs.next()){
					%>
					<tr>
					<td><%=rs.getString(2)%></td>
					<td><%=rs.getString(3)%></td>
					<td><%=rs.getString(4)%></td>
					<td><%=rs.getString(5)%></td>
					<td><%=rs.getString(6)%></td>
					<td><%=rs.getString(7)%></td>
					<td><%=rs.getString(8)%></td>
					<td><button class="btn btn-danger" onclick="if(confirm('Do you want to delete current record?'))window.location='?id=<%=rs.getString(7)%>';">Delete</button></td>
					</tr>
					<%	
					}					
					%>
					</tbody>
					</table>						
					</div>

				</div>
			</div>
		</div>
	</div>
	<!-- /Main -->

<%@ include file="footer.jsp" %>