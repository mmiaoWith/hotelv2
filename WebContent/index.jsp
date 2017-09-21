<%@page import="java.text.ParseException"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" errorPage=""%>
    <%@ page import="java.sql.*" import="java.util.Date"%>
    <%@page import="java.text.SimpleDateFormat" import="java.text.DateFormat" %>
      
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>网上订房</title>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/My97DatePicker/WdatePicker.js" charset="utf-8"></script>

<script language="javascript">
  <!--
   function initVal(obj){
	 document.getElementById("rid").value= obj.innerHTML;
	 }

  //--> 
  </script>

<script type="text/javascript">
function showRoom(str)
{
var xmlhttp;    
if (str=="")
  {
  document.getElementById("d11").innerHTML="";
  return;
  }
if (window.XMLHttpRequest)
  {// code for IE7+, Firefox, Chrome, Opera, Safari
  xmlhttp=new XMLHttpRequest();
  }
else
  {// code for IE6, IE5
  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  }
xmlhttp.onreadystatechange=function()
  {
  if (xmlhttp.readyState==4 && xmlhttp.status==200)
    {
    document.getElementById("txtHint").innerHTML=xmlhttp.responseText;
    }
  }
xmlhttp.open("GET","/ajax/getRoom.jsp?q="+str,true);
xmlhttp.send();
}
</script>

</head>
<body>
<%
//获得系统时间
java.util.Date date=new java.util.Date();
String datestr=java.text.DateFormat.getDateInstance().format(date);
String star=request.getParameter("d11");
if(star==null) star=datestr;
java.util.GregorianCalendar now = new java.util.GregorianCalendar();
SimpleDateFormat fmtrq = new SimpleDateFormat("yyyy-MM-dd HH:mm");
DateFormat df = DateFormat.getDateInstance();
//out.println(fmtrq.format(now.getTime()));
now.add(java.util.GregorianCalendar.DATE,1);
//out.println("当前系统时间加一天："+fmtrq.format(now.getTime()));
String str=fmtrq.format(now.getTime()).substring(0,10);

String star1=request.getParameter("d12");
if(star1==null) star1=str;
%>
<p ><a href="login.jsp">管理</a></p>
<center><h3>网上订房</h3></center>

<br><br>
<form  id="form1" name="form1" method="get" action="">
 请选择入离日期：<br><br>
 <input id="d11" name="d11" type="text" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'%y-%M-{%d}',maxDate:'%y-%M-{%d+180}',isShowClear:false,readOnly:true,doubleCalendar:true})" value="<%=star %>" class="Wdate"/>
  到
  <input id="d12" name="d12" type="text" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'%y-%M-{%d+1}',maxDate:'%y-%M-{%d+180}',isShowClear:false,readOnly:true,doubleCalendar:true})" value="<%=star1 %>" class="Wdate"/>&nbsp;&nbsp;
  <input  type="submit" name="Submit" value="查询" />
</form>
<br>
<form id="form3" action="WebgetRoom.jsp">
<input type="submit" value="查看房间信息">
</form>
<br>

 
<table border="0" >
<tr>
<td height=20 width=30 align="center" bgcolor=pink></td>
<td></td>
<td align="right">在住或已预订</td>
<td height=20 width=30 align="center" bgcolor=lightgreen></td>
<td></td>
<td align="right">可预订</td>
</tr>
</table>
<br>



<% 
String intime=request.getParameter("d11");
String outtime=request.getParameter("d12");
String t=" 11:59";
String t1=" 14:00";
String t2=" 23:59";
if(intime==null)
{
	intime=datestr;
	String intime1=intime+t1;
	String intime2=intime+t2;
    //out.println("intime1: "+intime);
}


if(outtime==null)
{
	outtime=fmtrq.format(now.getTime());
	String outtime1=outtime+t;
	
}
String intime1=intime+t1;
String intime2=intime+t2;
String outtime1=outtime+t;

//日期转换（string转化为sql的datetime类型）
SimpleDateFormat sdf =   new SimpleDateFormat( "yyyy-MM-dd HH:mm" );//24小时制 
SimpleDateFormat sdf1 =   new SimpleDateFormat( "yyyy-MM-dd" );
//String aa="2015-05-19 12:00:00";
java.util.Date timeDatein2 = null;
java.util.Date timeDatein1 = null;
java.util.Date timeDateout = null;
java.util.Date timeDateout1 = null;
try {
 timeDatein1=sdf.parse(intime1);
 timeDatein2 = sdf.parse(intime2);
 timeDateout=sdf1.parse(outtime);
 timeDateout1 = sdf.parse(outtime1);
 //out.println("timeDate="+timeDate);
} catch (ParseException e) {
 // TODO 自动生成 catch 块
 e.printStackTrace();
}//util类型
//java.sql.Date dateTime = new java.sql.Date(timeDate.getTime());//sql类型
java.sql.Timestamp dateTimein1 = new java.sql.Timestamp(timeDatein1.getTime());
java.sql.Timestamp dateTimein2 = new java.sql.Timestamp(timeDatein2.getTime());
java.sql.Timestamp dateTimeout = new java.sql.Timestamp(timeDateout.getTime());
java.sql.Timestamp dateTimeout1 = new java.sql.Timestamp(timeDateout1.getTime());


%>



<%
try
{
	Connection conn=null;
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	conn=DriverManager.getConnection("jdbc:sqlserver://localhost:1433;DatabaseName=ghotel","scott","1234");
	Statement smt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
	ResultSet rst=smt.executeQuery("SELECT a.rid,CASE WHEN exists(SELECT 1 FROM ORDE b WHERE a.rid=b.rid AND( intime BETWEEN '"+dateTimein1+"' AND '"+dateTimein2+"' or outime BETWEEN '"+dateTimeout+"' AND '"+dateTimeout1+"' or(outime>'"+dateTimein1+"' and intime<'"+dateTimeout1+"'))   ) THEN '不可订' else '可订' end as rstate FROM room a");
	%>
   
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
	<%
	String s1=rst.getString(2);
	//out.println("s1: "+s1);
	if(s1.equals("不可订"))
	{
		
	%>
	<td align="center" bgcolor=pink><%=rst.getInt(1) %></td>
	<% }
	else {%>
	<td onClick="initVal(this)" align="center" bgcolor=lightgreen><%=rst.getInt(1) %></td>

	<% } %>
	<%  if(j%5==0){%>
	</tr>
	<%}
	j++;%>
	<%} %>
	</table><p>
	<br>

<% }
catch(SQLException SE)
{
out.println();
SE.printStackTrace();
} %>

<form  id="form2" name="form2" method="post" action="WebCheckinHotel.jsp?param1=<%=dateTimein1 %>&param2=<%=dateTimeout1 %>">
您所选择的房间为：<br><br>
 <input type="text" name=rid id="rid" value="" border="0" />&nbsp;&nbsp;
<input  type="submit" name="Submit" value="预订"/> 
</form>
<br><br>
</body>
</html>