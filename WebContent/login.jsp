<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%@ page import="java.sql.*" %>
<title>宾馆管理系统登录</title>
</head>
<body>
<%
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
String sql="select distinct position from people";
Statement stmt=conn.createStatement();	
ResultSet rs=stmt.executeQuery(sql);
 %>
<center>
<h1><font color=blue>欢迎使用宾馆管理系统</font></h1>
<form method="post" action=check.jsp>
<table>
<tr>
<td>输入用户名：</td>
<td><input type=text name=name onkeyup="value=value.replace(/[^\d]/g,'')" value=<%=request.getParameter("name") %>></td>
</tr>
<tr>
<td>输入密码：</td>
<td><input type=password name=password onkeyup="value=value.replace(/[^\d]/g,'')"></td>
</tr>
<tr>
<tr>
<td>身份：</td>
<td>
<select name=identity>
<%while(rs.next()) {%>
<option><%=rs.getString("position").trim() %></option>
<%} %>
</select>
</td>
</tr>
<tr>
<td><input type=submit value=提交></td>
<td><input type=reset value=重置></td>
</tr>
</table>
</form>
<%conn.close();
stmt.close();
rs.close();  %>
<%!int num=0 ;%>
<%num++; %>
<%="访问次数："+num %>
</center>
</body>
</html>