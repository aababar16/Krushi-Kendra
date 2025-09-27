<%@page import="java.sql.ResultSet"%>
<%@page import="com.agri.DataAccess"%>
<%
String title="Change Password";
%>
<%@ include file="header.jsp" %>

<%
String msg="";

DataAccess db=new DataAccess();

if(request.getParameter("b1")!=null) 
{
	String old=request.getParameter("t1");
	String new1=request.getParameter("t2");
	String new2=request.getParameter("t3");
	
	
	ResultSet rs=db.getRows("select * from Login where UserName='"+session.getAttribute("user")+"' and Password='"+old+"'");
	if(!rs.next())
	{
		msg="Please enter valid old password";
		
	}
	else
	{
		if(!new1.equals(new2))
		{
			msg="New Password Mismatch";
		}
		else
		{
			db.executeSql("Update Login set Password=? where UserName=?",new1,session.getAttribute("user").toString());
			msg="Password changed successfully...";
		}
		
	
	}
	
}
%>
<script>
$(document).ready(function(){
	$("#form1").validate({
		rules:{
			t1:{
				required:true			
			},
			t2:{
				required:true
			},
			t3:{
				required:true,
				equalTo:"#t2"
			}
		},
		messages:{
			t1:{
				required:"Old Password is Required"				
			},
			t2:{
				required:"New Password is Required"
			},
			t3:{
				required:"Confirm New Password is Required",
				equalTo:"Password Mismatch"
			}
		}
		
	});
	
});
</script>

<!-- Main -->
	<div id="main-wrapper">
	<div class="container">
	<div class="row">
					<div class="col-md-7 col-md-offset-3">

						<form name="form1" id="form1" method="post" action="">
							<div class="panel panel-primary">
								<div class="panel-heading">
									<h3 class="panel-title">Change Password Form</h3>
								</div>
								<div class="panel-body">

									<div class="form-group">
										Old Password<br>
										<input type="password" name="t1" id="t1" required="required" class="form-control" />
									</div>
									<div class="form-group">
										New Password<br>
										<input type="password" name="t2" id="t2" required="required" class="form-control" />
									</div>
									<div class="form-group">
										Confirm New Password<br>
										<input type="password" name="t3" id="t3" required="required" class="form-control" />
									</div>
									<input type="submit" value="Change Password" id="b1" name="b1"
										class="btn btn-primary"> <br> <span
										style="color: red; font-weight: bold " id="s1"><%=msg%></span>
								</div>
							</div>
						</form>
					</div>

				</div>
	</div>
	</div>

<%@ include file="footer.jsp" %>
