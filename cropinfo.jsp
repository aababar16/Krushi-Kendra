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
if (MultipartFormDataRequest.isMultipartFormData(request))
{
   // Uses MultipartFormDataRequest to parse the HTTP request.
   MultipartFormDataRequest mrequest = new MultipartFormDataRequest(request);
   if(mrequest.getParameter("addbtn")!=null){   
   
	   String fname="",fname1="";
	     
          Hashtable files = mrequest.getFiles();
          if ( (files != null) && (!files.isEmpty()) )
          {
              UploadFile file = (UploadFile) files.get("cfile");
              fname=file.getFileName();
              //if (file != null) out.println("<li>Form field : uploadfile"+"<BR> Uploaded file : "+file.getFileName()+" ("+file.getFileSize()+" bytes)"+"<BR> Content Type : "+file.getContentType());
              // Uses the bean now to store specified by jsp:setProperty at the top.
              upBean.store(mrequest, "cfile");
              
              UploadFile file1 = (UploadFile) files.get("ufile");
              fname1=file1.getFileName();
              //if (file != null) out.println("<li>Form field : uploadfile"+"<BR> Uploaded file : "+file.getFileName()+" ("+file.getFileSize()+" bytes)"+"<BR> Content Type : "+file.getContentType());
              // Uses the bean now to store specified by jsp:setProperty at the top.
              upBean.store(mrequest, "ufile");
              
          }
          selcrop=mrequest.getParameter("catname");
          
      	db.executeSql("Insert into CropInfo (Name,CropCategory,CropImage,Info) values(?,?,?,?)",mrequest.getParameter("cname"),mrequest.getParameter("catname"),fname,fname1);
        msg="Crop Info is Saved Successfully";  
   }
}
else if(request.getParameter("id")!=null)
{
	db.executeSql("delete from CropInfo where CropId=?",request.getParameter("id"));
	response.sendRedirect("cropinfo.jsp");
}

%>

<script>
$(document).ready(function(){
	$("#form1").validate({
		rules:{
			cname:{
				required:true,
				pattern:/^[A-Za-z ]+$/
			},
			catname:{
				required:true
			},
			cfile:{
				required:true				
			},
			ufile:{
				required:true				
			}
		},
		messages:{
			cname:{
				required:"Crop Name is Required",
				pattern:"Please enter only chars and spaces in Crop Name"
			},
			catname:{
				required:"Crop Type is Required"
				
			},
			cfile:{
				required:"Crop Image is Required"				
			},
			ufile:{
				required:"Crop Information is Required"				
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
					<div class="col-md-8 col-md-offset-1">

						<form name="form1" id="form1" method="post" action="" enctype="multipart/form-data">
							<div class="panel panel-primary">
								<div class="panel-heading">
									<h3 class="panel-title">Crop Info Entry Form</h3>
								</div>
								<div class="panel-body">

									<div class="form-group">
										Name<br>
										<input type="text" id="cname" name="cname"
											class="form-control" />
									</div>
									<div class="form-group">
										Crop Type/Category<br>										
										<select name="catname" class="form-control" id="catname">
										<option  value="">-- Select Crop Type --</option> 
										<%
										ResultSet rs=db.getRows("select * from Croptypes");
										while(rs.next()){
										%>
										<option <%=selcrop.equals(rs.getString(1))?"selected":""%>  value="<%=rs.getString(1)%>"><%=rs.getString(1)%></option>
										<%
										}
										%>
										</select>
									</div>
									<div class="form-group">
										Crop Image<br> 
										<input type="file" id="cfile" name="cfile"
											class="form-control" />
									</div>
									<div class="form-group">
										Upload Crop Information<br> 
										<input type="file" id="ufile" name="ufile"
											class="form-control" />
									</div>
									<input type="submit" value="Save" id="addbtn" name="addbtn"
										class="btn btn-primary"> <br> <span
										style="color: red; font-weight: bold " id="s1"><%=msg %></span>
								</div>
							</div>
						</form>
					</div>

				</div>
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
					<td><img src="<%=rs.getString(4)%>" width="60" height="60" alt="NA"/></td>
					<td><a href="<%=rs.getString(5)%>">Crop Info</a></td>
					<td><button class="btn btn-danger" onclick="if(confirm('Do you want to delete current record?'))window.location='?id=<%=rs.getString(1)%>';">Delete</button></td>
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