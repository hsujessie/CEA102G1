<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.movie.model.*"%>

<jsp:useBean id="listMovies_ByCompositeQuery" scope="request" type="java.util.List<MovVO>"/>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="shortcut icon" href="../../sources/images/logos/seenema_W.ico" type="image/x-icon" />
    <link rel="stylesheet" href="../../sources/css/cssReset.css">
    <link rel="stylesheet" href="../../sources/css/bootstrap.min.css">
    <link rel="stylesheet" href="../../sources/css/style.css">
	     
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

<title>電影查詢 - listMovies_ByCompositeQuery.jsp</title>

<style>
/* thead > tr > th{
 	width: 85px;
} */ 
thead > tr{
 	text-align: center;
}
.effect-1:after {
    border-radius: 2%;
}
</style>
</head>
<body class="barber_version container-fluid">
    <div class="row">
        <!-- Start Side Bar-->
        <div class="col-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 sections-com" style="background-color: rgb(232,232,232);">
			<%@ include file="../sidebar/sidebar_backend.file"%><!-- ＊＊＊引入Side Bar＊＊＊-->
        </div><!-- end Side Bar-->

        <!-- Start Section-->
        <div id="section" class="col-10 col-sm-10 col-md-10 col-lg-10 col-xl-10 sections-com">
        	<div style="box-sizing: border-box; padding: 2% 0 2% 0;">
	        	<h3>電影查詢</h3>
	            <table class="table table-responsive table-hover">
					<thead>
						<tr style="border-bottom: 3px solid #bb9d52;">
							<th>編號</th>
							<th>名稱</th>
							<th>種類</th>
							<th>類型</th>
							<th>語言</th>
							<th>上映日期</th>
							<th>下檔日期</th>
							<th>片長</th>
							<th>級數</th>
							<th>導演</th>
							<th>演員</th>
							<th>簡介</th>
							<th>海報</th>
							<th>預告片</th>
							<th>修改</th>
						</tr>				
					</thead>
							
					<tbody>
						<%@ include file="pages/page1_ByCompositeQuery.file"%> 
						<c:forEach var="movVO" varStatus="no" items="${listMovies_ByCompositeQuery}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
						<tr valign='middle' ${(movVO.movno==param.movno) ? 'bgcolor=#CCCCFF':''}>
							<td>${no.index+1}</td>
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
							<td><img width="150px" src="<%=request.getContextPath()%>/movie/mov.do?movno=${movVO.movno}&action=get_One_MovPos"></td>
							<td><video controls width="150px"><source src="<%=request.getContextPath()%>/movie/mov.do?movno=${movVO.movno}&action=get_One_MovTra" type="video/mp4"></video></td>
							<td>
							   <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/movie/mov.do" style="margin-bottom: 0px; text-align:center;">
							     <a class="btn btn-light btn-radius btn-brd grd1 effect-1" style="color:white;">
					                <input type="submit" value="修改" style="text-decoration: none; background-color:transparent; border:0px;">
					             </a>	
							     <input type="hidden" name="movno" value="${movVO.movno}">
							     <input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--送出本網頁的路徑給Controller-->
							     <input type="hidden" name="whichPage"	value="<%=whichPage%>">               <!--送出當前是第幾頁給Controller-->
							     <input type="hidden" name="action"	value="getOne_For_Update">
							   </FORM>
							</td>
						</tr>
						</c:forEach>
					</tbody>
				</table>
				<%@ include file="pages/page2_ByCompositeQuery.file" %>
			</div>
        </div><!-- end Section-->
    </div>
    
<%--     <br>本網頁的路徑:<br><b>
   <font color=blue>request.getServletPath():</font> <%=request.getServletPath()%><br>
   <font color=blue>request.getRequestURI(): </font> <%=request.getRequestURI()%> </b> --%>
</body>
</html>