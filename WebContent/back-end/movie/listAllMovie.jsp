<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.movie.model.*"%>

<%
    MovService movSvc = new MovService();
    List<MovVO> list = movSvc.getAll();
    pageContext.setAttribute("list",list);
%>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="shortcut icon" href="../../sources/images/logos/seenema_W.ico" type="image/x-icon" />
    <link rel="stylesheet" href="../../sources/css/cssReset.css">
    <link rel="stylesheet" href="../../sources/css/style.css">
	    
<!-- ========================================= 以下 IMPORT要按順序 ========================================== -->
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
<!-- ========================================= 以上 IMPORT要按順序 ========================================== -->

<title>電影列表 - listAllMovie.jsp</title>

<style>
thead > tr{
 	text-align: center;
}

.effect-1:after {
    border-radius: 2%;
}
 
.w-brk {
    word-break: break-all;
    min-width: 800px;
    max-width: 1000px;
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
        <div id="section" class="col-10 col-sm-10 col-md-10 col-lg-10 col-xl-10">
        	<div style="width: 1200px; box-sizing: border-box; padding: 2% 2% 2% 0;">
	        	<h3 class="h3-style">電影列表</h3>
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
					<%@ include file="pages/page1.file" %> 
					<c:if test="${addSuccess != null}">
						<h2 style="color:red">  
							${addSuccess}
						</h2>
					</c:if>		
						<c:forEach var="movVO" items="${list}" varStatus="no" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
						<tr style="line-height:25px;" valign='middle' ${(movVO.movno==param.movno) ? 'bgcolor=#CCCCFF':''}>
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
							<td class="w-brk">${movVO.getMovdes()}</td>
							<td><img width="150px" src="<%=request.getContextPath()%>/movie/mov.do?movno=${movVO.movno}&action=get_One_MovPos"></td>
							<td><video controls width="150px"><source src="<%=request.getContextPath()%>/movie/mov.do?movno=${movVO.movno}&action=get_One_MovTra" type="video/mp4"></video></td>
							<td>
							  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/movie/mov.do" style="margin-bottom: 0px; text-align:center;">	
			        			 <a class="btn btn-light btn-radius btn-brd grd1 effect-1">
									<input type="submit" value="修改" class="input-pos">
			        			 </a>				            					             
							     <input type="hidden" name="movno" value="${movVO.movno}">
								 <input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--送出本網頁的路徑給Controller-->
								 <input type="hidden" name="whichPage"	value="<%=whichPage%>">
							     <input type="hidden" name="action"	value="getOne_For_Update">
							   </FORM>
							</td>
						</tr>
						</c:forEach>
					</tbody>
				</table>
			    <%@ include file="pages/page2.file" %>
			</div>
        </div><!-- end Section-->
    </div>
    
<%--     <br>本網頁的路徑:<br><b>
   <font color=blue>request.getServletPath():</font> <%=request.getServletPath()%><br>
   <font color=blue>request.getRequestURI(): </font> <%=request.getRequestURI()%> </b> --%>
</body>
</html>