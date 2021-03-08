<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.session.model.*"%>

<jsp:useBean id="listSessions_ByCompositeQuery" scope="request" type="java.util.List<SesVO>"/>
<jsp:useBean id="movSvc" scope="page" class="com.movie.model.MovService"/>
<html>
<head>
	<title>場次查詢</title>
	<%@ include file="../files/sb_head.file"%>
</head>
<body class="sb-nav-fixed">
		<%@ include file="../files/sb_navbar.file"%> <!-- 引入navbar (上方) -->
        <div id="layoutSidenav">
            <div id="layoutSidenav_nav">
                <c:set value="sessionSub" var="urlRecog"></c:set> <!-- 給sb_sidebar.file的參數-Sub -->
				<%@ include file="../files/sb_sidebar.file"%> <!-- 引入sidebar (左方) -->
            </div>
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid">
                    
                    	<!-- listAllSessions_ByCompositeQuery Start -->
                    	<h3 class="h3-style" style="display: inline-block;">場次查詢&ensp;</h3>
			            <table class="table table-hover">
							<thead>
								<tr class="th-sty" style="border-bottom: 3px solid #bb9d52;">
									<th>編號</th>
									<th>電影</th>
									<th>場次日期</th>
									<th>場次時間</th>
									<th>廳院</th>
									<th>修改</th>
								</tr>				
							</thead>
									
							<tbody>
								<%@ include file="pages/page1_ByCompositeQuery.file"%> 
								<c:forEach var="sesVO" varStatus="no" items="${listSessions_ByCompositeQuery}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
								<c:set value="${movSvc.getOneMov(sesVO.movNo)}" var="movObj"></c:set>
								<tr class="sty-height" valign='middle' ${(sesVO.sesNo==param.sesNo) ? 'style="background-color:#bb9d52; color:#fff;"':''}>
									<td>${no.index+1}</td>
									<td>${movObj.movname}</td>
									<td>${sesVO.getSesDate()}</td>
									<td>${sesVO.getSesTime()}</td>
									<td>${sesVO.getTheNo()}</td>
									<td>
									   <a class="btn btn-light btn-brd grd1 effect-1" onclick="updateData(this,${sesVO.sesNo})" >
										 <input type="button" value="修改" class="input-pos update-btn">
					        		   </a>
									</td>
								</tr>
								</c:forEach>
							</tbody>
						</table>
						<%@ include file="pages/page2_ByCompositeQuery.file" %>
                       <!-- listAllSessions_ByCompositeQuery End -->
                    
                    </div>
                </main>
                <%@ include file="../files/sb_footer.file"%>
            </div>
        </div>
		<%@ include file="../files/sb_importJs.file"%> <!-- 引入template要用的js -->
		
<script>				
	function updateData(e,sesNo){
		let href = "<%=request.getContextPath()%>/session/ses.do?action=getOne_For_Update&requestURL=<%=request.getServletPath()%>&sesNo="+sesNo;
		e.setAttribute("href", href);
	}
</script>
</body>
</html>