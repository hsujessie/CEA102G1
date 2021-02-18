<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="com.movie.model.*"%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>電影修改 - Update Movie input.jsp</title>
<style>
  #table-1 {
	width: 450px;
	background-color: #CCCCFF;
	margin-top: 5px;
	margin-bottom: 10px;
    border: 3px ridge Gray;
    height: 80px;
    text-align: center;
  }
  #table-1 h4 {
    color: red;
    display: block;
    margin-bottom: 1px;
  }
  h4 {
    color: blue;
    display: inline;
  }
</style>

<style>
  table {
	background-color: white;
	margin-top: 1px;
	margin-bottom: 1px;
  }
  table, th, td {
    border: 0px solid #CCCCFF;
  }
  th, td {
    padding: 1px;
  }
  img{
  	width:50px;
  }
  .errColor{
   	color:red;
  }
</style>

</head>
<body bgcolor='white'>

<table id="table-1">
	<tr><td>
		 <h3>電影資訊修改 - Update Movie input.jsp</h3></td><td>
		 <h4><a href="<%=request.getContextPath()%>/back-end/movie/select_page.jsp">回首頁</a></h4>
	</td></tr>
</table>

<h3>電影資訊修改:</h3>

<FORM method="post" action="<%=request.getContextPath()%>/movie/mov.do" name="form_updateMovie" enctype="multipart/form-data">
<table>
	<tr>
		<td>電影名稱:</td>
		<td><input type="text" name="movname" value="${movVO.movname}" /></td>
		<td class="errColor">${errorMsgs.movname}</td>
	</tr>

	<jsp:useBean id="movSvc" scope="page" class="com.movie.model.MovService" />
	<tr>
		<td>電影種類:</td>
		<td>
			<!-- 多選checkbox -->
				<input type="checkbox" name="movver" value="2D"      <c:forEach var="i" begin="0" end="2"> <c:if test="${movverToken[i].contains('2D')}">      checked </c:if></c:forEach> >2D<br/>
				<input type="checkbox" name="movver" value="3D"      <c:forEach var="i" begin="0" end="2"> <c:if test="${movverToken[i].contains('3D')}">      checked </c:if></c:forEach> >3D<br/>
				<input type="checkbox" name="movver" value="IMAX"    <c:forEach var="i" begin="0" end="2"> <c:if test="${movverToken[i].contains('IMAX')}">    checked </c:if></c:forEach> >IMAX<br/>
		</td>
		<td class="errColor">${errorMsgs.movver}</td>
	</tr>
	<tr>
		<td>電影類型:</td>
		<td>
			<select name="movtype">
				<option value= "劇情片" <c:forEach var="movVO" items="${movSvc.all}">  <c:if test="${movVO.movtype.contains('劇情片')}"> selected </c:if></c:forEach> >劇情片</option>
				<option value= "動畫片" <c:forEach var="movVO" items="${movSvc.all}">  <c:if test="${movVO.movtype.contains('動畫片')}"> selected </c:if></c:forEach> >動畫片</option>
				<option value= "喜劇片" <c:forEach var="movVO" items="${movSvc.all}">  <c:if test="${movVO.movtype.contains('喜劇片')}"> selected </c:if></c:forEach> >喜劇片</option>
				<option value= "愛情片" <c:forEach var="movVO" items="${movSvc.all}">  <c:if test="${movVO.movtype.contains('愛情片')}"> selected </c:if></c:forEach> >愛情片</option>
				<option value= "科幻片" <c:forEach var="movVO" items="${movSvc.all}">  <c:if test="${movVO.movtype.contains('科幻片')}"> selected </c:if></c:forEach> >科幻片</option>
				<option value= "恐怖片" <c:forEach var="movVO" items="${movSvc.all}">  <c:if test="${movVO.movtype.contains('恐怖片')}"> selected </c:if></c:forEach> >恐怖片</option>
			</select>
		</td>
		<td class="errColor">${errorMsgs.movtype}</td>
	</tr>
	<tr>
		<td>電影語言:</td>
		<td>
			<!-- 多選checkbox -->
			<input type="checkbox" name="movlan" value="英文" <c:forEach var="i" begin="0" end="1"> <c:if test="${movlanToken[i].contains('英文')}"> checked </c:if></c:forEach> >英文<br/>
			<input type="checkbox" name="movlan" value="中文" <c:forEach var="i" begin="0" end="1"> <c:if test="${movlanToken[i].contains('中文')}"> checked </c:if></c:forEach> >中文<br/>
			<input type="checkbox" name="movlan" value="日文" <c:forEach var="i" begin="0" end="1"> <c:if test="${movlanToken[i].contains('日文')}"> checked </c:if></c:forEach> >日文<br/>
		</td>
		<td class="errColor">${errorMsgs.movlan}</td>
	</tr>
	<tr>
		<td>上映日期:</td>
		<td><input name="movondate" id="mov_ondate" type="text"></td>
		<td class="errColor">${errorMsgs.movondate}</td>
	</tr>
	<tr>
		<td>下檔日期:</td>
		<td><input name="movoffdate" id="mov_offdate" type="text"></td>
		<td class="errColor">${errorMsgs.movoffdate}</td>
	</tr>
	<tr>
		<td>片長:</td>
		<td><input type="text" name="movdurat" value="${ empty movVO.movdurat ? '2' : movVO.movdurat}" />小時</td>
		<td class="errColor">${errorMsgs.movdurat}</td>
	</tr>
	<tr>
		<td>電影級數:</td>
		<td>
			<select name="movrating">
				<option value="普遍級" <c:forEach var="movVO" items="${movSvc.all}"><c:if test="${movVO.movrating.contains('普遍級')}"> selected </c:if></c:forEach> >普遍級</option>
				<option value="保護級" <c:forEach var="movVO" items="${movSvc.all}"><c:if test="${movVO.movrating.contains('保護級')}"> selected </c:if></c:forEach> >保護級</option>
				<option value="輔導級" <c:forEach var="movVO" items="${movSvc.all}"><c:if test="${movVO.movrating.contains('輔導級')}"> selected </c:if></c:forEach> >輔導級</option>
				<option value="限制級" <c:forEach var="movVO" items="${movSvc.all}"><c:if test="${movVO.movrating.contains('限制級')}"> selected </c:if></c:forEach> >限制級</option>
			</select>
		</td>
	</tr>
	<tr>
		<td>導演:</td>
		<td><input type="text" name="movditor" value="${movVO.movditor}" /></td>
		<td class="errColor">${errorMsgs.movditor}</td>
	</tr>
	<tr>
		<td>演員:</td>
		<td><input type="text" name="movcast" value="${movVO.movcast}" /></td>
		<td class="errColor">${errorMsgs.movcast}</td>
	</tr>
	<tr>
		<td>電影簡介:</td>
		<td>
			<textarea name="movdes" maxlength="500">${movVO.movdes}</textarea>
		</td>
		<td class="errColor">${errorMsgs.movdes}</td>
	</tr>
	<tr>
		<td>電影海報:</td>
		<td><input type="file" name="movpos" value="${movVO.movpos}" />
			<c:if test="${not empty movVO.movpos}">
				<img src="<%=request.getContextPath()%>/movie/mov.do?movno=${movVO.movno}&img=movpos&action=get_One_MovPic">
			</c:if>
		</td>
	</tr>
	<tr>
		<td>電影預告片:</td>	
		<td><input type="file" name="movtra" value="${movVO.movtra}" />
			<c:if test="${not empty movVO.movtra}">
				<img src="<%=request.getContextPath()%>/movie/mov.do?movno=${movVO.movno}&img=movtra&action=get_One_MovPic">
			</c:if>
		</td>
	</tr>
</table>
<br>
<input type="hidden" name="action" value="update">
<input type="hidden" name="movno" value="${movVO.movno}">
<input type="hidden" name="requestURL" value="<%=request.getParameter("requestURL")%>">
<input type="hidden" name="whichPage"  value="<%=request.getParameter("whichPage")%>">
<input type="submit" value="送出修改">
</FORM>
</body>
</body>

<link   rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/sources/datetimepicker/jquery.datetimepicker.css"/>
<script src="<%=request.getContextPath()%>/sources/datetimepicker/jquery.js"></script>
<script src="<%=request.getContextPath()%>/sources/datetimepicker/jquery.datetimepicker.full.js"></script>
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
jQuery(function(){
    jQuery('#mov_ondate').datetimepicker({
        format:'Y-m-d',
        value:'${movVO.movondate}',
        onShow:function( ct ){
        this.setOptions({
            maxDate:jQuery('#mov_offdate').val()?jQuery('#mov_offdate').val():false
        })
        },
        timepicker:false
 });
jQuery('#mov_offdate').datetimepicker({
    format:'Y-m-d',
    value:'${movVO.movoffdate}',
    onShow:function( ct ){
    this.setOptions({
        minDate:jQuery('#mov_ondate').val()?jQuery('#mov_ondate').val():false
    })
    },
    timepicker:false
    });
});
</script>
</html>