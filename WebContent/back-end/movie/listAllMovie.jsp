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
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  	<!-- Font Awesome -->
	<link href='https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css' rel='stylesheet'></link> 
	   
<!-- ========================================= 以下 IMPORT要按順序 ========================================== -->
	<!-- 出現錯誤 $(...).modal is not a function，因Bootstrap的js文件，依賴於jQuery的js文件，要注意引入的顺序。-->
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
<!-- ========================================= 以上 IMPORT要按順序 ========================================== -->

	<!-- Your custom styles (optional) -->
	<link rel="stylesheet" href="<%=request.getContextPath()%>/sources/css/cssReset.css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/sources/css/style.css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/sources/css/backendMovie.css">

<title>電影列表 - listAllMovie.jsp</title>

<style>
thead > tr{
 	text-align: center;
}
 
.w-brk {
    word-break: break-all;
    min-width: 800px;
    max-width: 1000px;
}

.sty-height{
	line-height:25px;
}
</style>
</head>
<body class="barber_version container-fluid">
    <div class="row">
        <!-- Start Side Bar-->
        <div class="col-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 sidebar-bgcolor">       
			<c:set value="movieSub" var="urlRecog"></c:set>        <!-- 給sidebar_backend.file的參數-Sub -->
			<%@ include file="../sidebar/sidebar_backend.file"%>   <!-- ＊＊＊引入Side Bar＊＊＊ -->
        </div><!-- end Side Bar-->
 
        <!-- Start Section-->
        <div id="section" class="col-10 col-sm-10 col-md-10 col-lg-10 col-xl-10">
        	<div style="width: 1050px; box-sizing: border-box; padding: 2% 2% 2% 0;">
	        	<h3 class="h3-style" style="display: inline-block;">電影列表&ensp;</h3>
				<c:if test="${addSuccess != null}">
					<span style="color: #bb9d52">  
						${addSuccess}
						<i class="fa fa-hand-peace-o"></i>
					</span>
				</c:if>
				<c:if test="${updateSuccess != null }">
					<span style="color: #bb9d52">  
						${updateSuccess}
						<i class="fa fa-hand-peace-o"></i>
					</span>
				</c:if>
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
						<c:forEach var="movVO" items="${list}" varStatus="no" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
						<tr class="sty-height" valign='middle' ${(movVO.movno==param.movno) ? 'style="background-color:#bb9d52; color:#fff;"':''}>
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


<!-- =========================================================================================== 
    										以下 MODAL
	 ===========================================================================================  -->
<!-- Start Modal-->  
<div class="modal fade" id="basicModal" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content" style="background-color: rgba(119,136,153,.9);">
				
			<div class="modal-header" style="border: 1px solid rgba(119,136,153,.9);">
                <h3 style="margin-left: 40%; margin-top: 3%;" class="modal-title h3-style" id="myModalLabel" style="text-align:center; position:relative;">電影修改</h3>
                <button type="button" class="close sty-close-btn" data-dismiss="modal" aria-hidden="true"><i class="fa fa-close"></i></button>
            </div>
			
			<div class="modal-body center-linehigh-box sty-lightbox">
               <%-- <jsp:include page="update_movie_input.jsp"/> --%><!-- 引入jsp-->
               <iframe style="height:850px; width: 400px;" src="<%=request.getContextPath()%>/back-end/movie/update_movie_input.jsp"></iframe>
               <%-- 因用<jsp:include>，會接收前一個網頁的任何參數(課本p.191)，造成js會互相干擾，讓datetimepicker吃不到js，所以前台改用<iframe></iframe>的方式引入jsp，MovServlet.java要getSession()，讓jsp的EL抓得到值。 --%>               
			</div>		
		</div>
	</div>
</div><!-- end Modal-->
<%-- <%
  request.getSession().removeAttribute("openUpdateLightbox");
%> --%>
<c:if test="${openUpdateLightbox}">
	<!-- open modal要引入js，不然會出現錯誤 $(...).modal is not a function -->
	<!-- 因為會先讀JSTL，依據讀取順序，讀不到上面引入的js，所以出現錯誤，故在JSTL標籤內要引入js-->
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
	<script>	    	
		$("#basicModal").modal();
	</script>
</c:if>
    
<%--     <br>本網頁的路徑:<br><b>
   <font color=blue>request.getServletPath():</font> <%=request.getServletPath()%><br>
   <font color=blue>request.getRequestURI(): </font> <%=request.getRequestURI()%> </b> --%>
</body>
</html>