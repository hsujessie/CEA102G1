<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Movies</title>
<%@ include file="../files/comCssLinks.file"%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/resource/css/movie/frontendMovies.css">
</head>
<body>
        <div class="wrapper">
            <!-- Nav Bar Start -->
			<c:set value="${pageContext.request.requestURI}" var="urlRecog"></c:set>
            <%@ include file="../files/navbar_frontend.file"%>
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
		                            <div class="movies-wrap" onclick="sendData(this,${movVO.movno})" style="cursor:pointer;">
		                                <img src="<%=request.getContextPath()%>/movie/mov.do?movno=${movVO.movno}&img=movpos&action=get_One_MovPos" alt="Movies Image">
		                                <figure>
		                                    <p><img style="width:100%; max-width: 40px;" src="<%=request.getContextPath()%>/resource/images/logos/seenema_W.ico" alt="Logo"></p>
		                                    <a href="<%=request.getContextPath()%>/movie/mov.do?action=getOne_For_Display&fromFrontend=true&movno=${movVO.movno}">${movVO.movname}</a>
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
            
            <!-- Book Tickets Start -->
            <%@ include file="../files/bookTicketsTamplate.file"%>
            <!-- Book Tickets End -->

            <!-- Footer Start -->
            <%@ include file="../files/footer_frontend.file"%>
            <!-- Footer End -->
        </div>
        
<%@ include file="../files/comJsLinks.file"%>     

<script>
	function sendData(e,movno){
	    let url = "<%=request.getContextPath()%>/movie/mov.do?action=getOne_For_Display&fromFrontend=true&movno="+movno;
	    window.location.href = url;
	}
</script>
</body>
</html>