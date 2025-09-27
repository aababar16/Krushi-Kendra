<%@page import="com.agri.DataAccess"%>
<%@ include file="header.jsp" %>    
<%
String msg="";
String utype="";
if(request.getParameter("loginbtn")!=null){
	utype=request.getParameter("utype");
	String user=request.getParameter("uname");
	String pass=request.getParameter("password");
	DataAccess db=new DataAccess();
	if(utype.equals("Admin"))
	{
		boolean flag=db.isExists("select * from Login where UserName=? and Password=?",user,pass);
		if(flag){
		session.setAttribute("user", user);
		session.setAttribute("utype", utype);
		response.sendRedirect("home.jsp");	
		}else{
		msg="Login Failed.. try again..";		
		}
	}
	else
	{
		boolean flag=db.isExists("select * from Users where MobileNo=? and Password=?",user,pass);
		if(flag){
		session.setAttribute("user", user);	
		session.setAttribute("utype", utype);
		response.sendRedirect("home.jsp");	
		}else{
		msg="Login Failed.. try again..";		
		}
	}
}
%>    

<script>
$(document).ready(function(){
	$("#form1").validate(
			{
				rules:{					
					uname:{
						required:true
					}
				},
				messages:{
					uname:{
					required:"UserName required",
					remote:"Please enter available username"
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
                    <div class="col-md-4 col-md-offset-4">
                    
                    <img class="profile-img" src="images/profile.jpg"
                    alt="" style="width:100px;height:100px;margin-left:100px">
                    <br>
					<form name="form1" id="form1" method="post" action="">
					
					<div class="form-group">
				      
						<select name="utype" class="form-control" id="utype">
							<option value="">--Select User Type--</option> 
							<option <%=utype.equals("Farmer")?"selected":"" %>  value="Farmer">Farmer</option>
							<option <%=utype.equals("Dealer")?"selected":"" %> value="Dealer">Dealer</option>
							<option <%=utype.equals("Admin")?"selected":"" %>  value="Admin">Admin</option>
						</select>
            
    </div>
                    <div class="form-group">
						<input type="text" id="uname"  name="uname" class="form-control" placeholder="UserName"/>
                    </div>
                    <div class="form-group">
									<input type="password" id="password" name="password" class="form-control" placeholder="Password"/>
                                    </div>
 									<center><input type="submit" value="LOGIN" name="loginbtn" class="btn btn-primary"></center>
 									
 									
 									<br>
 									<span style="color:red;font-weight:bold"><%=msg%></span>
									
	</form>
					</div>
				
				</div>
			</div>
		</div>
	</div>
	<!-- /Main -->

<%@ include file="footer.jsp" %>	