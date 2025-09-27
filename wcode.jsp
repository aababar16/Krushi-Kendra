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
String sql="select * from WCode";
String selstate="",selcity="";
if(request.getParameter("addbtn")!=null)
{
	selstate=request.getParameter("sname");
	selcity=request.getParameter("cname");
	db.executeSql("Insert into WCode values(?,?,?)",request.getParameter("sname"),request.getParameter("cname"),request.getParameter("wcode"));	
}
else if(request.getParameter("s")!=null)
{
	db.executeSql("delete from cities where StateName=? and CityName=?",request.getParameter("s"),request.getParameter("c"));
	response.sendRedirect("cities.jsp");
}
else if(request.getParameter("sname")!=null)
{
	selstate=request.getParameter("sname");
	selcity=request.getParameter("cname");
	
	sql="select * from wcode where statename='"+request.getParameter("sname")+"' and cityname='"+request.getParameter("cname")+"'";
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
				required:true
			},
			wcode:{
				required:true,
				digits:true
			}
		},
		messages:{
			sname:{
				required:"State is Required"				
			},
			cname:{
				required:"City is Required"
			},
			wcode:{
				required:"Weather Code is Required",
				digits:"Weather code should be integer"
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
									<h3 class="panel-title">Weather Code Entry Form</h3>
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
										City<br>
										<select name="cname" class="form-control" id="cname"> 
										<option  value="">-- Select City --</option>
										<%
										rs=db.getRows("select * from Cities where StateName='"+request.getParameter("sname")+"'");
										while(rs.next()){
										%>
										<option <%=selcity!=null && selcity.equals(rs.getString(2))?"selected":""%>  value="<%=rs.getString(2)%>"><%=rs.getString(2)%></option>
										<%
										}
										%>
										</select>
									</div>
									<div class="form-group">
										Weather Code<br> <input type="text" id="wcode" name="wcode"
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
					<td>Weather Code</td>
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
					<td><%=rs.getString(3)%></td>
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