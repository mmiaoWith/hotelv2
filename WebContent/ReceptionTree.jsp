<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>前台选择页</title>
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
d.add(2,0,'客人管理');
d.add(9,2,'客人登记','javascript:opena(\'guestin.jsp\')');
d.add(10,2,'查询客人信息');
d.add(12,10,'按身份证号查询','javascript:opena(\'oneguest.jsp\')');
d.add(13,10,'按姓名查询','javascript:opena(\'oneguestname.jsp\')');
d.add(15,2,'修改客人信息','javascript:opena(\'changeguest.jsp\')');
d.add(3,0,'房间管理');
d.add(16,3,'查询房间信息','javascript:opena(\'SelRoom.jsp\')');
d.add(4,0,'业务管理');
d.add(20,4,'结账功能(退房)','javascript:opena(\'CheckoutHotel.jsp\')');
d.add(21,4,'订单管理(续住)','javascript:opena(\'MOrder.jsp\')');
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