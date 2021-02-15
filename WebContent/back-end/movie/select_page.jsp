<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
    <link rel="shortcut icon" href="../../sources/images/logos/seenema_W.ico" type="image/x-icon" />
    <link rel="stylesheet" href="../../sources/css/style.css">
    <link rel="stylesheet" href="../../sources/css/bootstrap.min.css">
    
<title>Movie Info Management</title>
  
</head>
<body class="barber_version">
    <!-- Start Container-->
    <div id="container">
        <!-- Start Section1-->
        <div id="section1">
            <!-- ＊＊＊引入Side Bar＊＊＊-->
			<%@ include file="../sidebar/sidebar_backend.file"%>
        </div><!-- end Section1 -->

        <!-- Start Section2-->
        <div id="section2">
            <h3>查詢電影:</h3>
            <ul>
            <li><a href="<%=request.getContextPath()%>/back-end/movie/listAllMovie.jsp">List</a> all Movies.  <br><br></li>

            <jsp:useBean id="movSvc" scope="page" class="com.movie.model.MovService" />

            <li>
                <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/movie/mov.do" >
                    <b>選擇電影:</b>
                    <select name="movno">
                    <c:forEach var="movVO" items="${movSvc.all}" >
                    <option value="${movVO.movno}">${movVO.movname}
                    </c:forEach>
                    </select>
                    <input type="hidden" name="action" value="getOne_For_Display">
                    <input type="submit" value="送出">
                </FORM>
            </li>
            </ul>

            <hr>
            <ul>
                <li>
                    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/movie/mov.do" >
                        <b style="color:teal;font-size:20px;">複合查詢</b>
                        <br><b>選擇電影:</b>
                            <select name="mov_no">
                                <option value=""></option>
                                <c:forEach var="movVO" items="${movSvc.all}" >
                                    <option value="${movVO.movno}">${movVO.movname}
                                </c:forEach>
                            </select>
                        <br><b>電影類型:</b>
                            <select name="mov_type">
                                <option value=""></option>
                                <option value="劇情片">劇情片</option>
                                <option value="動畫片">動畫片</option>
                                <option value="喜劇片">喜劇片</option>
                                <option value="愛情片">愛情片</option>
                                <option value="科幻片">科幻片</option>
                                <option value="恐怖片">恐怖片</option>
                            </select>
                        <br><b>日期:</b>
                        <select name="mov_ondate_year">
                            <option value=""></option>
                            <c:forEach var="year" begin="1970" end="<%= (int) (java.util.Calendar.getInstance().get(java.util.Calendar.YEAR))+1%>">
                                <option value="${year}">${year}年</option>
                            </c:forEach>
                        </select>
                        <select name="mov_ondate_month">
                            <option value=""></option>
                            <c:forEach var="month" begin="1" end="12">
                                <option value="${month}">${month}月</option>
                            </c:forEach>
                        </select>
                        <input type="hidden" name="action" value="listMovies_ByCompositeQuery">
                        <input type="submit" value="送出">
                    </FORM>
                </li>
            </ul>

            <hr>
            <h3>電影管理</h3>
            <ul>
            <li><a href='<%=request.getContextPath()%>/back-end/movie/addMovie.jsp'>Add</a> a new Movie.</li>
            </ul>
        </div><!-- end Section2 -->
    </div><!-- end Container-->
</body>
<link   rel="stylesheet" type="text/css" href="/CEA102G1/sources/datetimepicker/jquery.datetimepicker.css"/>
<script src="/CEA102G1/sources/datetimepicker/jquery.js"></script>
<script src="/CEA102G1/sources/datetimepicker/jquery.datetimepicker.full.js"></script>
<style>
  .xdsoft_datetimepicker .xdsoft_datepicker {
           width:  300px;
  }
  .xdsoft_datetimepicker .xdsoft_timepicker .xdsoft_time_box {
           height: 151px;
  }
</style>
<script>
$.datetimepicker.setLocale('zh');
$('#movie_date').datetimepicker({
   theme: 'dark',
   timepicker: false, 
   format: 'Y-m',
   value: new Date()
});
</script>
</html>