<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>财务选择页</title>
</head>
<link rel="StyleSheet" href="dtree.css" type="text/css" />
<script type="text/javascript" src="dtree.js"></script>
<% if (session.getAttribute("pass")=="1") {%>
<body>
<div class="dtree">
<script type="text/javascript">
function opena(url){
self.parent.frames['list'].location=url;
}
d=new dTree('d');
d.add(0,-1,'宾馆管理系统');
d.add(5,0,'财务');
d.add(25,5,'财务报表','javascript:opena(\'FinChart.jsp\')');
d.add(24,5,'客房使用情况分析','javascript:opena(\'trend.jsp\')');
document.write(d);
</script>
</div>
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