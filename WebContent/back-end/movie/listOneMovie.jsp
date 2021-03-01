<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.movie.model.*"%>
<%
MovVO movVO = (MovVO) request.getAttribute("movVO");
%>

<html>
<head>
<title>電影詳情 - listOneMovie.jsp</title>
	<!-- Common CSS -->
	<%@ include file="../files/comCssLinks.file"%>
	<!-- Bootstrap CDN -->
	<%@ include file="../files/bootstrapCDN.file"%>
	<!-- Your custom styles (optional) -->
	<link rel="stylesheet" href="<%=request.getContextPath()%>/sources/css/backendMovie.css">
	
<style>
/* #section{
	background-color: rgba(119,136,153,.8);
} */
  table {
	width: 750px;
	margin: 5px auto 5px auto;
    
  /*   border: 2px solid #bb9d52; */
    background-color: rgb(255,255,255);
    border-radius: 10px;
	-webkit-box-shadow: 0px 3px 5px rgb(8,8,8, 0.3);
	-moz-box-shadow: 0px 3px 5px rgb(8,8,8, 0.3);
	box-shadow: 0px 3px 5px rgb(8,8,8, 0.3);
  }
  th,td{
  	box-sizing:border-box;
    border-radius: 10px;
  }
  th{
  	width: 200px;
  	padding: 10px 0px 10px 70px;
  }
  td{
  	width: 250px;
  	padding: 10px 20px 10px 30px;
    border-bottom: 2px dotted #bb9d52;
   /*  border: 2px solid rgba(119,136,153,.8); */
  }
  #section{
  	text-align:center;
  }
</style>

</head>
<body class="barber_version container-fluid">
    <div class="row">
        <!-- Start Side Bar-->
        <div class="col-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 sidebar-bgcolor">
			<c:set value="movieSub" var="urlRecog"></c:set>   <!-- 給sidebar_backend.file的子頁面參數 -->
			<%@ include file="../files/sidebar_backend.file"%><!-- ＊＊＊引入Side Bar＊＊＊ -->
        </div><!-- end Side Bar-->

        <!-- Start Section-->
        <div id="section" class="col-10 col-sm-10 col-md-10 col-lg-10 col-xl-10" style="margin: 20px 0 20px 0;">
        	<h3 class="h3-style" style="display: inline-block;">電影詳情&ensp;</h3>
			<table>
				<tr>
					<th>名稱</th>
					<td><%=movVO.getMovname()%></td>
				</tr>
				<tr>
					<th>種類</th>
					<td><%=movVO.getMovver()%></td>
				</tr>
				<tr>
					<th>類型</th>
					<td><%=movVO.getMovtype()%></td>
				</tr>
				<tr>
					<th>語言</th>
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
					<th>級數</th>
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
					<th>簡介</th>
					<td><%=movVO.getMovdes()%></td>
				</tr>
				<tr>
					<th>海報</th>
					<td>				
						<c:if test="${not empty movVO.movpos}">
							<img width="150px" src="<%=request.getContextPath()%>/movie/mov.do?movno=${movVO.movno}&action=get_One_MovPos">
						</c:if>
					</td>
				</tr>
				<tr>
					<th>預告片</th>
					<td>	
						<c:if test="${not empty movVO.movtra}">		
							<video controls width="300px"><source src="<%=request.getContextPath()%>/movie/mov.do?movno=${movVO.movno}&action=get_One_MovTra" type="video/mp4"></video>
						</c:if>
					</td>
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
	
			<a id="a-color" style="font-size: 15px;" href="<%=request.getContextPath()%>/back-end/movie/listAllMovie.jsp">回上頁</a>
        </div><!-- end Section-->
    </div>
</body>
</html>