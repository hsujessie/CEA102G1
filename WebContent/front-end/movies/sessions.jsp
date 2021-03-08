<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sessions</title>
<%@ include file="../files/frontend_importCss.file"%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/resource/css/movie/frontendMovies.css">
</head>
<body>
        <div class="wrapper">
            <!-- Nav Bar Start -->
			<c:set value="${pageContext.request.requestURI}" var="urlRecog"></c:set>
            <%@ include file="../files/frontend_navbar.file"%>
            <!-- Nav Bar End -->


            <!-- Page Header Start -->
            <div class="page-header">
                <div class="container">
                    <div class="row">
                        <div class="col-12">
                            <h2>Sessions</h2>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Page Header End -->


            <jsp:useBean id="movSvc" scope="page" class="com.movie.model.MovService"/>
            <jsp:useBean id="sesSvc" scope="page" class="com.session.model.SesService"/>
            <!-- Sessions Start -->
            <div class="session">
                <div class="container">
                    <div class="row " style="margin: -50px 0 50px 0;">         
		                <div class="col-5"></div>
                        <div class="col-7">                          
                           	<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/session/ses.do">	
		                        <b>場次日期</b>
		                        <input class="sty-input" name="sesDateBegin" id="" type="date" value="" style="margin-left: 10px;"> 
		                        ~<input class="sty-input" name="sesDateEnd" id="" type="date" value="">
		                        
		                        <input type="hidden" name="action" value="searchSesDate">
								<input type="submit" value="搜尋" class="combtn">
	                    	</FORM>                    
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-12">
                        
                            <c:forEach var="movVO" items="${movSvc.all}" >
	                            <c:if test="${not empty movVO.movpos}">
		                            <div class="row align-items-center session-item">
		                                <div class="col-5">
		                                    <div class="session-icon">
		                                        <img onclick="sendData(this,${movVO.movno})"  style="width: 125px; cursor: pointer;" src="<%=request.getContextPath()%>/movie/mov.do?movno=${movVO.movno}&img=movpos&action=get_One_MovPos" alt="Movies Image">
		                                    </div>
		                                </div>
		                                <div class="col-7">
		                                    <h3>${movVO.movname}</h3>
		                                    
		                                    <c:if test="${empty getMovies_BySesDate}">
			                                    <p><c:forEach var="sesVO" items="${sesSvc.all}" >
				                                    	<c:if test="${sesVO.movNo == movVO.movno}">
				                                    		${sesVO.sesDate}&emsp;
				                                    	</c:if>
			                                    	</c:forEach>
			                                    </p>
		                                    </c:if>
		                                    
		                                    
		                                    <c:if test="${not empty getMovies_BySesDate}">		                                    
			                                     <p>
			                                    	<c:forEach var="sesVO" items="${getMovies_BySesDate}" >
				                                    	<c:if test="${sesVO.movNo == movVO.movno}">
				                                    		${sesVO.sesDate}&emsp;
				                                    	</c:if>
			                                    	</c:forEach>
			                                    </p>
		                                    </c:if>
		                                    
		                                </div>
		                            </div>
	                            </c:if>
	                         </c:forEach>
	                         
                        </div>
                    </div>
                </div>
            </div>
            <!-- Sessions End -->
            
            <!-- Book Tickets Start -->
            <%@ include file="../files/frontend_bookTicketsTamplate.file"%>
            <!-- Book Tickets End -->

            <!-- Footer Start -->
            <%@ include file="../files/frontend_footer.file"%>
            <!-- Footer End -->
        </div>
        
<%@ include file="../files/frontend_importJs.file"%>   


<script>
	function sendData(e,movno){
	    let url = "<%=request.getContextPath()%>/movie/mov.do?action=getOne_For_Display&fromFrontend=true&movno="+movno;
	    window.location.href = url;
	}
</script>
</body>
</html>