<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.session.model.*"%>

<%    
    SesService sesSvc = new SesService();
    List<SesVO> list = sesSvc.getAll();
    pageContext.setAttribute("list",list);
%>

<html>
<head>
	<title>Comment Reports Management</title>
	<%@ include file="../files/sb_head.file"%>
</head>
<style>
	.success-span{
	    color: #bb9d52;
		position: absolute;
	    top: 10%;
	    left: 17%;
	}
</style>
<body class="sb-nav-fixed">
		<%@ include file="../files/sb_navbar.file"%> <!-- 引入navbar (上方) -->
        <div id="layoutSidenav">
            <div id="layoutSidenav_nav">
				<c:set value="${pageContext.request.requestURI}" var="urlRecog"></c:set> <!-- 給sb_sidebar.file的參數-Home -->
				<%@ include file="../files/sb_sidebar.file"%> <!-- 引入sidebar (左方) -->
            </div>
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid">
                    
                    	<!-- listComreport Start -->
                    	<h3 class="h3-style" style="display: inline-block;">電影短評檢舉列表&ensp;</h3>
						<c:if test="${addSuccess != null}">
							<span class="success-span">  
								${addSuccess}
								<i class="fa fa-hand-peace-o"></i>
							</span>
						</c:if>
						<c:if test="${updateSuccess != null }">
							<span class="success-span">  
								${updateSuccess}
								<i class="far fa-laugh-wink"></i>
							</span>
						</c:if>
						
                    	<div class="row " style="margin: -50px 0 50px 0;">         
			                <div class="col-3"></div>
	                        <div class="col-9">          
		            			<jsp:useBean id="movSvcAll" scope="page" class="com.movie.model.MovService"/>                        
	                           	<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/session/ses.do">				                        
			                        <b>電影名稱</b>
			                            <select name="movNo" style="width: 80px;">
			                                <option value=""></option>
			                                <c:forEach var="movVO" items="${movSvcAll.all}" >
			                                    <option value="${movVO.movno}">${movVO.movname}
			                                </c:forEach>
			                            </select>&ensp;&ensp;
			                        <b>場次日期</b>
			                        <input class="sty-input" name="sesDateBegin" id="" type="date" value=""> 
			                        ~ <input class="sty-input" name="sesDateEnd" id="" type="date" value="">
			                        
			                        <input type="hidden" name="action" value="listSessions_ByCompositeQuery">
				        			<a class="btn btn-light btn-brd grd1 effect-1">
										<input type="submit" value="搜尋" class="input-pos">
				        			</a>
		                    	</FORM>                    
                        	</div>                 
                        </div>
			            <table class="table table-hover">
							<thead>
								<tr style="border-bottom: 3px solid #bb9d52;">
									<th>編號</th>
									<th>電影</th>
									<th>場次日期</th>
									<th>場次時間</th>
									<th>廳院</th>
									<th>修改</th>
								</tr>				
							</thead>
									
							<tbody>
								<jsp:useBean id="movSvc" scope="page" class="com.movie.model.MovService"/>	
								<%@ include file="../movie/pages/page1.file" %> 
									<c:forEach var="sesVO" items="${list}" varStatus="no" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
									<c:set value="${movSvc.getOneMov(sesVO.movNo)}" var="movObj"></c:set>
									<tr class="sty-height" valign='middle' ${(sesVO.sesNo==param.sesNo) ? 'style="background-color:#bb9d52; color:#fff;"':''}>
										<td>${no.index+1}</td>
										<td>${movObj.movname}</td>
										<td>${sesVO.getSesDate()}</td>
										<td>${sesVO.getSesTime()}</td>
										<td>${sesVO.getTheNo()}</td>
										<td>
											<a class="btn btn-light btn-brd grd1 effect-1" onclick="updateData(this,${sesVO.sesNo})" >
												<input type="submit" value="修改" class="input-pos">
						        			 </a>
										</td>
									</tr>
									</c:forEach>
							</tbody>
						</table>
			    		<%@ include file="../movie/pages/page2.file" %>
                       <!-- listComreport End -->
                    
                    </div>
                </main>
                <%@ include file="../files/sb_footer.file"%>
            </div>
        </div>
		<%@ include file="../files/sb_importJs.file"%> <!-- 引入template要用的js -->
		
<script>
	function updateData(e,sesNo){
		let href = "<%=request.getContextPath()%>/session/ses.do?action=getOne_For_Update&requestURL=<%=request.getServletPath()%>&whichPage=<%=whichPage%>&sesNo="+sesNo;
		e.setAttribute("href", href);
	}
</script>
</body>
</html>