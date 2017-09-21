<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" errorPage=""%>
    <%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>结帐</title>
</head>
<body>
<%
try
{
	
	Connection conn=null;
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	conn=DriverManager.getConnection("jdbc:sqlserver://localhost:1433;DatabaseName=ghotel","scott","1234");
	Statement smt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
	
	ResultSet rst=smt.executeQuery("select bid from bill");
%>
<center>
<center><h3>结帐</h3></center>
<form  id="form1" name="form1" method="post" action="CheckoutHotel1.jsp">
请输入房间号：（如：7001）
<input name="nroom" type="text" id="nroom" value="7001"/>
<br>
<br>
<input type="submit" name="Submit" value="提交"/>
<input type="reset" name="Submit2" value="重置">
</form>
</center>
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
