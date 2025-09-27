<%@page import="java.sql.ResultSet"%>
<%@page import="com.agri.SendMail"%>
<%@page import="com.agri.DataAccess"%>
<%@ include file="header.jsp"%>
<%
DataAccess db=new DataAccess();
String msg="";
String selstate="",selcity="";
String utype="",name="",address="",email="",details="",mobile="",pass="";
if(request.getParameter("btnsubmit")!=null){
		
	utype=request.getParameter("utype");
	name=request.getParameter("name");
	address=request.getParameter("address");
	selstate=request.getParameter("sname");
	selcity=request.getParameter("cname");
	email=request.getParameter("emailid");
	details=request.getParameter("details");
	mobile=request.getParameter("mobile");
	pass=request.getParameter("pass");
	
	
	ResultSet rs=db.getRows("select * from Users where MobileNo=?", mobile);
	if(rs.next()){
		msg="Mobile No is already registered with System. try new one..";
	}
	else{
	
	db.executeSql("Insert into Users  values(?,?,?,?,?,?,?,?,?)",utype,name,address,selcity,selstate,details,mobile,email,pass);
	//SendMail.send(email,"Farmer Buddy System - Thanks for creating new account with us" , s);
	msg="You have been registered with system successfully<br>Please use your MobileNo as username";
	}
			
}
else
{
	if(request.getParameter("sname")!=null){
		
	utype=request.getParameter("utype");
	name=request.getParameter("name");
	address=request.getParameter("address");
	selstate=request.getParameter("sname");
	selcity=request.getParameter("cname");
	email=request.getParameter("emailid");
	details=request.getParameter("details");
	mobile=request.getParameter("mobile");
	pass=request.getParameter("pass");
	}
}

%>

<script>
$(document).ready(function(){
	$("#form1").validate({
		rules:{
			name:{
				required:true,
				pattern:/^[A-Za-z ]+$/
			},
			address:{
				required:true				
			},
			sname:{
				required:true				
			},
			cname:{
				required:true				
			},
			emailid:{
				required:true,
				email:true
			},
			mobile:{
				required:true,
				pattern:/^\d{10}$/
			},
			pass:{
				required:true
			},
			cpass:{
				required:true,
				equalTo:"#pass"
			}
			
		},
		messages:{
			name:{
				required:"Name is Required",
				pattern:"Please enter only chars and spaces in Name"
			},
			address:{
				required:"Address is Required"				
			},
			sname:{
				required:"State is Required"				
			},			
			cname:{
				required:"City is Required"				
			},
			emailid:{
				required:"Email ID is Required",
				email:"Please enter valid Email ID"
			},
			mobile:{
				required:"Mobile No is Required",
				pattern:"Please enter 10 digits mobile no"
			},
			pass:{
				required:"Password is Required"
			},
			cpass:{
				required:"Confirm Password is Required",
				equalTo:"Password and Confirm Password Mismatch"
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
<br>
<form id="form1" method="post">
  <div class="panel panel-primary">
	<div class="panel-heading">
		<h3 class="panel-title">Register with Portal</h3>
	</div>
	<div class="panel-body">
    
    <div class="form-group">
      <label for="utype">UserType</label>
      
		<select name="utype" class="form-control" id="utype">
			<option value="">--Select User Type--</option> 
			<option <%=utype.equals("Farmer")?"selected":"" %>  value="Farmer">Farmer</option>
			<option <%=utype.equals("Dealer")?"selected":"" %> value="Dealer">Dealer</option>
		</select>
            
    </div>
    <div class="form-group">
      <label for="name">Name</label>
      <input type="text" class="form-control" name="name" id="name" placeholder="Enter Your Name" value="<%=name%>">      
    </div>
    <div class="form-group">
      <label for="address">Address Line1</label>
      <input type="text" class="form-control" name="address" id="address" placeholder="Enter Address Line1" value="<%=address%>">      
    </div> 
    <div class="form-group">
    State<br>
		<select name="sname" class="form-control" id="sname" onchange="form1.submit();">
		<option value="">-- Select State --</option> 
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
		<option value="">-- Select City --</option>
		<%
		rs=db.getRows("select * from Cities where StateName='"+selstate+"'");
		while(rs.next()){
		%>
		<option <%=selcity!=null && selcity.equals(rs.getString(2))?"selected":""%>  value="<%=rs.getString(2)%>"><%=rs.getString(2)%></option>
		<%
		}
		%>
		</select>
	</div>
	<div class="form-group">
      <label for="details">Crop Details if any</label>
      <textarea class="form-control" name="details" id="details" placeholder="Specify other details such as info about seeds,fertilizer..."><%=details%></textarea>      
    </div>
    <div class="form-group">
      <label for="mobile">Mobile No(Enter unique Mobile No)</label>
      <input type="text" class="form-control" name="mobile" id="mobile" placeholder="Enter 10 digits Mobile No" value="<%=mobile%>">      
    </div>
    <div class="form-group">
      <label for="emailid">Email</label>
      <input type="text" class="form-control" name="emailid" id="emailid" placeholder="Enter your Email ID" value="<%=email%>">      
    </div>
    
    
    
    <div class="form-group">
      <label for="pass">Password</label>
      <input type="password" class="form-control" name="pass" id="pass" placeholder="Password" value="<%=pass%>">
    </div>
    <div class="form-group">
      <label for="cpass">Confirm Password</label>
      <input type="password" class="form-control" name="cpass" id="cpass" placeholder="Confirm Password">
    </div>
        <button type="submit" name="btnsubmit" class="btn btn-primary">Register</button>
  
  <%=msg %>
  </div>
  </div>
</form>

</div>
</div>
			</div>
		</div>
	</div>
	<!-- /Main -->

<%@ include file="footer.jsp"%>