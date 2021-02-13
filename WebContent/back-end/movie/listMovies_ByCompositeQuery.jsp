<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.movie.model.*"%>

<jsp:useBean id="listMovies_ByCompositeQuery" scope="request" type="java.util.List<MovVO>" />

<html>
<title>複合查詢 - listMovies_ByCompositeQuery.jsp</title>

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
  img{
  	width:50px;
  }
</style>

</head>
<body>
<body bgcolor='white'>
<table id="table-1">
	<tr><td>
		 <h3>所有電影資訊 - listAllMovie.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/back-end/movie/select_page.jsp">回首頁</a></h4>
	</td></tr>
</table>

<table>

	<tr>
		<th>電影編號</th>
		<th>電影名稱</th>
		<th>電影種類</th>
		<th>電影類型</th>
		<th>電影語言</th>
		<th>上映日期</th>
		<th>下檔日期</th>
		<th>片長</th>
		<th>電影級數</th>
		<th>導演</th>
		<th>演員</th>
		<th>電影簡介</th>
		<th>電影海報</th>
		<th>電影預告片</th>
		<th>修改</th>
	</tr>
	<%@ include file="pages/page1_ByCompositeQuery.file" %> 
	<c:forEach var="movVO" items="${listMovies_ByCompositeQuery}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
	<tr align='center' valign='middle' ${(movVO.movno==param.movno) ? 'bgcolor=#CCCCFF':''}>
		<td>${movVO.getMovno()}</td>
		<td>${movVO.getMovname()}</td>
		<td>${movVO.getMovver()}</td>
		<td>${movVO.getMovtype()}</td>
		<td>${movVO.getMovlan()}</td>
		<td>${movVO.getMovondate()}</td>
		<td>${movVO.getMovoffdate()}</td>
		<td>${movVO.getMovdurat()}小時</td>
		<td>${movVO.getMovrating()}</td>
		<td>${movVO.getMovditor()}</td>
		<td>${movVO.getMovcast()}</td>
		<td>${movVO.getMovdes()}</td>
		<td><img src="<%=request.getContextPath()%>/movie/mov.do?movno=${movVO.movno}&img=movpos&action=get_One_MovPic"></td>
		<td><img src="<%=request.getContextPath()%>/movie/mov.do?movno=${movVO.movno}&img=movtra&action=get_One_MovPic"></td>
		<td>
		  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/movie/mov.do" style="margin-bottom: 0px; text-align:center;">
		     <input type="submit" value="修改">
		     <input type="hidden" name="movno"  value="${movVO.movno}">
		     <input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--送出本網頁的路徑給Controller-->
		     <input type="hidden" name="whichPage"	value="<%=whichPage%>">               <!--送出當前是第幾頁給Controller-->
		     <input type="hidden" name="action"	value="getOne_For_Update">
		   </FORM>
		</td>
	</tr>
	</c:forEach>
</table>
<%@ include file="pages/page2_ByCompositeQuery.file" %>


<br>本網頁的路徑:<br><b>
   <font color=blue>request.getServletPath():</font> <%=request.getServletPath()%><br>
   <font color=blue>request.getRequestURI(): </font> <%=request.getRequestURI()%> </b>


</body>
</html>