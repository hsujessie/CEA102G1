<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Movies</title>
<%@ include file="files/comCssLinks.file"%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/sources/css/frontendMovies.css">
<style>
 .lightbox-content-pos{
 	margin-top: 20px;
 }
 .lightbox-container{
 	background-color: #fff;
    padding: 50px;
    box-sizing: border-box;
 }
.lightbox-container h2{
	font-family: none;
	font-style: normal;
    font-weight: 600;
    color: #121518;
 }
</style>
</head>
<body>
        <div class="wrapper">
            <!-- Nav Bar Start -->
			<c:set value="${pageContext.request.requestURI}" var="urlRecog"></c:set>
            <%@ include file="files/navbar_frontend.file"%>
            <!-- Nav Bar End -->


            <!-- Page Header Start -->
            <div class="page-header">
                <div class="container">
                    <div class="row">
                        <div class="col-12">
                            <h2>Movies</h2>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Page Header End -->


            <!-- Movies Start -->
            <jsp:useBean id="movSvc" scope="page" class="com.movie.model.MovService"/>
            <div class="movies">
                <div class="container">
                    <div class="row">
                        <div class="col-12">
                            <ul id="movies-flters">
                                <li data-filter="*" class="filter-active">All</li>
                                <li data-filter=".first">Now Showing</li>
                                <li data-filter=".second">Comming Soon</li>
                            </ul>
                        </div>
                    </div>
                    <div class="row movies-container">
						<c:forEach var="movVO" items="${movSvc.all}" >
							<c:if test="${not empty movVO.movpos}">						    
		                        <div class="col-lg-4 col-md-6 col-sm-12 movies-item">
		                            <div class="movies-wrap" id="lightboxbtn" onclick="showLightboxb(this)">
		                                <img src="<%=request.getContextPath()%>/movie/mov.do?movno=${movVO.movno}&img=movpos&action=get_One_MovPos" alt="Movies Image">
		                                <figure>
		                                    <p><img style="width:100%; max-width: 40px;" src="<%=request.getContextPath()%>/sources/images/logos/seenema_W.ico" alt="Logo"></p>
		                                    <a href="">${movVO.movname}</a>
		                                    <span>${movVO.movondate}</span>
		                                </figure>
		                            </div>
		                        </div>
	                        </c:if>
						</c:forEach>
                    </div>
                </div>
            </div>
            <!-- Movies End -->

            <!-- Light Box Start -->
            <div class="movies-lightbox" id="movies-notice" style="display: none;">
                <div class="movies-content">
                    <div class="close"></div>
	                <div class="container lightbox-container">
	                    <div class="row">
	                        <div class="offset-2 col-4">
	                            <h2>名稱</h2>
	                        </div>
	                        <div class="col-6">
	                            <p>movie name</p>
	                        </div>
	                    </div>
	                    <div class="row lightbox-content-pos">
	                        <div class="offset-2 col-4">
	                            <h2>種類</h2>
	                        </div>
	                        <div class="col-6">
	                            <p>movie name</p>
	                        </div>
	                    </div>
	                    <div class="row lightbox-content-pos">
	                        <div class="offset-2 col-4">
	                            <h2>類型</h2>
	                        </div>
	                        <div class="col-6">
	                            <p>movie name</p>
	                        </div>
	                    </div>
	                    <div class="row lightbox-content-pos">
	                        <div class="offset-2 col-4">
	                            <h2>語言</h2>
	                        </div>
	                        <div class="col-6">
	                            <p>movie name</p>
	                        </div>
	                    </div>
	                    <div class="row lightbox-content-pos">
	                        <div class="offset-2 col-4">
	                            <h2>上映日期</h2>
	                        </div>
	                        <div class="col-6">
	                            <p>movie name</p>
	                        </div>
	                    </div>
	                    <div class="row lightbox-content-pos">
	                        <div class="offset-2 col-4">
	                            <h2>片長</h2>
	                        </div>
	                        <div class="col-6">
	                            <p>movie name</p>
	                        </div>
	                    </div>
	                    <div class="row lightbox-content-pos">
	                        <div class="offset-2 col-4">
	                            <h2>級數</h2>
	                        </div>
	                        <div class="col-6">
	                            <p>movie name</p>
	                        </div>
	                    </div>
	                    <div class="row lightbox-content-pos">
	                        <div class="offset-2 col-4">
	                            <h2>導演</h2>
	                        </div>
	                        <div class="col-6">
	                            <p>movie name</p>
	                        </div>
	                    </div>
	                    <div class="row lightbox-content-pos">
	                        <div class="offset-2 col-4">
	                            <h2>演員</h2>
	                        </div>
	                        <div class="col-6">
	                            <p>movie name</p>
	                        </div>
	                    </div>
	                    <div class="row lightbox-content-pos">
	                        <div class="offset-2 col-4">
	                            <h2>簡介</h2>
	                        </div>
	                        <div class="col-6">
	                            <p>movie name</p>
	                        </div>
	                    </div>
	                    <div class="row lightbox-content-pos">
	                        <div class="offset-2 col-10">
	                            <p>movie name</p>
	                        </div>
	                    </div>
	                </div>
               </div>
            </div>
            <!-- Light Box End -->
            
            <!-- Book Tickets Start -->
            <%@ include file="files/bookTicketsTamplate.file"%>
            <!-- Book Tickets End -->

            <!-- Footer Start -->
            <%@ include file="files/footer_frontend.file"%>
            <!-- Footer End -->
        </div>
        
<%@ include file="files/comJsLinks.file"%>     
<!-- LightBox Javascript -->
<script>
    let lightbox = document.getElementsByClassName("movies-lightbox")[0];
    let closeLightbox = document.getElementsByClassName("close")[0];
    let lightboxbtn = document.getElementById("lightboxbtn");
    
    function showLightboxb(e){
        lightbox.style.display="block";
    }
    
    closeLightbox.onclick=function(){
        lightbox.style.display="none";
    }
</script>
</body>
</html>