<%@page import="com.agri.DataAccess"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<!DOCTYPE HTML>
<html>
	<head>
		<title>Farmer Buddy System</title>
		<meta http-equiv="content-type" content="text/html; charset=utf-8" />
		<meta name="description" content="" />
		<meta name="keywords" content="" />		
        <link rel="stylesheet" type="text/css" href="css/bootstrap.css">
        <link href="DataTables/datatables.css" rel="stylesheet"/>		
		<script src="DataTables/jQuery-3.3.1/jquery-3.3.1.js"></script>		
		<script src="DataTables/datatables.js"></script>
		<script src="js/bootstrap.js"></script>		
        <script src="js/jquery.validate.js"></script>        
        <script src="js/skel.min.js"></script>
		<script src="js/skel-panels.min.js"></script>
		<script src="js/init.js"></script>
		
		<style>
		label.error{
		color:red;
		font-weight:bold;
		}
		</style>
		
	</head>
	<body class="homepage">

	<!-- Header -->
	<div id="header-wrapper">
		<div id="header">
			<div class="container-fluid">
				<div id="logo"> 
					<img src="images/a2.jpg" style="float:left" width="150px" height="150px" alt="NA"/> 
		<h1 style="float:left;margin-left:100px;font-family:fantasy;"><a href="#" style="letter-spacing:10px;text-shadow:4px 4px 4px gray">Farmer Buddy System</a></h1>
					
				</div>
			</div>
			<div id="menu-wrapper">
				<div class="container">
					<!--  <nav id="nav">-->
			<nav class="navbar navbar-default">
  <div class="container-fluid">
  <div class="navbar-header">
      <a class="navbar-brand" href="home.jsp">Home</a>
    </div>
    
    <ul class="nav navbar-nav">
    <%
      if(session.getAttribute("user")!=null && session.getAttribute("utype").toString().equals("Admin"))
      {
      %>
     
    <li class="active"><a href="states.jsp">State</a></li>
    <li><a href="cities.jsp">City</a></li>
    <li><a href="farmer.jsp">Farmers</a></li>
    <li><a href="dealer.jsp">Dealers</a></li>
    <li><a href="croptypes.jsp">CropTypes</a></li>
    <li><a href="cropinfo.jsp">CropInfo</a></li>
    <li><a href="wcode.jsp">WeatherCode</a></li>
    <li><a href="programs.jsp">Programmes</a></li>
    <li><a href="queries.jsp">ResponseQuery</a></li>
    <li><a href="reports.jsp">Reports</a></li>
    
    <li><a href="ChangePassword.jsp">Change Password</a></li>
    <%
    } 
    else if(session.getAttribute("user")!=null && session.getAttribute("utype").toString().equals("Farmer"))
    {
      %>
    <li class="active"><a href="viewweather.jsp">Whether</a></li>
    <li><a href="programs2.jsp">Programmes & Schemes</a></li>
    <li><a href="cropinfo2.jsp">Crop Info</a></li>
    <li><a href="marketrate.jsp">Market Rates</a></li>
    <li><a href="dealer.jsp">Dealers</a></li>
    <li><a href="postquery.jsp">Post Query</a></li>
    <li><a href="ChangePassword2.jsp">Change Password</a></li>
    <%
    }      
    else if(session.getAttribute("user")!=null && session.getAttribute("utype").toString().equals("Dealer"))
    {
      %>
    <li class="active"><a href="viewweather.jsp">Whether</a></li>
    <li><a href="programs2.jsp">Programmes & Schemes</a></li>
    <li><a href="cropinfo2.jsp">Crop Info</a></li>
    <li><a href="marketrate.jsp">Market Rates</a></li>
    <li><a href="farmer.jsp">Farmers</a></li>
    <li><a href="postquery.jsp">Post Query</a></li>
    <li><a href="ChangePassword2.jsp">Change Password</a></li>
    <%
    }
    %>      
    </ul>
    <ul class="nav navbar-nav navbar-right">
      <%
      if(session.getAttribute("user")==null)
      {
      %>      
      <li><a href="index.jsp#login"><span class="glyphicon glyphicon-log-in"></span> Login</a></li>
      <li><a href="register.jsp"><span class="glyphicon glyphicon-log-in"></span> Register</a></li>
      <%
      }      
      else
      {
      %>
      <li><a href="#"><span class="glyphicon glyphicon-user"></span> Welcome <%=session.getAttribute("user") %></a></li>
      <li><a href="logout.jsp"><span class="glyphicon glyphicon-log-in"></span> Logout</a></li>
      <%
      }
      %>
    </ul>
  </div>
</nav>
					<!--  	<ul>
							<li onclick="this.className='active';"><a href="index.jsp#login">Member Login</a></li>
							<li onclick="this.className='active';"><a href="facultyreg.jsp">Faculty Registration</a></li>
							
						</ul>-->
					<!--  </nav>-->
				</div>
			</div>
		</div>
	</div>
	<!-- Header -->