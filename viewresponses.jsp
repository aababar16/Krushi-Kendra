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

if(request.getParameter("id")!=null)
{
	session.setAttribute("qid",request.getParameter("id"));
}

%>

	<!-- Main -->
	<div id="main-wrapper">



		<div class="container">
			<div id="main">

				<div class="row">
					<div class="col-md-9 col-md-offset-3">
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