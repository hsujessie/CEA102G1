<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Movies</title>
<%@ include file="../files/comCssLinks.file"%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/sources/css/frontendMovies.css">
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
                            <div class="movinfo-vdo">
                            	<video controls width="150"><source src="<%=request.getContextPath()%>/movie/mov.do?movno=${movVO.movno}&action=get_One_MovTra" type="video/mp4"></video>
                            </div>
                        </div>
                        <div class="col-lg-7 col-md-6">
                            <div class="section-header">
                                <h2>Information</h2>
                            </div>
                            <div class="movinfo-text">
                                <p>名&emsp;&emsp;稱 &emsp;|&emsp; ${movVO.movname}</p>
                                <p>上映日期 &emsp;|&emsp; ${movVO.movondate}</p>
                                <p>類&emsp;&emsp;型 &emsp;|&emsp; ${movVO.movtype}</p>
                                <p>級&emsp;&emsp;數 &emsp;|&emsp; ${movVO.movrating}</p>
                                <p>片&emsp;&emsp;長 &emsp;|&emsp; ${movVO.movdurat}小時</p>
                                <p>導&emsp;&emsp;演 &emsp;|&emsp; ${movVO.movditor}</p>
                                <p>演&emsp;&emsp;員 &emsp;|&emsp; ${movVO.movcast}</p>
                                <p>期待度&emsp; &emsp;|&emsp; </p>
                                <p>滿意度&emsp; &emsp;|&emsp; </p>
                            </div>
                        </div>
                    </div>
                    
					<!-- 電影--未上映：顯示，已上映：不顯示 -->
                    <div class="row">
                        <div class="col-lg-1 col-md-1">
                            <p style="color:#aa9166;">期待度</p>
                        </div>
                        <div class="col-lg-11 col-md-11">
                            <input type="radio">&ensp;想看<i class="far fa-smile" style="color:#aa9166;"></i>&emsp;&emsp;
                            <input type="radio">&ensp;不想看<i class="far fa-meh" style="color:#aa9166;"></i>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Information End -->

<!-- ================================= 以下 電影--未上映：不顯示，已上映：顯示 ====================================== -->
            <!-- Synopsis Start -->
            <div class="movinfo">
                <div class="container">
                    <div class="row align-items-center">
                        <div class="col-lg-12 col-md-12">
                            <div class="section-header">
                                <h2>Synopsis</h2>
                            </div>
                            <div class="movinfo-text">
                                <p>${movVO.movdes}</p>
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
                                <span>發表人</span>
                                <span>發表時間</span>
                            </div>
                        </div>
                        <div class="reviews-container right">
                            <div class="reviews-content">
                                <h2><span>Ratings</span><i class="fa fa-star" aria-hidden="true"></i></h2>
                                <p>
                                    Lorem ipsum dolor sit amet elit. Aliquam odio dolor, id luctus erat sagittis non. Ut blandit semper pretium.
                                </p>
                                <span>發表人</span>
                                <span>發表時間</span>
                            </div>
                        </div>
                        <div class="reviews-container left">
                            <div class="reviews-content">
                                <h2><span>Ratings</span><i class="fa fa-star" aria-hidden="true"></i></h2>
                                <p>
                                    Lorem ipsum dolor sit amet elit. Aliquam odio dolor, id luctus erat sagittis non. Ut blandit semper pretium.
                                </p>
                                <span>發表人</span>
                                <span>發表時間</span>
                            </div>
                        </div>
                        <div class="reviews-container right">
                            <div class="reviews-content">
                                <h2><span>Ratings</span><i class="fa fa-star" aria-hidden="true"></i></h2>
                                <p>
                                    Lorem ipsum dolor sit amet elit. Aliquam odio dolor, id luctus erat sagittis non. Ut blandit semper pretium.
                                </p>
                                <span>發表人</span>
                                <span>發表時間</span>
                            </div>
                        </div>
                        <div class="reviews-container left">
                            <div class="reviews-content">
                                <h2><span>Ratings</span><i class="fa fa-star" aria-hidden="true"></i></h2>
                                <p>
                                    Lorem ipsum dolor sit amet elit. Aliquam odio dolor, id luctus erat sagittis non. Ut blandit semper pretium.
                                </p>
                                <span>發表人</span>
                                <span>發表時間</span>
                            </div>
                        </div>
                        <div class="reviews-container right">
                            <div class="reviews-content">
                                <h2><span>Ratings</span><i class="fa fa-star" aria-hidden="true"></i></h2>
                                <p>
                                    Lorem ipsum dolor sit amet elit. Aliquam odio dolor, id luctus erat sagittis non. Ut blandit semper pretium.
                                </p>
                                <span>發表人</span>
                                <span>發表時間</span>
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
                            <p>滿意度</p>
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
                                <textarea name="" cols="30" rows="5" style="width: 100%;" placeholder="Write something here..."></textarea>                          
                                
								<input type="hidden" name="action" value="insert">
                            	<input class="combtn" type="submit" value="送出">
                            </form>
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