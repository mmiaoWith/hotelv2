<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>后勤选择页</title>
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
d.add(1,0,'房间管理');
d.add(2,1,'设置房间信息','javascript:opena(\'SetRoom.jsp\')');
d.add(3,1,'查询房间信息','javascript:opena(\'SelRoomlog.jsp\')');
d.add(4,1,'修改房间信息','javascript:opena(\'AlterRoom.jsp\')');
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