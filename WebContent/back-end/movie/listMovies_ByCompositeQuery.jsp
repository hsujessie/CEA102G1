<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.movie.model.*"%>

<jsp:useBean id="listMovies_ByCompositeQuery" scope="request" type="java.util.List<MovVO>"/>
<html>
<head>
	<title>電影查詢</title>
	<%@ include file="../files/sb_head.file"%>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/resource/css/backendStyles.css">
</head>
<body class="sb-nav-fixed">
		<%@ include file="../files/sb_navbar.file"%> <!-- 引入snavbar (上方) -->
        <div id="layoutSidenav">
            <div id="layoutSidenav_nav">
				<%@ include file="../files/sb_sidebar.file"%> <!-- 引入sidebar (左方) -->
            </div>
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid">
                    
                    	<!-- listAllMovie_ByCompositeQuery Start -->
                    	<h3 class="h3-style" style="display: inline-block;">電影查詢&ensp;</h3>
			            <table class="table table-hover">
							<thead>
								<tr class="th-sty" style="border-bottom: 3px solid #bb9d52;">
									<th>編號</th>
									<th>名稱</th>
									<th>種類</th>
									<th>類型</th>
									<th>語言</th>
									<th>上映日期</th>
									<th>下檔日期</th>
									<th>片長</th>
									<th>級數</th>
									<th>查看</th>
									<th>修改</th>
								</tr>				
							</thead>
									
							<tbody>
								<%@ include file="pages/page1_ByCompositeQuery.file"%> 
								<c:forEach var="movVO" varStatus="no" items="${listMovies_ByCompositeQuery}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
								<tr class="sty-height" valign='middle' ${(movVO.movno==param.movno) ? 'style="background-color:#bb9d52; color:#fff;"':''}>
									<td>${no.index+1}</td>
									<td>${movVO.getMovname()}</td>
									<td>${movVO.getMovver()}</td>
									<td>${movVO.getMovtype()}</td>
									<td>${movVO.getMovlan()}</td>
									<td>${movVO.getMovondate()}</td>
									<td>${movVO.getMovoffdate()}</td>
									<td>${movVO.getMovdurat()}小時</td>
									<td>${movVO.getMovrating()}</td>
									<td>
					        			 <a id="listOne" onclick="getData(this,${movVO.movno})" class="btn btn-light btn-brd grd1 effect-1">
											<input type="button" value="查看" class="input-pos">
					        			 </a>	
									</td>
									<td>
									   <a class="btn btn-light btn-brd grd1 effect-1">
											<input type="button" value="修改" class="input-pos update-btn" data-movno="${movVO.movno}">
					        			 </a>
									</td>
								</tr>
								</c:forEach>
							</tbody>
						</table>
						<%@ include file="pages/page2_ByCompositeQuery.file" %>
                       <!-- listAllMovie_ByCompositeQuery End -->
                    
                    </div>
                </main>
                <%@ include file="../files/sb_footer.file"%>
            </div>
        </div>
		<%@ include file="../files/sb_importJs.file"%> <!-- 引入template要用的js -->
		
<script>				
	function getData(e,movno){
		let href = "<%=request.getContextPath()%>/movie/mov.do?action=getOne_For_Display&requestURL=<%=request.getServletPath()%>&movno="+movno;
		e.setAttribute("href", href);
	}
</script>
</body>
</html>