<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Movies</title>
<%@ include file="../files/comCssLinks.file"%>
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
			<c:set value="moviesSub" var="urlRecog"></c:set>        <!-- 給navbar_frontend.file的參數-Sub -->
            <%@ include file="../files/navbar_frontend.file"%>
            <!-- Nav Bar End -->


            <!-- Information Start -->
            <div class="movinfo">
                <div class="container">
                    <div class="row align-items-center">
                        <div class="col-lg-5 col-md-6">
                            <div class="movinfo-img">
                                <img src="img/about.jpg" alt="Image">
                            </div>
                        </div>
                        <div class="col-lg-7 col-md-6">
                            <div class="section-header">
                                <h2>Information</h2>
                            </div>
                            <div class="movinfo-text">
                                <p>上映日期 </p>
                                <p>類   型 </p>
                                <p>級   數 </p>
                                <p>片   長 </p>
                                <p>導   演 </p>
                                <p>演   員 </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Information End -->

            <!-- Synopsis Start -->
            <div class="movinfo">
                <div class="container">
                    <div class="row align-items-center">
                        <div class="col-lg-12 col-md-12">
                            <div class="section-header">
                                <h2>Synopsis</h2>
                            </div>
                            <div class="movinfo-text">
                                <p>電影簡介</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Synopsis End -->


            <!-- Reviews Start -->
            <div class="reviews">
                <div class="container">
                    <div class="section-header">
                        <h2>Reviews</h2>
                    </div>
                    <div class="reviews-start">
                        <div class="reviews-container left">
                            <div class="reviews-content">
                                <h2><span>Ratings</span><i class="fa fa-star" aria-hidden="true"></i></h2>
                                <p>
                                    Lorem ipsum dolor sit amet elit. Aliquam odio dolor, id luctus erat sagittis non. Ut blandit semper pretium.
                                </p>
                            </div>
                        </div>
                        <div class="reviews-container right">
                            <div class="reviews-content">
                                <h2><span>Ratings</span><i class="fa fa-star" aria-hidden="true"></i></h2>
                                <p>
                                    Lorem ipsum dolor sit amet elit. Aliquam odio dolor, id luctus erat sagittis non. Ut blandit semper pretium.
                                </p>
                            </div>
                        </div>
                        <div class="reviews-container left">
                            <div class="reviews-content">
                                <h2><span>Ratings</span><i class="fa fa-star" aria-hidden="true"></i></h2>
                                <p>
                                    Lorem ipsum dolor sit amet elit. Aliquam odio dolor, id luctus erat sagittis non. Ut blandit semper pretium.
                                </p>
                            </div>
                        </div>
                        <div class="reviews-container right">
                            <div class="reviews-content">
                                <h2><span>Ratings</span><i class="fa fa-star" aria-hidden="true"></i></h2>
                                <p>
                                    Lorem ipsum dolor sit amet elit. Aliquam odio dolor, id luctus erat sagittis non. Ut blandit semper pretium.
                                </p>
                            </div>
                        </div>
                        <div class="reviews-container left">
                            <div class="reviews-content">
                                <h2><span>Ratings</span><i class="fa fa-star" aria-hidden="true"></i></h2>
                                <p>
                                    Lorem ipsum dolor sit amet elit. Aliquam odio dolor, id luctus erat sagittis non. Ut blandit semper pretium.
                                </p>
                            </div>
                        </div>
                        <div class="reviews-container right">
                            <div class="reviews-content">
                                <h2><span>Ratings</span><i class="fa fa-star" aria-hidden="true"></i></h2>
                                <p>
                                    Lorem ipsum dolor sit amet elit. Aliquam odio dolor, id luctus erat sagittis non. Ut blandit semper pretium.
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Reviews End -->


            <!-- Comment Start -->
            <div class="movinfo">
                <div class="container">
                    <div class="row align-items-center">
                        <div class="col-lg-12 col-md-12">
                            <div class="section-header">
                                <h2>Comments</h2>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-lg-1 col-md-1">
                            <p>評分</p>
                        </div>
                        <div class="col-lg-11 col-md-11">
                            <form action="" style="display: inline-block;">
                                <span class="star" data-star = "1"><i class="fa fa-star" aria-hidden="true"></i></span>
                                <span class="star" data-star = "2"><i class="fa fa-star" aria-hidden="true"></i></span>
                                <span class="star" data-star = "3"><i class="fa fa-star" aria-hidden="true"></i></span>
                                <span class="star" data-star = "4"><i class="fa fa-star" aria-hidden="true"></i></span>
                                <span class="star" data-star = "5"><i class="fa fa-star" aria-hidden="true"></i></span>
                            </form>
                        </div>
                    </div>

                    <div class="row align-items-center">
                        <div class="col-lg-12 col-md-12">
                            <form action="">
                                <textarea name="" id="" cols="30" rows="5" style="width: 100%;"> Wite something here...</textarea>
                            </form>
                            <input type="button" value="送出">
                        </div>
                    </div>
                </div>
            </div>
            <!-- Comment End -->
            
            <!-- Book Tickets Start -->
            <%@ include file="../files/bookTicketsTamplate.file"%>
            <!-- Book Tickets End -->

            <!-- Footer Start -->
            <%@ include file="../files/footer_frontend.file"%>
            <!-- Footer End -->
        </div>
        
<%@ include file="../files/comJsLinks.file"%>     

<script>

</script>
</body>
</html>