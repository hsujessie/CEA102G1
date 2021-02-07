<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.movie.model.*"%>

<%
  MovVO movVO = (MovVO) request.getAttribute("movVO");
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>新增電影資訊 - addMov.jsp</title>

<style>
  #table-1 {
	width: 450px;
	background-color: #CCCCFF;
	margin-top: 5px;
	margin-bottom: 10px;
    border: 3px ridge Gray;
    height: 80px;
    text-align: center;
  }
  #table-1 h4 {
    color: red;
    display: block;
    margin-bottom: 1px;
  }
  h4 {
    color: blue;
    display: inline;
  }
</style>

<style>
  table {
	table-layout: fixed;
	width: 450px;
	background-color: white;
	margin-top: 5px;
	margin-bottom: 5px;
  }
  table, th, td {
    border: 1px solid #CCCCFF;
  }
  th,td{
  	padding: 5px;
  	box-sizing:border-box;white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
  }
  th{
  	width:150px;
  }
  td{
  	width:300px;
  }
</style>

</head>
<body bgcolor='white'>

<table id="table-1">
	<tr><td>
		 <h3>新增電影資訊 - addMov.jsp</h3></td><td>
		 <h4><a href="<%=request.getContextPath()%>/back-end/movie/select_page.jsp">回首頁</a></h4>
	</td></tr>
</table>

<h3>新增電影資訊:</h3>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<FORM method="post" action="<%=request.getContextPath()%>/movie/mov.do" name="form_addMovie" enctype="multipart/form-data">
<table>
	<tr>
		<td>電影名稱:</td>
		<td><input type="text" name="movname" size="30"
			 value="<%= (movVO==null)? "金牌特務" : movVO.getMovname()%>" /></td>
	</tr>
	<tr>
		<td>電影種類:</td>
		<td>
			<!-- 多選checkbox -->
			<input type="checkbox" name="movver" value="2D">2D<br>
			<input type="checkbox" name="movver" value="3D">3D<br>
			<input type="checkbox" name="movver" value="IMAX 3D">IMAX 3D<br>
		</td>
	</tr>
	<tr>
		<td>電影類型:</td>
		<td>
			<select name="movtype">
				<option value= "動畫片">動畫片</option>
				<option value= "喜劇片">喜劇片</option>
				<option value= "愛情片">愛情片</option>
				<option value= "科幻片">科幻片</option>
				<option value= "恐怖片">恐怖片</option>
			</select>
		</td>
	</tr>
	<tr>
		<td>電影語言:</td>
		<td>
			<!-- 多選checkbox -->
			<input type="checkbox" name="movlan" value="英文">英文<br>
			<input type="checkbox" name="movlan" value="中文">中文<br>
		</td>
	</tr>
	<tr>
		<td>上映日期:</td>
		<td><input name="movondate" id="mov_ondate" type="text"></td>
	</tr>
	<tr>
		<td>下檔日期:</td>
		<td><input name="movoffdate" id="mov_offdate" type="text"></td>
	</tr>
	<tr>
		<td>片長:</td>
		<td><input type="text" name="movdurat" size="1"
			 value="<%= (movVO==null)? "2" : movVO.getMovdurat()%>" />小時</td>
	</tr>
	<tr>
		<td>電影級數:</td>
		<td>
			<select name="movrating">
				<option value="普遍級">普遍級</option>
				<option value="保護級">保護級</option>
				<option value="輔導級">輔導級</option>
				<option value="限制級">限制級</option>
			</select>
		</td>
	</tr>
	<tr>
		<td>導演:</td>
		<td><input type="text" name="movditor" size="30"
			 value="<%= (movVO==null)? "dicrector" : movVO.getMovditor()%>" /></td>
	</tr>
	<tr>
		<td>演員:</td>
		<td><input type="text" name="movcast" size="100"
			 value="<%= (movVO==null)? "actors" : movVO.getMovcast()%>" /></td>
	</tr>
	<tr>
		<td>電影簡介:</td>
		<td><textarea name="movdes" maxlength="500">
			<%= (movVO==null)? "description" : movVO.getMovdes()%></textarea>
		</td>
	</tr>
	<tr>
		<td>電影海報:</td>
		<td><input type="file" name="movpos"
			 value="<%= (movVO==null)? "poster" : movVO.getMovpos()%>" /></td>
	</tr>
	<tr>
		<td>電影預告片:</td>
		<td><input type="file" name="movtra"
			 value="<%=  (movVO==null)? "trailer" : movVO.getMovtra()%>" /></td>
	</tr>
</table>
<br>
<input type="hidden" name="action" value="insert">
<input type="submit" value="送出新增">
</FORM>
</body>
<%
  java.sql.Date movondate = null;
  java.sql.Date movoffdate = null;
  try {
	  movondate = movVO.getMovondate();
	  movoffdate = movVO.getMovoffdate();
   } catch (Exception e) {
	   movondate = new java.sql.Date(System.currentTimeMillis());
	   movoffdate = new java.sql.Date(System.currentTimeMillis());
   }
%>

<link   rel="stylesheet" type="text/css" href="../../source/datetimepicker/jquery.datetimepicker.css" />
<script src="../../source/datetimepicker/jquery.js"></script>
<script src="../../source/datetimepicker/jquery.datetimepicker.full.js"></script>
<style>
  .xdsoft_datetimepicker .xdsoft_datepicker {
           width:  300px;
  }
  .xdsoft_datetimepicker .xdsoft_timepicker .xdsoft_time_box {
           height: 151px;
  }
</style>
<script>
$.datetimepicker.setLocale('zh');
jQuery(function(){
    jQuery('#mov_ondate').datetimepicker({
        format:'Y-m-d',
        value: '<%=movondate%>',
        onShow:function( ct ){
        this.setOptions({
            maxDate:jQuery('#mov_offdate').val()?jQuery('#mov_offdate').val():false
        })
        },
        timepicker:false
 });
jQuery('#mov_offdate').datetimepicker({
    format:'Y-m-d',
    value: '<%=movoffdate%>',
    onShow:function( ct ){
    this.setOptions({
        minDate:jQuery('#mov_ondate').val()?jQuery('#mov_ondate').val():false
    })
    },
    timepicker:false
    });
});
</script>
</html>