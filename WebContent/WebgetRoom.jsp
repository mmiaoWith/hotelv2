<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" errorPage=""%>
    <%@ page import="java.sql.*" import="java.util.Date" import="album.bean.*" isELIgnored="false"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<META content="text/html; charset=utf-8" http-equiv=Content-Type>
<head>
  <!-- 1. Link to jQuery (1.8 or later), -->
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script> <!-- 33 KB -->

<!-- fotorama.css & fotorama.js. -->
<link  href="http://cdnjs.cloudflare.com/ajax/libs/fotorama/4.6.4/fotorama.css" rel="stylesheet"> <!-- 3 KB -->
<script src="http://cdnjs.cloudflare.com/ajax/libs/fotorama/4.6.4/fotorama.js"></script> <!-- 16 KB -->



<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/fotorama" charset="utf-8"></script>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/slide" charset="utf-8"></script>
<script>
if(!window.console)
	{
	 window.console={
			 log:function(){}
	 }
	}
</script>
<title>房间详细信息展示</title>
</head>
<body>
<center><h3>房间详细信息展示</h3></center>


<%
try
{
	Connection conn=null;
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	conn=DriverManager.getConnection("jdbc:sqlserver://localhost:1433;DatabaseName=ghotel","scott","1234");
	Statement smt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
	ResultSet rst=smt.executeQuery("select room.rid,case rtype when 1 then '单人间' when 2 then '双人间' else '三人间' end as rtype,case rsta when 1 then '海景房' else '普通房' end as rata,rprice,case rstand when 1 then'无独卫' else '设备齐全' end as rstand,rstate from room,roomdesign where room.rid=roomdesign.rid order by rid");
%>
<center>
<%@include file="slide/slide_img.html" %>
<br><br>

<table width="100%" border="1" align="center"  >
<%int j=1; %>
<%
//移动指针到第一条记录之前
rst.beforeFirst();
//移动记录指针到下一条记录
while(rst.next()&&j<=15)
{
%>
<%if(j%5==1){ %>
<tr>
<%} %>
<td align="center" bgcolor=lightgreen><%=rst.getInt(1) %><br><%=rst.getString(2)%><br><%=rst.getString(3) %><br><%=rst.getInt(4) %>元<br><%=rst.getString(5) %><br></td>
<% if(j%5==0){%>
</tr>
<%}
j++;%>
<%} %>
</table><p>
</center>
<br>
<br>
<%
String str="select * from image1";
ResultSet rs = null;
Statement stmt = conn.createStatement();
rs=stmt.executeQuery(str);
str=rs.getString("imagestore");
out.print(str);
%>


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