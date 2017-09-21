<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>宾馆管理系统登录界面</title>
</head>
<body>
<% String id=request.getParameter("name").trim();
id=new String(id.getBytes("8859_1"),"utf-8");
String password=request.getParameter("password").trim();
password=new String(password.getBytes("8859_1"),"utf-8");
String identity=request.getParameter("identity").trim();
identity=new String(identity.getBytes("8859_1"),"utf-8");
Connection conn=null;
try
{
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	System.out.println("加载驱动成功！");
}catch(Exception e){
	out.print(e);
	System.out.println("加载驱动失败！");
}
conn=DriverManager.getConnection("jdbc:sqlserver://localhost:1433;DatabaseName=ghotel","scott","1234");
System.out.println("连接数据库成功！");
Statement smt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
ResultSet rst=smt.executeQuery("select * from people where pid='"+id+"' and password='"+password+"' and position='"+identity+"'");
int raw=0;
while(rst.next())
{
	raw++;
}
if(1==raw)
{ 
session.setAttribute("pass", "1");
String s0=new String("经理");
if(identity.equals(s0)){%>
<jsp:forward page="manager.jsp">
<jsp:param name="user" value="<%=id %>"/>
</jsp:forward>
<%}else if(identity.equals("前台".trim())){%>
<jsp:forward page="reception.jsp">
<jsp:param name="user" value="<%=id %>"/>
</jsp:forward>
<%}else if(identity.equals("后勤")){%>
<jsp:forward page="logistic.jsp">
<jsp:param name="user" value="<%=id %>"/>
</jsp:forward>
<%}else if(identity.equals("财务")){%>
<jsp:forward page="finance.jsp">
<jsp:param name="user" value="<%=id %>"/>
</jsp:forward>
<%}else{ %>
<jsp:forward page="check.jsp">
<jsp:param name="user" value="<%=id %>"/>
</jsp:forward>
<%}}else{ %>
<jsp:forward page="login.jsp">
<jsp:param name="user" value="<%=id %>"/>
</jsp:forward>
<%}%>
</body>
</html>