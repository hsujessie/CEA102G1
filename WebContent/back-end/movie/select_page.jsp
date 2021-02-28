<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
	<title>Movie Management</title>
	<!-- Common CSS -->
	<%@ include file="../files/comCssLinks.file"%>
	<!-- Bootstrap CDN -->	
	<%@ include file="../files/bootstrapCDN.file"%>
	<!-- Your custom styles (optional) -->
	<link rel="stylesheet" href="<%=request.getContextPath()%>/sources/css/backendMovie.css">
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
			        	<h3 class="h3-style">電影</h3>
			        	<h3 class="h3-style">列表</h3>
			        </div>
		            <div class="col-10 col-sm-10 col-md-10 col-lg-10 col-xl-10 content-pos">
		           		<a class="font-weight-seven pd-left" id="a-color" href="<%=request.getContextPath()%>/back-end/movie/listAllMovie.jsp">LIST</a> all Movies.<br>  
		            	
		            	<jsp:useBean id="movSvc" scope="page" class="com.movie.model.MovService"/>
<!-- ========================================= 以下 單一查詢 "getOne_For_Display" ========================================== -->
		                <%-- <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/movie/mov.do" >
		                    <b>選擇電影:</b>
		                    <select name="movno">
		                    <c:forEach var="movVO" items="${movSvc.all}" >
		                    <option value="${movVO.movno}">${movVO.movname}
		                    </c:forEach>
		                    </select>
		                    <input type="hidden" name="action" value="getOne_For_Display">
		        			<a class="btn btn-light btn-brd grd1 effect-1">
								<input type="submit" value="送出" class="input-pos">
		        			</a>
		                </FORM> --%>
<!-- ========================================= 以上 單一查詢 "getOne_For_Display" ========================================== -->
		           
		            </div>
		         </div><!-- end Center-content-->
			</div><!-- end Center-box-->
	        
	        <div class="center-box"><!-- Start Center-box-->
	        	<div class="row center-content"><!-- Start Center-content-->
		        	<div class="col-2 col-sm-2 col-md-2 col-lg-2 col-xl-2n titile-pos sty-line">
			        	<h3 class="h3-style">電影</h3>
						<h3 class="h3-style">查詢</h3>
					</div>
		            <div class="col-10 col-sm-10 col-md-10 col-lg-10 col-xl-10">
		            
<!-- ========================================= 以下 複合查詢 "listMovies_ByCompositeQuery" ========================================== -->
						<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/movie/mov.do" class="sty-form pd-left">
						
	                        <b>電影名稱</b>
	                            <select name="mov_no">
	                                <option value=""></option>
	                                <c:forEach var="movVO" items="${movSvc.all}" >
	                                    <option value="${movVO.movno}">${movVO.movname}
	                                </c:forEach>
	                            </select>
	                        <br><b>電影類型</b>
	                            <select name="mov_type">
	                                <option value=""></option>
									<option value="劇情片">劇情片</option>
									<option value="動作片">動作片</option>
									<option value="動畫片">動畫片</option>
									<option value="喜劇片">喜劇片</option>
									<option value="愛情片">愛情片</option>
									<option value="科幻片">科幻片</option>
									<option value="恐怖片">恐怖片</option>
	                            </select>
	                        <br><b>選擇年份</b>
	                        <select name="mov_ondate_year">
	                            <option value=""></option>
	                            <c:forEach var="year" begin="1970" end="<%= (int) (java.util.Calendar.getInstance().get(java.util.Calendar.YEAR))+1%>">
	                                <option value="${year}">${year}年</option>
	                            </c:forEach>
	                        </select>
	                        <br><b>選擇月份</b>
	                        <select name="mov_ondate_month">
	                            <option value=""></option>
	                            <c:forEach var="month" begin="1" end="12">
	                                <option value="${month}">${month}月</option>
	                            </c:forEach>
	                        </select>
	                        <input type="hidden" name="action" value="listMovies_ByCompositeQuery">
		        			<a class="btn btn-light btn-brd grd1 effect-1">
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
			        	<h3 class="h3-style">電影</h3>
	            		<h3 class="h3-style">新增</h3>
					</div>
		            <div class="col-10 col-sm-10 col-md-10 col-lg-10 col-xl-10 content-pos">
						<a id="a-color" class="font-weight-seven pd-left" data-toggle="modal" data-target="#basicModal" href="">ADD</a> an new Movie.
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
                <h3 style="margin-left: 40%; margin-top: 3%;" class="modal-title h3-style" id="myModalLabel" style="text-align:center; position:relative;">電影新增</h3>
                <button type="button" class="close sty-close-btn" data-dismiss="modal" aria-hidden="true"><i class="fa fa-close"></i></button>
            </div>
			
			<div class="modal-body center-linehigh-box sty-lightbox">
               <jsp:include page="addMovie.jsp"/><!-- 引入jsp-->
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
</html>