<%@page import="com.agri.DataAccess"%>
<%
DataAccess db=new DataAccess();
String user=request.getParameter("uname");
boolean flag=db.isExists("select * from Login where UserName=?",user);
out.println(flag);
%>