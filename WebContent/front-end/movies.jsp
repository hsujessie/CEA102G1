<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Movies</title>
<%@ include file="files/comCssLinks.file"%>
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
                        <div class="col-lg-4 col-md-6 col-sm-12 movies-item first">
                            <div class="movies-wrap" id="lightboxbtn" >
                                <img src="img/portfolio-1.jpg" alt="Movies Image">
                                <figure>
                                    <p>Crime</p>
                                    <a href="#">Murder Case</a>
                                    <span>01-Jan-2045</span>
                                </figure>
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-6 col-sm-12 movies-item second">
                            <div class="movies-wrap">
                                <img src="img/portfolio-2.jpg" alt="Movies Image">
                                <figure>
                                    <p>Politics</p>
                                    <a href="#">Political Case</a>
                                    <span>01-Jan-2045</span>
                                </figure>
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-6 col-sm-12 movies-item third">
                            <div class="movies-wrap">
                                <img src="img/portfolio-3.jpg" alt="Movies Image">
                                <figure>
                                    <p>Family</p>
                                    <a href="#">Divorce Case</a>
                                    <span>01-Jan-2045</span>
                                </figure>
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-6 col-sm-12 movies-item third">
                            <div class="movies-wrap">
                                <img src="img/portfolio-4.jpg" alt="Movies Image">
                                <figure>
                                    <p>Finance</p>
                                    <a href="#">Money Laundering</a>
                                    <span>01-Jan-2045</span>
                                </figure>
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-6 col-sm-12 movies-item third">
                            <div class="movies-wrap">
                                <img src="img/portfolio-5.jpg" alt="Movies Image">
                                <figure>
                                    <p>Business</p>
                                    <a href="#">Weber & Partners</a>
                                    <span>01-Jan-2045</span>
                                </figure>
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-6 col-sm-12 movies-item third">
                            <div class="movies-wrap">
                                <img src="img/portfolio-6.jpg" alt="Movies Image">
                                <figure>
                                    <p>Finance</p>
                                    <a href="#">Property Sharing Case</a>
                                    <span>01-Jan-2045</span>
                                </figure>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Movies End -->

            <!-- Light Box Start -->
            <div class="movies-lightbox" id="movies-notice" style="display: none;">
                <div class="movies-content">
                    <div class="close">
                    </div>
                    <div class="movies-lightbox-inside">
                  </div>
                  <div class="movies-button">
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
        
        <!-- LightBox Javascript -->
        <script>
            let lightbox = document.getElementsByClassName("movies-lightbox")[0];
            let closeLightbox = document.getElementsByClassName("close")[0];
            let moviescontent = document.getElementsByClassName("movies-content")[0];
            let btn = document.getElementById("lightboxbtn");
            btn.onclick=function(){
                lightbox.style.display="block";
            }
            closeLightbox.onclick=function(){
                lightbox.style.display="none";
            }
        </script>
<%@ include file="files/comJsLinks.file"%>
</body>
</html>