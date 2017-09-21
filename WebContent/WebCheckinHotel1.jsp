<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" errorPage=""%>
    <%@ page import="java.sql.*" import="java.util.Date" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>确认预订</title>



</head>
<body>



<%
String guestname=request.getParameter("gname1");
guestname=new String(guestname.getBytes("8859_1"),"utf-8");
String guestphone=request.getParameter("phone1");
String id=request.getParameter("id");
id=new String(id.getBytes("8859_1"),"utf-8");
String ordermore=request.getParameter("more1");
ordermore=new String(ordermore.getBytes("8859_1"),"utf-8");
//Object obj=request.getAttribute("name");
//String rid1="";
//if(obj!=null)
//rid1=obj.toString();
String rid1=request.getParameter("param1");
//out.println("rid1="+rid1);
//String intime1=request.getParameter("param2");
String intime1=request.getParameter("param3");
String outtime1=request.getParameter("param4");
//out.println("intime1="+intime1);
//out.println("outtime1="+outtime1);
//获得系统时间
java.util.Date date=new java.util.Date();
String datestr=java.text.DateFormat.getDateTimeInstance().format(date);

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

Statement smt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
ResultSet rst1=smt.executeQuery("select * from guest");
rst1.last();
int total=rst1.getRow();
total++;
ResultSet rst2=smt.executeQuery("select * from orde");
rst2.last();
int total1=rst2.getRow();
total1++;
try
{
    String sql1="insert into guest(gname,gid,phone) values('"+guestname+"','"+id+"','"+guestphone+"')";
    Statement stmt=conn.createStatement();	
    int rs=stmt.executeUpdate(sql1);
}
catch(Exception e)
{
out.print(e);
}
try
{
	
    String sql="insert into orde(oid,rid,gid,intime,outime,money,more) values('"+total1+"','"+rid1+"','"+id+"','"+intime1+"','"+outtime1+"','100','"+ordermore+"')";
    Statement stmt=conn.createStatement();	
    int rs=stmt.executeUpdate(sql);
}
catch(Exception e)
{
out.print(e);
}
try
{
String sql0="update room set rstate=1 where rid='"+rid1+"'";
Statement stmt0=conn.createStatement();	
int rs=stmt0.executeUpdate(sql0);
}
catch(Exception e)
{
out.print(e);
}
%>
<%
try
{
	String sql="select * from orde where oid='"+total1+"'"	;
	Statement stmt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);	
    ResultSet rs1=stmt.executeQuery(sql);
%>
    <%
//移动指针到第一条记录之前
rs1.beforeFirst();
//移动记录指针到下一条记录
while(rs1.next())
{
%>
预订成功！订单详细信息如下：<br><br>

<table width="100%" align="center" border="0" cellpadding="0" cellspacing="0"  >
<tr>
<td align="center" >订单号： <%=rs1.getInt(1) %></td>
</tr>
<tr>
<td align="center">房间号：<%=rs1.getInt(2) %>&nbsp;&nbsp;</td>
</tr>
<tr>
<td align="center">客人编号：<%=rs1.getString(3) %>&nbsp;&nbsp;</td>
</tr>
<tr>
<td align="center">入住时间：<%=rs1.getString(4) %>&nbsp;&nbsp;</td>
</tr>
<tr>
<td align="center">退房时间：<%=rs1.getString(5) %>&nbsp;&nbsp;</td>
</tr>
<tr>
<td align="center">押金：<%=rs1.getString(6) %>&nbsp;&nbsp;</td>
</tr>
<tr>
<td align="center">备注信息：<%=rs1.getString(7) %>&nbsp;&nbsp;</td>
</tr>
<tr>
<td align="center">交易成功时间：<%=datestr %>&nbsp;&nbsp;</td>
</tr>
</table>
<% 
//rs1.close();
//stmt.close();
}%>
<%}
catch(Exception e)
{
out.print(e);
}
//out.println("预订成功！订单详细信息为：");
%>
<center>
<br><br>
<form  id="form1" name="form1" method="post" action="WebContinue.jsp">
<input type="submit" name="Submit" value="网上支付"/>
<input type="button" name="Submit2" onclick="window.location.href='index.jsp'" value="取消">
</form>
</center>


</body>
</html>