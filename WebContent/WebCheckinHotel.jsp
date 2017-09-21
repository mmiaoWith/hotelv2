<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" errorPage=""%>
    <%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>网上订房</title>

<style type="text/css">.con { width:600px; height:auto; margin:0 auto; background:#fff; border:solid 1px #ccc; font-size:14px; font-family:Arial, Helvetica, sans-serif; }
  .input_div{width:100%;}
  //.input_div label{width:200px;float:left;text-align:left;}
  .input_div input{width:200px;float:center;}
</style>

<script language="javascript" type="text/javascript">
function getVal(id)
{
	/*
if (document.getElementById("Tel").value != ""){
var phone=document.getElementById("Tel").value;
var reg = /^(([0\+]\d{2,3}-)?(0\d{2,3})-)?(\d{7,8})(-(\d{3,}))?$/;
if (!reg.test(phone)){    
   document.getElementById("Tel").value='';    
   alert('对不起，您输入的电话号码有错误。区号和电话号码之间请用-分割');
   document.getElementById("Tel").focus();    
   return false;
}    
}  
	*/
if (document.getElementById("Mobile").value != ""){
var mobile=document.getElementById("Mobile").value;
//alert("长度："+mobile.value.length);
var reg0 = /^13\d{5,9}$/;    
var reg1 = /^15[0-35-9]\d{4,8}$/;    
var reg2 = /^18[0-9]\d{4,8}$/;     
var reg3 = /^0\d{10,11}$/;  
var my = false;
if (reg0.test(mobile)) my=true;    

if (reg1.test(mobile)) my=true;    
if (reg2.test(mobile)) my=true;    
if (reg3.test(mobile)) my=true;    
if (!my){    
   document.getElementById("Mobile").value='';    
   alert('对不起，您输入的手机号码有错误。');    
   document.getElementById("Mobile").focus();    
   return false;    
}else if(document.getElementById("Mobile").value.length!=11)
	{
	alert('对不起，您输入的手机号码不够11位。');    
	   document.getElementById("Mobile").focus();    
	   return false;    
	}

else
{
if(document.getElementById('StripImg').value=='')
{
$('#CreateStripImg').click(function(){CreateStripImg();});
$('#CreateStripImg').click();
}
}
return true;    
}
}

function getVal1(id)
{
if (document.getElementById("Idp").value != ""){
var shenfenzheng1=document.getElementById("Idp").value;
var reg=/^((\d{18})|(\d{17}[Xx]))$/;
var my = false;
//var a=shenfenzheng1.substring(0, 17);
//var b=shenfenzheng1.substring(17,18); 
if(reg.test(shenfenzheng1)) my=true;
/*
var c=a.match(reg1);
alert("c="+c);
if(c==null)
 alert('前17位必须是数字');
var d=a.match(reg2);
if(d==null)
 alert('最后一位必须是数字或X');
 */
if (!my){    
   document.getElementById("Idp").value='';    
   alert('对不起，您输入的身份证号有错误。');    
   document.getElementById("Idp").focus();    
   return false;    
}
else if(document.getElementById("Idp").value.length!=18)
	{
	alert('对不起，您输入的身份证号不够18位。');    
	   document.getElementById("Idp").focus();    
	   return false;    
	}

else
{
if(document.getElementById('StripImg').value=='')
{
$('#CreateStripImg').click(function(){CreateStripImg();});
$('#CreateStripImg').click();
}
}
return true;    
}
}


</script>
</head>
<%
String roomId=request.getParameter("rid");
//String intime1=request.getParameter("d11");
//获得上一个页面传来的入离时间
String intime=request.getParameter("param1");
String outtime=request.getParameter("param2");
//out.println("intime1="+intime);
//out.println("outtime1="+outtime);
try
{
	Connection conn=null;
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	conn=DriverManager.getConnection("jdbc:sqlserver://localhost:1433;DatabaseName=ghotel","scott","1234");
	Statement smt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
	ResultSet rst=smt.executeQuery("select rid,case rtype when 1 then '单人间' when 2 then '双人间' else '三人间' end as rtype,case rsta when 1 then '海景房' else '普通房' end as rata,rprice,case rstand when 1 then'无独卫' else '设备齐全' end as rstand from roomdesign where rid like '%"+roomId +"%' ");
	rst.last();
	int total=rst.getRow();
%>
 
<center>
<%
//移动指针到第一条记录之前
rst.beforeFirst();
//移动记录指针到下一条记录
while(rst.next())
{
%>
<form  id="form1" name="form1" method="post" action="WebCheckinHotel1.jsp?param1=<%=roomId %>&param3=<%=intime %>&param4=<%=outtime%>">
<%
//request.setAttribute("name",roomId);
%>

<br>
尊敬的顾客，您好，您所选择的房间信息如下：
<table width="100%" align="center" border="0" cellpadding="0" cellspacing="0"  >
<tr>
<td align="center" >房间号: <%=rst.getInt(1) %></td>
</tr>
<tr>
<td align="center"><%=rst.getString(2) %>&nbsp;&nbsp;</td>
</tr>
<tr>
<td align="center"><%=rst.getString(3) %>&nbsp;&nbsp;</td>
</tr>
<tr>
<td align="center">房价：<%=rst.getString(4) %>元&nbsp;&nbsp;</td>
</tr>
<tr>
<td align="center"><%=rst.getString(5) %>&nbsp;&nbsp;</td>
</tr>
</table>
<br>
<br>
如果信息无误，请完善如下信息：<br><br>
<div class="input_div">
请输入您的姓名：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input name="gname1" type="text" value="张三" align="middle">
<br> 
<br>
请输入您的身份证号:
<input name="id" id ="Idp" type="text" maxlength='18'  value="" onBlur="getVal1(this.id)" align="middle"  />
<br> 
<br>
请输入您的手机号：&nbsp;
<input name="phone1" id ="Mobile" type="text" maxlength='11'  value="" onBlur="getVal(this.id)" align="middle"  onkeyup="value=value.replace(/[^(\d)]/g,'')"/>
<br> 
<br>
请输入备注信息：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input name="more1" type="text" value=" " align="middle"/>
<br>
<br>
<br>
</div>
<input type="submit" name="Submit" value="提交"/>
<input type="button" name="Submit2" onclick="window.location.href='index.jsp'" value="取消">
</form>
</center>
<%} %>


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
