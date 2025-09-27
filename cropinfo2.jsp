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
String msg="";
DataAccess db=new DataAccess();
String sql="select * from CropInfo";
String selcrop="";

%>
	<!-- Main -->
	<div id="main-wrapper">



		<div class="container">
			<div id="main">				
				<div class="row">
					<div class="col-md-10 col-md-offset-1">
					<table id="table1" class="table table-bordered table-striped">
					<thead>
					<tr>
					<td>Crop Id</td>
					<td>Crop Name</td>
					<td>Crop Category</td>
					<td>Crop Image</td>
					<td>Crop information</td>					
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
					<td><img src="<%=rs.getString(4)%>" width="60" height="60" alt="NA"/></td>
					<td><a href="<%=rs.getString(5)%>">View Crop Info</a></td>					
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