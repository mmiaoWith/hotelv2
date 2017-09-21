<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" errorPage=""%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" >
<title>添加员工</title>
</head>
<body>
<% if (session.getAttribute("pass")=="1") {
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
String sql="select top 1 pid from people order by pid desc ";
Statement stmt=conn.createStatement();	
ResultSet rs=stmt.executeQuery(sql);
 %>
<center>
<form  id="form1" name="form1" method="post"  action="CheckAddPeople.jsp" >
请输入新员工的信息
<table  align="center" width=100% border="0">
<tr><td align="right">&nbsp;员工编号：</td>
<% while(rs.next()){%>
<td align="left"><input align="right" name="id" type="text" value=<%=rs.getInt("pid")+1 %> onkeyup="value=value.replace(/[^\d]/g,'')" maxlength='4'></td>
<%} %>
</tr>
<tr></tr>
<tr><td align="right">&nbsp;员工密码：</td>
<td align="left"><input align="right" name="password" type="password" maxlength='4'></td>
</tr>
<tr></tr>
<tr><td align="right">&nbsp;员工职务：</td>
<td align="left">
<select name=position>
<option value="前台" selected>前台</option>
<option value="财务">财务</option>
<option value="后勤">后勤</option>
</select>
</td>
</tr>
<tr></tr>
<tr><td align="right"><input type="submit" name="Submit" value="提交"/></td>
<td align="left"><input type="reset" name="Submit2" value="重置"></td>
</tr>
</table>
</form>
<%conn.close();
stmt.close();
rs.close();  %>
</center>
<% } 
else { %>
<center>
<form method="get" action="login.jsp">
<input type=submit value="返回">
</form>
</center>
<% } %>
</body>
</html>
