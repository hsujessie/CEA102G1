<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
	<title>Session Management</title>
	<!-- Common CSS -->
	<%@ include file="../files/comCssLinks.file"%>
	<!-- Bootstrap CDN -->	
	<%@ include file="../files/bootstrapCDN.file"%>
	<!-- Your custom styles (optional) -->
	<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/backendMovie.css">
<style>
  .sty-input{
	text-decoration: none;    
	border-color: transparent;
    width: 150px;
    border-bottom: 2px dashed #bb9d52;
    box-sizing: border-box;
    padding-bottom: 3px;
    color: #bb9d52;
	line-hight: 5px;
  }
</style>
</head>
<body class="barber_version container-fluid">
    <div class="row">
        <!-- Start Side Bar-->
        <div class="col-2 col-sm-2 col-md-2 col-lg-2 col-xl-2 sidebar-bgcolor">     
			<c:set value="${pageContext.request.requestURI}" var="urlRecog"></c:set> <!-- 給sidebar_backend.file的參數-Home -->
			<%@ include file="../files/sidebar_backend.file"%> <!-- ＊＊＊引入Side Bar＊＊＊ -->
        </div><!-- end Side Bar-->

        <!-- Start Section-->
        <div id="section" class="col-10 col-sm-10 col-md-10 col-lg-10 col-xl-10">
        	
	        <div class="center-box"><!-- Start Center-box-->
	        	<div class="row center-content"><!-- Start Center-content-->
		        	<div class="col-2 col-sm-2 col-md-2 col-lg-2 col-xl-2n titile-pos sty-line">
			        	<h3 class="h3-style">場次</h3>
			        	<h3 class="h3-style">列表</h3>
			        </div>
		            <div class="col-10 col-sm-10 col-md-10 col-lg-10 col-xl-10 content-pos">
		           		<a class="font-weight-seven pd-left" id="a-color" href="<%=request.getContextPath()%>/back-end/session/listAllSession.jsp">LIST</a> all Sessions.<br>  
		            	
		            	<jsp:useBean id="sesSvc" scope="page" class="com.session.model.SesService"/>
		           
		            </div>
		         </div><!-- end Center-content-->
			</div><!-- end Center-box-->
	        
	        <div class="center-box"><!-- Start Center-box-->
	        	<div class="row center-content"><!-- Start Center-content-->
		        	<div class="col-2 col-sm-2 col-md-2 col-lg-2 col-xl-2n titile-pos sty-line">
			        	<h3 class="h3-style">場次</h3>
						<h3 class="h3-style">查詢</h3>
					</div>
		            <div class="col-10 col-sm-10 col-md-10 col-lg-10 col-xl-10">
		            
<!-- ========================================= 以下 複合查詢 "listSessions_ByCompositeQuery" ========================================== -->
						<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/session/ses.do" class="sty-form pd-left">						
							<jsp:useBean id="movSvc" scope="page" class="com.movie.model.MovService"/>
	                        <b>電影名稱</b>
	                            <select name="movNo">	                            
	                                <option value=""></option>
				                    <c:forEach var="movVO" items="${movSvc.all}" >
				                    	<option value="${movVO.movno}">${movVO.movname}
				                    </c:forEach>
			                    </select>
	                        <br><b>場次日期</b>
	                        <input class="sty-input" name="sesDateBegin" id="" type="date" value="" style="margin-left: 10px;"> 
	                        ~<input class="sty-input" name="sesDateEnd" id="" type="date" value="">
	                        
	                        <input type="hidden" name="action" value="listSessions_ByCompositeQuery">
	                        <br>
		        			<a class="btn btn-light btn-brd grd1 effect-1" style="margin: 3% 0 0 13%;">
								<input type="submit" value="送出" class="input-pos">
		        			</a>
	                    </FORM>
<!-- ========================================= 以上 複合查詢 "listMovies_ByCompositeQuery" ========================================== -->

					</div>
		         </div><!-- end Center-content-->
			</div><!-- end Center-box-->
			
	        <div class="center-box"><!-- Start Center-box-->
	        	<div class="row center-content"><!-- Start Center-content-->
		        	<div class="col-2 col-sm-2 col-md-2 col-lg-2 col-xl-2n titile-pos sty-line">
			        	<h3 class="h3-style">場次</h3>
	            		<h3 class="h3-style">新增</h3>
					</div>
		            <div class="col-10 col-sm-10 col-md-10 col-lg-10 col-xl-10 content-pos">
						<a id="a-color" class="font-weight-seven pd-left" data-toggle="modal" data-target="#basicModal" href="">ADD</a> new Sessions.
					</div>
		         </div><!-- end Center-content-->
			</div><!-- end Center-box-->
				
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
                <h3 style="margin-left: 40%; margin-top: 3%;" class="modal-title h3-style" id="myModalLabel" style="text-align:center; position:relative;">場次新增</h3>
                <button type="button" class="close sty-close-btn" data-dismiss="modal" aria-hidden="true"><i class="fa fa-close"></i></button>
            </div>
			
			<div class="modal-body center-linehigh-box sty-lightbox">
               <jsp:include page="addSession.jsp"/><!-- 引入jsp-->
			</div>		
		</div>
	</div>
</div><!-- end Modal-->
<c:if test="${openAddLightbox}">
	<!-- open modal要引入js，不然會出現錯誤 $(...).modal is not a function -->
	<!-- 因為會先讀JSTL，依據讀取順序，讀不到上面引入的js，所以出現錯誤，故在JSTL標籤內要引入js-->
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
	<script>	    	
		$("#basicModal").modal();
	</script>
</c:if>
</body>
<script>
</script>
</html>