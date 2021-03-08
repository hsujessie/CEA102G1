<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.comment_report.model.*"%>

<%    
	ComRepService comRepSvc = new ComRepService();
    List<ComRepVO> list = comRepSvc.getAll();
    pageContext.setAttribute("list",list);
%>

<html>
<head>
	<title>Comment Reports Management</title>
	<%@ include file="/back-end/files/sb_head.file"%>
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
		<%@ include file="/back-end/files/sb_navbar.file"%> <!-- 引入navbar (上方) -->
        <div id="layoutSidenav">
            <div id="layoutSidenav_nav">
				<c:set value="${pageContext.request.requestURI}" var="urlRecog"></c:set> <!-- 給sb_sidebar.file的參數-Home -->
				<%@ include file="/back-end/files/sb_sidebar.file"%> <!-- 引入sidebar (左方) -->
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
	                           	<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/comment_report/comrep.do">	
			                        <b>月份</b>
			                        <input class="sty-input" name="" id="" type="date" value=""> 
			                        
			                        <input type="hidden" name="action" value="">
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
									<th>檢舉人帳號</th>
									<th>檢舉原因</th>
									<th>檢舉時間</th>
									<th>檢舉狀態</th>
									<th>審核</th>
								</tr>				
							</thead>
									
							<tbody>
								<jsp:useBean id="comSvc" scope="page" class="com.comment.model.ComService"/>	
								<%@ include file="/back-end/movie/pages/page1.file" %> 
									<c:forEach var="comRepVO" items="${list}" varStatus="no" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
									<c:set value="${comSvc.getOneCom(comRepVO.comNo)}" var="comObj"></c:set>
									<tr class="sty-height" valign='middle' ${(comRepVO.comNo==param.comNo) ? 'style="background-color:#bb9d52; color:#fff;"':''}>
										<td>${no.index+1}</td>
										<td>${comRepVO.getMemNo()}</td>
										<td>${comRepVO.getComRepReason()}</td>
										<td>${comRepVO.getComRepTime()}</td>
										<td>${comRepVO.getComRepStatus()}</td>
										<td>
											<a class="btn btn-light btn-brd grd1 effect-1" onclick="updateData(this,${comVO.comNo})" >
												<input type="submit" value="審核" class="input-pos">
						        			 </a>
										</td>
									</tr>
									</c:forEach>
							</tbody>
						</table>
			    		<%@ include file="/back-end/movie/pages/page2.file" %>
                       <!-- listComreport End -->
                    
                    </div>
                </main>
                <%@ include file="/back-end/files/sb_footer.file"%>
            </div>
        </div>
		<%@ include file="/back-end/files/sb_importJs.file"%> <!-- 引入template要用的js -->
		
<script>
	function updateData(e,comNo){
		let href = "<%=request.getContextPath()%>/comment_report/comrep.do?action=getOne_For_Update&requestURL=<%=request.getServletPath()%>&whichPage=<%=whichPage%>&comNo="+comNo;
		e.setAttribute("href", href);
	}
</script>
</body>
</html>