<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%@ page import="java.sql.*" %>
<title>显示查询的客人信息</title>
</head>
<body>
<%
String gid=request.getParameter("num");
gid=new String(gid.getBytes("8859_1"),"utf-8");
String driverName="com.microsoft.sqlserver.jdbc.SQLServerDriver";
String dbURL="jdbc:sqlserver://localhost:1433;DatabaseName=ghotel";
String userName="scott";
String userPwd="1234";
 try
{
	Class.forName(driverName);
	System.out.println("加载驱动成功！");
}catch(Exception e){
	out.print(e);
	System.out.println("加载驱动失败！");
}
Connection conn=DriverManager.getConnection(dbURL,userName,userPwd);
System.out.println("连接数据库成功！");
 Statement stmt=conn.createStatement();		
 ResultSet rs=null;
 if(!gid.equals(""))
 try
 {
 rs=stmt.executeQuery("select guest.gname,guest.gid,guest.phone,orde.rid,orde.oid from guest,orde where guest.gid=orde.gid and guest.gid = '"+gid+"'");
 }
 catch(Exception e)
 {
 out.print(e+"<>");
 }
 %>
 <center>
<table border=2 width=100%>
<tr>
<td>姓名</td><td>身份证号</td><td>手机号</td><td>房间号</td><td>订单号</td>
</tr>
<%
 while(rs.next())
 {
 %>
<tr>
<td><%="&nbsp"+rs.getString(1) %></td>
<td><%="&nbsp"+rs.getString(2) %></td>
<td><%="&nbsp"+rs.getString(3) %></td>
<td><%="&nbsp"+rs.getString(4) %></td>
<td><%="&nbsp"+rs.getString(5) %></td>
</tr>
<%
}
 %>
 <%
 rs.close();
 stmt.close();
 conn.close();
  %>
 </table>
 </center>
</body>
</html>