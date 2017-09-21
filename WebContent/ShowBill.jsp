<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" errorPage=""%>
    <%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>查询全部账单的信息</title>
</head>
<% if (session.getAttribute("pass")=="1") {%>
<body>
<%
try
{
	
	Connection conn=null;
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	conn=DriverManager.getConnection("jdbc:sqlserver://localhost:1433;DatabaseName=hotel","tom","1234");
	Statement smt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
	ResultSet rst=smt.executeQuery("select * from bill");

%>
<h1 align="center">全部账单信息</h1>
<br>
<table width="50%" border="2" align="center">
<tr>
<th>&nbsp;账单编号</th>
<th>&nbsp;账单时间</th>
<th>&nbsp;结帐金额</th>
<th>&nbsp;账单状态</th>
</tr>
<%
rst.beforeFirst();
//移动记录指针到下一条记录
while(rst.next())
{
%>

<tr>
<td align="center"><%=rst.getInt(1) %></td>
<td align="center"><%=rst.getString(2) %></td>
<td align="center"><%=rst.getString(3) %></td>
<td align="center"><%=rst.getInt(4) %></td>
</tr>
<%} %>
</table><p>
<br>
<br>
<center>
<form  id="form1" name="form1" method="post" action="ShowBillSingle.jsp">
请输入你要修改的账单的的账单号码（如：1）：
<input name="onum" type="text" id="onum"/>
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