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
if(request.getParameter("addbtn")!=null){
	int i=db.executeSql("Insert into states values(?)", request.getParameter("sname"));
	if(i>0){
		msg="State Information is Saved.....";
	}else{
		msg="Error Saving State Information......";
	}
}
else{
if(request.getParameter("s")!=null)
{
	db.executeSql("delete from States where StateName=?",request.getParameter("s"));
	out.println("<script>alert('State information is deleted');</script>");
}
}
%>

<script>
$(document).ready(function(){
	$("#form1").validate({
		rules:{
			sname:{
				required:true,
				pattern:/^[A-Za-z ]+$/
			}
		},
		messages:{
			sname:{
				required:"State Name is Required",
				pattern:"Please enter only chars and spaces in State Name"
			}
		}
		
	});
	
});
</script>
	<!-- Main -->
	<div id="main-wrapper">



		<div class="container">
			<div id="main">

				<div class="row">
					<div class="col-md-7 col-md-offset-3">

						<form name="form1" id="form1" method="post" action="">
							<div class="panel panel-primary">
								<div class="panel-heading">
									<h3 class="panel-title">State Entry Form</h3>
								</div>
								<div class="panel-body">

									<div class="form-group">
										State<br> <input type="text" id="sname" name="sname"
											class="form-control" />
									</div>
									<input type="submit" value="Save" id="addbtn" name="addbtn"
										class="btn btn-primary"> <br> <span
										style="color: red; font-weight: bold " id="s1"><%=msg%></span>
								</div>
							</div>
						</form>
					</div>

				</div>
				<div class="row">
					<div class="col-md-7 col-md-offset-3">
					<table id="table1" class="table table-bordered table-striped">
					<thead>
					<tr>
					<th>State Name</th>
					<th>Delete</th>
					</tr>
					</thead>
					<tbody>
					<%
					ResultSet rs=db.getRows("select * from States");
					while(rs.next()){
					%>
					<tr>
					<td><%=rs.getString(1)%></td>
					<td><button class="btn btn-danger" onclick="if(confirm('Do you want to delete current record?'))window.location='?s=<%=rs.getString(1)%>';">Delete</button></td>
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
	<input type="button" id="pdf" value="Export to PDF"/>

<%@ include file="footer.jsp" %>