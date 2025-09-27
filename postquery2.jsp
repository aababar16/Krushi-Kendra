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
String sql="select * from Responses where Qid="+session.getAttribute("qid")+" order by ResponseDateTime desc";
String query="";
if(request.getParameter("addbtn")!=null){   
	   
    query=request.getParameter("query");
    String res=request.getParameter("res");
    SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
    Date d=new Date();
    String cdatetime=sdf.format(d);
    String id=session.getAttribute("qid").toString();
  	db.executeSql("Insert into Responses (QID,Response,ResponseDateTime) values(?,?,?)",id,res,cdatetime);
  	msg="Your Query Response is Posted Successfully..";
      

}
else
{

if(request.getParameter("id")!=null)
{
	session.setAttribute("qid",request.getParameter("id"));
	ResultSet rss=db.getRows("select * from queries where Id=?",request.getParameter("id"));
	if(rss.next())
	{
		query=rss.getString(2);
	}
	
}
}
%>

	<!-- Main -->
	<div id="main-wrapper">



		<div class="container">
			<div id="main">

				<div class="row">
					<div class="col-md-7 col-md-offset-3">

						<form name="form1" id="form1" method="post" action="">
							<div class="panel panel-primary">
								<div class="panel-heading">
									<h3 class="panel-title">Submit Your Response to Query</h3>
								</div>
								<div class="panel-body">

									<div class="form-group">
										Query<br>
										<textarea id="query" name="query"
											class="form-control" rows="6" cols="50" readonly="readonly"><%=query%></textarea>
									</div>
									<div class="form-group">										
										Your Response<br>
										<textarea id="res" name="res"
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
					<td>Response</td>
					<td>ResponseDateTime</td>					
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