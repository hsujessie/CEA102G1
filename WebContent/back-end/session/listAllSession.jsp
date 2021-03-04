<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.session.model.*"%>
<%    
    SesService sesSvc = new SesService();
    List<SesVO> list = sesSvc.getAll();
    pageContext.setAttribute("list",list);
%>
<jsp:useBean id="movSvc" scope="page" class="com.movie.model.MovService"/>

<html>
<head>
	<title>場次列表</title>
	<!-- Common CSS -->
	<%@ include file="../files/comCssLinks.file"%>
	<!-- Bootstrap CDN -->	
	<%@ include file="../files/bootstrapCDN.file"%>
	<!-- Your custom styles (optional) -->
	<link rel="stylesheet" href="<%=request.getContextPath()%>/resource/css/backendMovie.css">
<style>
thead > tr{
 	text-align: center;
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
			<c:set value="sessionSub" var="urlRecog"></c:set>        <!-- 給sidebar_backend.file的參數-Sub -->
			<%@ include file="../files/sidebar_backend.file"%> <!-- ＊＊＊引入Side Bar＊＊＊ -->
        </div><!-- end Side Bar-->
 
        <!-- Start Section-->
        <div id="section" class="col-10 col-sm-10 col-md-10 col-lg-10 col-xl-10">
        	<div style="width: 1050px; box-sizing: border-box; padding: 2% 2% 2% 0;">
	        	<h3 class="h3-style" style="display: inline-block;">場次列表&ensp;</h3>
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
							<th>電影</th>
							<th>場次日期</th>
							<th>場次時間</th>
							<th>廳院</th>
							<th>修改</th>
						</tr>				
					</thead>
							
					<tbody>
					<%@ include file="../movie/pages/page1.file" %> 	
						<c:forEach var="sesVO" items="${list}" varStatus="no" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
						<c:set value="${movSvc.getOneMov(sesVO.sesNo)}" var="movObj"></c:set>
						<tr class="sty-height" valign='middle' ${(sesVO.sesNo==param.sesNo) ? 'style="background-color:#bb9d52; color:#fff;"':''}>
							<td>${no.index+1}</td>
							<td>${movObj.movname}</td>
							<td>${sesVO.getSesDate()}</td>
							<td>${sesVO.getSesTime()}</td>
							<td>${sesVO.getTheNo()}</td>
							<td>
							  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/session/ses.do" style="margin-bottom: 0px; text-align:center;">	
			        			 <a class="btn btn-light btn-brd grd1 effect-1">
									<input type="submit" value="修改" class="input-pos">
			        			 </a>				            					             
							     <input type="hidden" name="sesNo" value="${sesVO.sesNo}">
								 <input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--送出本網頁的路徑給Controller-->
								 <input type="hidden" name="whichPage"	value="<%=whichPage%>">
							     <input type="hidden" name="action"	value="getOne_For_Update">
							   </FORM>
							</td>
						</tr>
						</c:forEach>
					</tbody>
				</table>
			    <%@ include file="../movie/pages/page2.file" %>
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
               <jsp:include page="update_session_input.jsp"/><!-- 引入jsp-->            
			</div>		
		</div>
	</div>
</div><!-- end Modal-->

	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
	<script>
		 <c:if test="${openUpdateLightbox}">
			$("#basicModal").modal();
		</c:if> 
		 <c:if test="${openUpdateLightbox == false}">
	   	   	$("#basicModal").modal("hide"); 
		</c:if> 
			
<%-- 		function getData(e,movno){
			let href = "<%=request.getContextPath()%>/movie/mov.do?action=getOne_For_Display&requestURL=<%=request.getServletPath()%>&movno="+movno;
			e.setAttribute("href", href);
		} --%>
	</script>
    
<%--     <br>本網頁的路徑:<br><b>
   <font color=blue>request.getServletPath():</font> <%=request.getServletPath()%><br>
   <font color=blue>request.getRequestURI(): </font> <%=request.getRequestURI()%> </b> --%>
</body>
</html>