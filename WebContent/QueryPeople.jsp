<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" errorPage=""%>
    <%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>查询全部房间状态的信息</title>
</head>
<% if (session.getAttribute("pass")=="1") {%>
<body>
<%
try
{
	
	Connection conn=null;
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	conn=DriverManager.getConnection("jdbc:sqlserver://localhost:1433;DatabaseName=ghotel","scott","1234");
	Statement smt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
	ResultSet rst=smt.executeQuery("select pid,position from people");

%>
<br>
<table width="100%" border="1" align="center">
<tr>
<th>&nbsp;员工编号</th>
<th>&nbsp;员工职务</th>
<th>&nbsp;</th>
</tr>
<%
//移动指针到第一条记录之前
rst.beforeFirst();
//移动记录指针到下一条记录
while(rst.next())
{
%>
<tr>
<td align="center" id="number"><%=rst.getString(1) %></td>
<td align="center"><%=rst.getString(2) %></td>
<td><a href="DelPeople.jsp?id=<%=rst.getString(1) %>">删除</a></td>
</tr>
<%} %>
</table><p>
<br>
<br>

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
<% } 
else { %>
<center>
<form method="get" action="login.jsp">
<input type=submit value="返回">
</form>
</center>
<% } %>
</html>