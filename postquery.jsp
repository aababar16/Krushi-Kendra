<%@page import="java.text.SimpleDateFormat"%>
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
String sql="select * from Queries where UserName='"+session.getAttribute("user").toString()+"' order by PostedDateTime desc";


if(request.getParameter("addbtn")!=null){   
   
	    String query=request.getParameter("query");
	    SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
	    Date d=new Date();
	    String cdatetime=sdf.format(d);
	    String user=session.getAttribute("user").toString();
      	db.executeSql("Insert into Queries (Query,PostedDateTime,UserName) values(?,?,?)",query,cdatetime,user);
      	msg="Your Query is Posted Successfully..";
          
   
}


%>

<script>
$(document).ready(function(){
	$("#form1").validate({
		rules:{
			query:{
				required:true			
			}
		},
		messages:{
			query:{
				required:"Query is Required"
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
									<h3 class="panel-title">Post Your Query</h3>
								</div>
								<div class="panel-body">

									<div class="form-group">
										Query<br>
										<textarea id="query" name="query"
											class="form-control" rows="6" cols="50"></textarea>
									</div>
									<input type="submit" value="Submit" id="addbtn" name="addbtn"
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
					<td>QueryID</td>					
					<td>Query</td>
					<td>PostedDateTime</td>
					<td>Responses</td>
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
					<td><a class="btn btn-info" href="viewresponses.jsp?id=<%=rs.getString(1)%>">View Responses</a></td>					
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