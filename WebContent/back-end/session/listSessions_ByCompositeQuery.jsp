<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.session.model.*"%>

<jsp:useBean id="listSessions_ByCompositeQuery" scope="request" type="java.util.List<SesVO>"/>
<jsp:useBean id="movSvc" scope="page" class="com.movie.model.MovService"/>
<html>
<head>
	<title>場次查詢</title>
	<!-- Common CSS -->
	<%@ include file="../files/comCssLinks.file"%> 
  	<!-- Bootstrap CDN -->	
	<%@ include file="../files/bootstrapCDN.file"%>
<style>
thead > tr{
 	text-align: center;
}
.effect-1:after, .btn-brd {
    -webkit-border-radius: 10px;
    -moz-border-radius: 10px;
    border-radius: 10px;
}
.input-pos {
    top: 0%;
}   
.sty-height{
	line-height:25px;
}
.ifram-sty{
	background-color: #fff;
	height: 750px;
	width: 650px;
	margin-left: 7%;
}
</style>
</head>
<body class="barber_version container-fluid">
    <div class="row">
        <!-- Start Side Bar-->
        <div class="col-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 sidebar-bgcolor">
			<c:set value="sessionSub" var="urlRecog"></c:set>  <!-- 給sidebar_backend.file的參數-Sub -->
			<%@ include file="../files/sidebar_backend.file"%> <!-- ＊＊＊引入Side Bar＊＊＊ -->
        </div><!-- end Side Bar-->

        <!-- Start Section-->
        <div id="section" class="col-10 col-sm-10 col-md-10 col-lg-10 col-xl-10">
        	<div style="width: 1050px; box-sizing: border-box; padding: 2% 2% 2% 0;">
	        	<h3 class="h3-style">場次查詢</h3>
	            <table class="table table-responsive table-hover">
					<thead>
						<tr style="border-bottom: 3px solid #bb9d52;">
							<th>編號</th>
							<th>電影</th>
							<th>場次日期</th>
							<th>場次時間</th>
							<th>廳院</th>
							<th>修改</th>
						</tr>				
					</thead>
							
					<tbody>
						<%@ include file="pages/page1_ByCompositeQuery.file"%> 
						<c:forEach var="sesVO" varStatus="no" items="${listSessions_ByCompositeQuery}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
						<c:set value="${movSvc.getOneMov(sesVO.movNo)}" var="movObj"></c:set>
						<tr class="sty-height" valign='middle' ${(sesVO.sesNo==param.sesNo) ? 'style="background-color:#bb9d52; color:#fff;"':''}>
							<td>${no.index+1}</td>
							<td>${movObj.movname}</td>
							<td>${sesVO.getSesDate()}</td>
							<td>${sesVO.getSesTime()}</td>
							<td>${sesVO.getTheNo()}</td>
							<td>
							   <a class="btn btn-light btn-brd grd1 effect-1">
									<input type="button" value="修改" class="input-pos update-btn" data-sesno="${sesVO.sesNo}">
			        			 </a>
							</td>
						</tr>
						</c:forEach>
					</tbody>
				</table>
				<%@ include file="pages/page2_ByCompositeQuery.file" %>
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
                <h3 style="margin-left: 40%; margin-top: 3%;" class="modal-title h3-style" id="myModalLabel" style="text-align:center; position:relative;">場次修改</h3>
                <button type="button" class="close sty-close-btn" data-dismiss="modal" aria-hidden="true"><i class="fa fa-close"></i></button>
            </div>
			
			<div class="modal-body center-linehigh-box sty-lightbox">
             	<iframe class="ifram-sty" src=""></iframe>
			</div>		
		</div>
	</div>
</div><!-- end Modal-->
	<script> 
	 	$(".update-btn").click(function(e){
	 		e.preventDefault();
	 		let sesNo = $(this).attr("data-sesno");
	 		let url = "<%=request.getContextPath()%>/session/ses.do?action=getOne_For_Update&sesNo=" + sesNo + "&requestURL=<%=request.getServletPath()%>&openUpdateLightbox=false";
	 		let iframe = document.getElementsByTagName("iframe")[0];
	 		iframe.setAttribute("src",url);
			$("#basicModal").modal();
	 	});
		 <c:if test="${openUpdateLightbox == false}">
			window.parent.location.reload();  
		</c:if>
	</script>
<%--     <br>本網頁的路徑:<br><b>
   <font color=blue>request.getServletPath():</font> <%=request.getServletPath()%><br>
   <font color=blue>request.getRequestURI(): </font> <%=request.getRequestURI()%> </b> --%>
</body>
</html>