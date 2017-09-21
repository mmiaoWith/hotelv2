<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" errorPage=""%>
    <%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>添加员工</title>
</head>
<body>
<% 
String pid=request.getParameter("id");
pid=new String(pid.getBytes("8859_1"),"utf-8");
String password=request.getParameter("password");
password=new String(password.getBytes("8859_1"),"utf-8");
String position=request.getParameter("position");
position=new String(position.getBytes("8859_1"),"utf-8");
if(position=="经理")//保证经理唯一
{
	response.sendRedirect("AddPeople.jsp");
}
%>

<%
try
{
	
	Connection conn=null;
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	conn=DriverManager.getConnection("jdbc:sqlserver://localhost:1433;DatabaseName=ghotel","scott","1234");
	Statement smt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
	ResultSet rst=smt.executeQuery("select * from people where pid='"+pid+"'");
	int raw=0;
	while(rst.next())
	{
		raw++;
	}
	if(1!=raw)//保证员工编号唯一
	{ 
	String sql="insert into people(pid,password,position) values('"+pid+"','"+password+"','"+position+"')";
	smt.execute(sql);	
	%>	
	<center>
	<h2>添加员工成功！</h2>
	</center>
	<%
	}	
	else
	{
	}
rst.close();
smt.close();
conn.close();
}
catch(SQLException SE)
{
out.println();
SE.printStackTrace();
}
%>
