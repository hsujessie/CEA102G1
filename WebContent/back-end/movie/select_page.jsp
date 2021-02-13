<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>Movie Home</title>

<style>
  table#table-1 {
	width: 450px;
	background-color: #CCCCFF;
	margin-top: 5px;
	margin-bottom: 10px;
    border: 3px ridge Gray;
    height: 80px;
    text-align: center;
  }
  #table-1 h3{
  	padding-top:20px;
  }
</style>

</head>
<body bgcolor='white'>

<table id="table-1">
   <tr><td><h3>Movie Home</h3></td></tr>
</table>

<h3>查詢電影:</h3>
	
<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
	    <c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

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
					<c:forEach var="movVO" items="${movSvc.all}" > 
						<option value="${movVO.movno}">${movVO.movname}
					</c:forEach>
				</select>
			<br><b>電影類型:</b>
				<select name="mov_type">
					<option value= ""></option>
					<option value= "動畫片">動畫片</option>
					<option value= "喜劇片">喜劇片</option>
					<option value= "愛情片">愛情片</option>
					<option value= "科幻片">科幻片</option>
					<option value= "恐怖片">恐怖片</option>
				</select>
			<br><b>上映日期:</b>
			<input name="mov_ondate" id="movie_date" type="text" >
			
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
   format: 'Y-m-d',
   value: new Date()
});
</script>
</html>