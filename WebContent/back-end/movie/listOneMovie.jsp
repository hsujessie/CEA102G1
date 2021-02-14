<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.movie.model.*"%>
<%
MovVO movVO = (MovVO) request.getAttribute("movVO");
%>

<html>
<head>
<title>電影 - listOneMovie.jsp</title>

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
  img{
  	width:50px;
  }
</style>

<style>
  table {
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
  	box-sizing:border-box;
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
		 <h3>電影 - listOneMovie.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/back-end/movie/select_page.jsp">回首頁</a></h4>
	</td></tr>
</table>

<table>
	<tr>
		<th>電影名稱</th>
		<td><%=movVO.getMovname()%></td>
	</tr>
	<tr>
		<th>電影種類</th>
		<td><%=movVO.getMovver()%></td>
	</tr>
	<tr>
		<th>電影類型</th>
		<td><%=movVO.getMovtype()%></td>
	</tr>
	<tr>
		<th>電影語言</th>
		<td><%=movVO.getMovlan()%></td>
	</tr>
	<tr>
		<th>上映日期</th>
		<td><%=movVO.getMovondate()%></td>
	</tr>
	<tr>
		<th>下檔日期</th>
		<td><%=movVO.getMovoffdate()%></td>
	</tr>
	<tr>
		<th>片長</th>
		<td><%=movVO.getMovdurat()%>小時</td>
	</tr>
	<tr>
		<th>電影級數</th>
		<td><%=movVO.getMovrating()%></td>
	</tr>
	<tr>
		<th>導演</th>
		<td><%=movVO.getMovditor()%></td>
	</tr>
	<tr>
		<th>演員</th>
		<td><%=movVO.getMovcast()%></td>
	</tr>
	<tr>
		<th>電影簡介</th>
		<td><%=movVO.getMovdes()%></td>
	</tr>
	<tr>
		<th>電影海報</th>
		<td><img src="<%=request.getContextPath()%>/movie/mov.do?movno=${movVO.movno}&action=get_One_MovPos"></td>
	</tr>
	<tr>
		<th>電影預告片</th>
		<td><video controls width="150"><source src="<%=request.getContextPath()%>/movie/mov.do?movno=${movVO.movno}&action=get_One_MovTra" type="video/mp4"></video></td>
	</tr>
	<tr>
		<th>滿意度總分</th>
		<td><%=movVO.getMovsatitotal()%></td>
	</tr>
	<tr>
		<th>滿意度評價人數</th>
		<td><%=movVO.getMovsatipers()%></td>
	</tr>
	<tr>
		<th>期待度總分</th>
		<td><%=movVO.getMovexpetotal()%></td>
	</tr>
	<tr>
		<th>期待度評價人數</th>
		<td><%=movVO.getMovexpepers()%></td>
	</tr>
</table>

</body>
</html>