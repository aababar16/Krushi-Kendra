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
String sql="select * from cities";
String selstate="";
if(request.getParameter("addbtn")!=null)
{
	selstate=request.getParameter("sname");
	db.executeSql("Insert into cities values(?,?)",request.getParameter("sname"),request.getParameter("cname"));	
}
else if(request.getParameter("s")!=null)
{
	db.executeSql("delete from cities where StateName=? and CityName=?",request.getParameter("s"),request.getParameter("c"));
	response.sendRedirect("cities.jsp");
}
else if(request.getParameter("sname")!=null)
{
	selstate=request.getParameter("sname");
	sql="select * from cities where statename='"+request.getParameter("sname")+"'";
}
%>
<script>
$(document).ready(function(){
	$("#form1").validate({
		rules:{
			sname:{
				required:true			
			},
			cname:{
				required:true,
				pattern:/^[A-Za-z ]+$/
			}
		},
		messages:{
			sname:{
				required:"State Name is Required"
			},
			cname:{
				required:"City Name is Required",
				pattern:"Please enter only chars and spaces in City Name"
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
									<h3 class="panel-title">City Entry Form</h3>
								</div>
								<div class="panel-body">

									<div class="form-group">
										State<br>
										<select name="sname" class="form-control" id="sname" onchange="form1.submit();"> 
										<option  value="">-- Select State --</option>
										<%
										ResultSet rs=db.getRows("select * from States");
										while(rs.next()){
										%>
										<option <%=selstate.equals(rs.getString(1))?"selected":""%>  value="<%=rs.getString(1)%>"><%=rs.getString(1)%></option>
										<%
										}
										%>
										</select>
									</div>
									<div class="form-group">
										City<br> <input type="text" id="cname" name="cname"
											class="form-control" />
									</div>
									<input type="submit" value="Save" id="addbtn" name="addbtn"
										class="btn btn-primary"> <br> <span
										style="color: red; font-weight: bold " id="s1"></span>
								</div>
							</div>
						</form>
					</div>

				</div>
				
				<table id="table1" class="table table-bordered table-striped">
					<thead>
					<tr>
					<td>State Name</td>
					<td>City Name</td>					
					<td>Delete</td>
					</tr>
					</thead>
					<tbody>
					<%
					rs=db.getRows(sql);
					while(rs.next()){
					%>
					<tr>
					<td><%=rs.getString(1)%></td>
					<td><%=rs.getString(2)%></td>
					
					<td><button class="btn btn-danger" onclick="if(confirm('Do you want to delete current record?'))window.location='?s=<%=rs.getString(1)%>&c=<%=rs.getString(2)%>';">Delete</button></td>
					</tr>
					<%	
					}					
					%>
					</tbody>
					</table>
			</div>
		</div>
	</div>
	<!-- /Main -->
	
	

<%@ include file="footer.jsp" %>