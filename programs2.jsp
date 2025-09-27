<%@page import="java.sql.ResultSet"%>
<%@ page language="java" import="javazoom.upload.*,java.util.*" %>
<jsp:useBean id="upBean" scope="page" class="javazoom.upload.UploadBean" >
  <jsp:setProperty name="upBean" property="folderstore" value='<%=request.getRealPath("/")%>' />
</jsp:useBean>
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
DataAccess db=new DataAccess();
String sql="select * from Programmes";

%>
	<!-- Main -->
	<div id="main-wrapper">



		<div class="container">
			<div id="main">

				
				<div class="row">
					<div class="col-md-10">
					<table id="table1" class="table table-bordered table-striped">
					<thead>
					<tr>
					<td>ID</td>
					<td>Category</td>
					<td>Title</td>
					<td>PDF</td>				
					
					</tr>
					</thead>
					<tbody>
					<%
					ResultSet rs=db.getRows(sql);
					while(rs.next()){
					%>
					<tr>
					<td><%=rs.getString(1)%></td>
					<td><%=rs.getString(2)%></td>
					<td><%=rs.getString(3)%></td>
					<td><a target="_blank" href="<%=rs.getString(4)%>">Info</a></td>					
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