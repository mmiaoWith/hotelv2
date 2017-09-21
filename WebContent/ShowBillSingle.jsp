<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" errorPage=""%>
    <%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>查询单个账单的信息</title>
</head>
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
<%
request.setCharacterEncoding("utf-8");
String onum=request.getParameter("onum");
int onum1=Integer.parseInt(onum);
//移动指针到所请求的记录	
rst.absolute(onum1);
%>
<h1 align="center">单个账单信息</h1>
<br>
<table width="50%" border="2" align="center">
<tr>
<th>&nbsp;订单编号</th>
<th>&nbsp;账单时间</th>
<th>&nbsp;结帐金额</th>
<th>&nbsp;账单状态</th>
</tr>
<tr>
<td align="center"><%=rst.getInt(1) %></td>
<td align="center"><%=rst.getString(2) %></td>
<td align="center"><%=rst.getString(3) %></td>
<td align="center"><%=rst.getInt(4) %></td>
</tr>
</table><p>
<br><br>
<center>
<form  id="form1" name="form1" method="post" action="UpdateBill.jsp">
请输入你要修改的账单的账单信息：
<br>
<br>
账单编号：<%=rst.getInt(1) %>
<input name="onum" type="hidden" id="onum" value="<%=rst.getInt(1) %>"/><br><br>
账单时间：
<input name="btime" type="text" id="btime"/><br><br>
结帐金额：
<input name="money" type="text" id="money"/><br><br>
账单状态：
<input name="bstate" type="text" id="bstate"/><br><br>
<br>
<br>

<input type="submit" name="Submit" value="提交"/>
<input type="reset" name="Submit2" value="重置"/>
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
</html>