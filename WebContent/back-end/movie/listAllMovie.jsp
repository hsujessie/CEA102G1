<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.movie.model.*"%>

<%
    MovService movSvc = new MovService();
    List<MovVO> list = movSvc.getAll();
    pageContext.setAttribute("list",list);
%>

<html>
<head>
	<title>Movies Management</title>
	<%@ include file="../files/sb_head.file"%>
	<!-- Your custom styles (optional) -->
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
                    
                    	<!-- listAllMovie Start -->
                    	<h3 class="h3-style" style="display: inline-block;">電影列表&ensp;</h3>
						<c:if test="${addSuccess != null}">
							<span style="color: #bb9d52">  
								${addSuccess}
								<i class="fa fa-hand-peace-o"></i>
							</span>
						</c:if>
						<c:if test="${updateSuccess != null }">
							<span style="color: #bb9d52">  
								${updateSuccess}
								<i class="far fa-laugh-wink"></i>
							</span>
						</c:if>
						
                    	<div class="row " style="margin: -50px 0 50px 0;">         
			                <div class="col-3"></div>
	                        <div class="col-9">          
		            			<jsp:useBean id="movSvcAll" scope="page" class="com.movie.model.MovService"/>                        
	                           	<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/movie/mov.do">				                        
			                        <b>電影名稱</b>
			                            <select name="mov_no" style="width: 80px;">
			                                <option value=""></option>
			                                <c:forEach var="movVO" items="${movSvcAll.all}" >
			                                    <option value="${movVO.movno}">${movVO.movname}
			                                </c:forEach>
			                            </select>
			                        <b>電影類型</b>
			                            <select name="mov_type">
			                                <option value=""></option>
											<option value="劇情片">劇情片</option>
											<option value="動作片">動作片</option>
											<option value="動畫片">動畫片</option>
											<option value="喜劇片">喜劇片</option>
											<option value="愛情片">愛情片</option>
											<option value="科幻片">科幻片</option>
											<option value="恐怖片">恐怖片</option>
			                            </select>
			                        <b>選擇年份</b>
			                        <select name="mov_ondate_year">
			                            <option value=""></option>
			                            <c:forEach var="year" begin="1970" end="<%= (int) (java.util.Calendar.getInstance().get(java.util.Calendar.YEAR))+1%>">
			                                <option value="${year}">${year}年</option>
			                            </c:forEach>
			                        </select>
			                        <b>選擇月份</b>
			                        <select name="mov_ondate_month">
			                            <option value=""></option>
			                            <c:forEach var="month" begin="1" end="12">
			                                <option value="${month}">${month}月</option>
			                            </c:forEach>
			                        </select>
			                        <input type="hidden" name="action" value="listMovies_ByCompositeQuery">
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
								<%@ include file="pages/page1.file" %> 
								<c:forEach var="movVO" items="${list}" varStatus="no" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">					
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
										<a class="btn btn-light btn-brd grd1 effect-1" onclick="updateData(this,${movVO.movno})" >
											<input type="submit" value="修改" class="input-pos">
					        			 </a>
									</td>
								</tr>
								</c:forEach>
							</tbody>
						</table>
					   <%@ include file="pages/page2.file" %>
                       <!-- listAllMovie End -->
                    
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
		function updateData(e,movno){
			let href = "<%=request.getContextPath()%>/movie/mov.do?action=getOne_For_Update&requestURL=<%=request.getServletPath()%>&whichPage=<%=whichPage%>&movno="+movno;
			e.setAttribute("href", href);
		}
	</script>
</body>
</html>