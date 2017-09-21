<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>查询单个房间信息</title>
</head>
<% if (session.getAttribute("pass")=="1") {%>
<body>
<center>
<form  id="form1" name="form1" method="post" action="ShowSingle.jsp">
请输入你要查询的房间的房间号（如：5001）：
<input name="nroom" type="text" id="nroom"/>
<br>
<br>
<input type="submit" name="Submit" value="提交"/>
<input type="reset" name="Submit2" value="重置">
</form>
</center>
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