<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
	<title>Movies Management</title>
	<%@ include file="../files/sb_head.file"%>
</head>
<body class="sb-nav-fixed">
		<%@ include file="../files/sb_navbar.file"%> <!-- 引入navbar (上方) -->
        <div id="layoutSidenav">
            <div id="layoutSidenav_nav">
				<%@ include file="../files/sb_sidebar.file"%> <!-- 引入sidebar (左方) -->
            </div>
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid">
                    
                    <!-- PUT HERE Start-->
                    <!-- PUT HERE End-->
                    
                    </div>
                </main>
                <%@ include file="../files/sb_footer.file"%>
            </div>
        </div>
		<%@ include file="../files/sb_importJs.file"%> <!-- 引入template要用的js -->
    </body>
</html>