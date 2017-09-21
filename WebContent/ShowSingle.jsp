<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" errorPage=""%>
    <%@ page import="java.sql.*" %>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>查询单个房间的信息</title>
</head>
<body>
<%
try
{
	
	Connection conn=null;
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	conn=DriverManager.getConnection("jdbc:sqlserver://localhost:1433;DatabaseName=hotel","tom","1234");
	Statement smt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
	ResultSet rst=smt.executeQuery("select * from room");

%>
<%
request.setCharacterEncoding("utf-8");
String nroom=request.getParameter("nroom");
int nroom1=Integer.parseInt(nroom);
//移动指针到所请求的记录
if(nroom1>=5001&&nroom1<=5008)
{
	nroom1=nroom1-5000;
}
if(nroom1>=6001&&nroom1<=6008)
{
	nroom1=nroom1-6000+8;
}
if(nroom1>=7001&&nroom1<=7008)
{
	nroom1=nroom1-7000+16;
}
if(nroom1>=8001&&nroom1<=8008)
{
	nroom1=nroom1-8000+24;
}
if(nroom1>=9001&&nroom1<=9008)
{
	nroom1=nroom1-9000+32;
}
	
rst.absolute(nroom1);
%>
<h1 align="center">单个房间信息</h1>
<br>
<table width="50%" border="2" align="center">
<tr>
<th>&nbsp;房间号</th>
<th>&nbsp;房间类型</th>
<th>&nbsp;房间价格</th>
<th>&nbsp;房间状态</th>
</tr>
<tr>
<td align="center"><%=rst.getInt(1) %></td>
<td align="center"><%=rst.getInt(2) %></td>
<td align="center"><%=rst.getString(3) %></td>
<td align="center"><%=rst.getInt(4) %></td>
</tr>
</table><p>
<br><br>


<%
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
</body>
</html>