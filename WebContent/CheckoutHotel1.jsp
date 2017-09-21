<%@page import="java.text.ParseException"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" errorPage=""%>
    <%@page import="java.text.SimpleDateFormat" import="java.text.DateFormat" %>
    <%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>退房</title>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");
String nroom=request.getParameter("nroom");
//连接数据库
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

//获得当前系统时间（即退房时间）
java.util.Date date=new java.util.Date();
String datestr=java.text.DateFormat.getDateTimeInstance().format(date);
SimpleDateFormat sdf1 =   new SimpleDateFormat( "yyyy-MM-dd HH:mm" );
java.util.Date timeDate = null;
try{
timeDate=sdf1.parse(datestr);
}
catch (ParseException e) {
// TODO 自动生成 catch 块
e.printStackTrace();
}//util类型
java.sql.Timestamp dateTime = new java.sql.Timestamp(timeDate.getTime());
//查询订单信息


try
{
	Statement smt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
	String sql="update room set rstate=0 where rid='"+nroom+"' ";
	smt.execute(sql);
}
catch(SQLException SE)
{
out.println();
SE.printStackTrace();
}
//更改订单的退房时间，以当前退房时间为准
try
{
	Statement smt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
	String sql="update orde set outime='"+dateTime+"' where rid='"+nroom+"' ";
	smt.execute(sql);
	
%>
<center>
	<h2>成功结帐！点击“提交”按钮查看账单信息</h2>
	</center>
	<center>
	<br>
	<br>
<form  id="form1" name="form1" method="post" action="ShowBill1.jsp?param1=<%=nroom %>">
房间号：<%=nroom %>
<input name="nroom" type="hidden" id="nroom" value="<%=nroom %>"/>

<br>
<br>
<input type="submit" name="Submit" value="提交"/>
<input type="reset" name="Submit2" value="重置">
</form>
</center>、
<%

}
catch(SQLException SE)
{
out.println();
SE.printStackTrace();
}

Statement smt1=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
ResultSet rst1=smt1.executeQuery("select * from bill");
rst1.last();
int total=rst1.getRow();
total++;
//out.println("total="+total);
Statement smt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
	ResultSet rst=smt.executeQuery("select oid,rid,gid,intime,outime,DATEDIFF(d,intime,outime) as days,DATEPART(HOUR, intime) as inhours, DATEPART(HOUR, outime) as outhours from orde where rid='"+nroom+"'");
	
//根据订单，在账单表中插入结帐信息
try{
	Statement smt2=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
	ResultSet rst2=smt2.executeQuery("select * from roomdesign where rid='"+nroom+"'");
	int price1=200;
	
	//移动指针到第一条记录之前
	
	rst2.beforeFirst();
	
	//移动记录指针到下一条记录
	while(rst2.next())
	{
		 price1=rst2.getInt(4);
		 //out.println("price="+price1);
	}
	
	rst.beforeFirst();
	while(rst.next())
	{
		int oid1=rst.getInt(1);
		int rid1=rst.getInt(2);
		int days1=rst.getInt(6);
		double disct1=1;
		if(rst.getInt(7)<12)
		{
			days1++;
			//out.println("days="+days1);
		}
		if(rst.getInt(8)>14)
		{
			days1++;
			//out.println("days="+days1);
		}
		float sum1=(float)(days1*price1-100);
		//out.println("sum1="+sum1);
		if(sum1>1000)
		{
		     disct1=0.95;
			 sum1=(float)(sum1*disct1);
		}else if(sum1>2000)
		{
			 disct1=0.90;
			 sum1=(float)(sum1*disct1);
		}
		else if(sum1>3000)
		{
		     disct1=0.85;
			 sum1=(float)(sum1*disct1);
		}
		
	
	String sql1="insert into bill(bid,oid,rid,disct,sum) values('"+total+"','"+oid1+"','"+rid1+"','"+disct1 +"','"+sum1 +"')";
    Statement stmt=conn.createStatement();	
    int rs=stmt.executeUpdate(sql1);
	}
}
catch(SQLException SE)
{
out.println();
SE.printStackTrace();
}

%>

</body>
</html>
