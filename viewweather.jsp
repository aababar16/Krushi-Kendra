<%@page import="java.sql.ResultSet"%>
<%@ include file="header.jsp" %>

<%
String msg="";
DataAccess db=new DataAccess();
String sql="select * from WCode";
String selstate="",selcity="";

if(request.getParameter("sname")!=null || request.getParameter("cname")!=null)
{
	selstate=request.getParameter("sname");
	selcity=request.getParameter("cname");
	sql="select * from wcode where statename='"+request.getParameter("sname")+"' and cityname='"+request.getParameter("cname")+"'";
}
%>



</script>
	<!-- Main -->
	<div id="main-wrapper">



		<div class="container">
			<div id="main">

				<div class="row">
					<div class="col-md-7 col-md-offset-3">

						<form name="form1" id="form1" method="post" action="" class="form-inline">
							<div class="panel panel-primary">
								<div class="panel-heading">
									<h3 class="panel-title">View Weather Information</h3>
								</div>
								<div class="panel-body">

									<div class="form-row">
										<label class="col-md-2">State</label>
										<select name="sname" class="form-control col-md-4" id="sname" onchange="form1.submit();">
										<option  value="">-- Select State --</option> 
										<%
										ResultSet rs=db.getRows("select distinct StateName  from WCode");
										while(rs.next()){
										%>
										<option <%=selstate!=null && selstate.equals(rs.getString(1))?"selected":""%>  value="<%=rs.getString(1)%>"><%=rs.getString(1)%></option>
										<%
										}
										%>
										</select>
										<label class="col-md-2">City</label>
										<select name="cname" class="form-control col-md-4" id="cname" onchange="form1.submit();"> 
										<%
										rs=db.getRows("select CityName,wcode from WCode where StateName='"+request.getParameter("sname")+"'");
										while(rs.next()){
										%>
										<option <%=selcity!=null && selcity.equals(rs.getString(2))?"selected":""%>  value="<%=rs.getString(2)%>"><%=rs.getString(1)%></option>
										<%
										}
										%>
										</select>
									</div>
									
								</div>
							</div>
						</form>
					</div>

				</div>
				
				<div class="row">
				<iframe scrolling="auto" id="fr1" width="100%" height="400"
        src="http://city.imd.gov.in/citywx/city_weather.php?id=<%=selcity%>"></iframe>
			</div>
				
							</div>
		</div>
	</div>
	<!-- /Main -->
	
	

<%@ include file="footer.jsp" %>