<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
	<title>Management</title>
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
                    
                    <!-- table Start -->
                    <h3 class="h3-style" style="display: inline-block;">電影列表&ensp;</h3>
				
		            <table class="table table-hover">
						<thead>
							<tr style="border-bottom: 3px solid #bb9d52;">
								<th>標題1</th>
								<th>標題2</th>
								<th>標題3</th>
								<th>標題4</th>
								<th>標題5</th>
							</tr>				
						</thead>
							<tr>
								<td>內容1</td>
								<td>內容2</td>
								<td>內容3</td>
								<td>內容4</td>
								<td>內容5</td>
							</tr>
						<tbody>						
						</tbody>
					</table>
                    <!-- table End -->
                    
                    </div>
                </main>
                <%@ include file="../files/sb_footer.file"%>
            </div>
        </div>
		<%@ include file="../files/sb_importJs.file"%> <!-- 引入template要用的js -->
    </body>
</html>