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
String sql="select * from Croptypes";
String selstate="";

if (MultipartFormDataRequest.isMultipartFormData(request))
{
   // Uses MultipartFormDataRequest to parse the HTTP request.
   MultipartFormDataRequest mrequest = new MultipartFormDataRequest(request);
   if(mrequest.getParameter("addbtn")!=null){   
   
	   String fname="";
	     
          Hashtable files = mrequest.getFiles();
          if ( (files != null) && (!files.isEmpty()) )
          {
              UploadFile file = (UploadFile) files.get("cfile");
              fname=file.getFileName();
              //if (file != null) out.println("<li>Form field : uploadfile"+"<BR> Uploaded file : "+file.getFileName()+" ("+file.getFileSize()+" bytes)"+"<BR> Content Type : "+file.getContentType());
              // Uses the bean now to store specified by jsp:setProperty at the top.
              upBean.store(mrequest, "cfile");
          }
          selstate=mrequest.getParameter("ctype");
      	db.executeSql("Insert into CropTypes values(?,?)",mrequest.getParameter("ctype"),fname);
          
   }
}
else if(request.getParameter("ctype")!=null)
{
	db.executeSql("delete from Croptypes where Croptype=?",request.getParameter("ctype"));
	response.sendRedirect("croptypes.jsp");
}

%>

<script>
$(document).ready(function(){
	$("#form1").validate({
		rules:{
			ctype:{
				required:true			
			},
			cfile:{
				required:true				
			}
		},
		messages:{
			ctype:{
				required:"Crop Type is Required"
			},
			cfile:{
				required:"Crop Type Image is Required"				
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

						<form name="form1" id="form1" method="post" action="" enctype="multipart/form-data">
							<div class="panel panel-primary">
								<div class="panel-heading">
									<h3 class="panel-title">Crop Types Entry Form</h3>
								</div>
								<div class="panel-body">

									<div class="form-group">
										Crop Type<br>
										<input type="text" id="ctype" name="ctype"
											class="form-control" />
									</div>
									<div class="form-group">
										Crop Type Image<br> 
										<input type="file" id="cfile" name="cfile"
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
					<td>Crop type</td>
					<td>Crop Image</td>
					<td>Delete</td>
					</tr>
					</thead>
					<tbody>
					<%
					ResultSet rs=db.getRows(sql);
					while(rs.next()){
					%>
					<tr>
					<td><%=rs.getString(1)%></td>
					<td><img src="<%=rs.getString(2)%>" width="60" height="60" alt="NA"/></td>
					<td><button class="btn btn-danger" onclick="if(confirm('Do you want to delete current record?'))window.location='?ctype=<%=rs.getString(1)%>';">Delete</button></td>
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