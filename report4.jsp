<%@page import="com.agri.DataAccess"%>
<%@page import="net.sf.jasperreports.engine.JasperRunManager"%>
<%@ page language="java" contentType="application/pdf"  %>

<%
String reportpath=request.getRealPath("/report4.jasper");
//Returns real/full path of report1.jasper
DataAccess db=new DataAccess();
db.connectToServer();
byte b[]=JasperRunManager.runReportToPdf(reportpath, null,db.cn);
//byte[] static runReportToPdf(reportpath, parameters,connection);

response.setContentLength(b.length); //Specify how much data u want to write
ServletOutputStream sos= response.getOutputStream();
sos.write(b,0,b.length); //byte[],offset,length

sos.close();



%>

