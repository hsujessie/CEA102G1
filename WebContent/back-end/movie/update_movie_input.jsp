<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.movie.model.*"%>

<html>
<head>
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  	<!-- Font Awesome -->
	<link href='https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css' rel='stylesheet'></link> 
	<!-- Your custom styles (optional) -->
	<link rel="stylesheet" href="<%=request.getContextPath()%>/sources/css/cssReset.css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/sources/css/style.css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/sources/css/backendMovie.css">
<title>電影修改 - Update Movie input.jsp</title>


<style>
  .err-color{
    font-size: 12px;
    text-shadow: 0 0 0.2em #f87, 0 0 0.2em #f87;
  }
  .errmsg-pos{
  	padding-left: 15%;
  	width: 290px;
  }
  .sty-input{
	text-decoration: none;    
	border-color: transparent;
    width: 150px;
    border-bottom: 2px dashed #bb9d52;
    box-sizing: border-box;
    padding-bottom: 3px;
    color: #bb9d52;
	line-hight: 5px;
  }
  .mr-left{
    margin-left: 45%;
  }
  .mr-btm-normal{
    margin-bottom: 10%;
  }
  .mr-btm-sm{
    margin-bottom: 5%;
  }
  .fake-txt::after{
   	content: "小時";
    color: #bb9d52;
    position: absolute;
    top: 47%;
    left: 67%;
    right: 0;
    bottom: 0;
  }
  .add-mov-table tr{
  	height: 30px;
  }
  .add-mov-table span{
  	box-sizing: border-box;
  	padding-left: 3%;
  	color: #bb9d52;
  }
  .btn-pos{
  	margin-left: 20%;
  }
</style>

</head>
<body>
<FORM  class="center-linehigh-content" style="width:100%; margin-top: 10%;" method="post" action="<%=request.getContextPath()%>/movie/mov.do" name="form_updateMovie" enctype="multipart/form-data">	
<table class="add-mov-table">
	<tr>
		<td><b>名稱</b></td>
		<td><input class="sty-input mr-left mr-btm-normal" type="text" name="movname" value="${movVO.movname}" /></td>
		<c:if test="${not empty errorMsgs.movname}">
			<td class="errmsg-pos">		
				<i class="fa fa-hand-o-left" style="color:#bb9d52"></i>
				<label class="err-color">${errorMsgs.movname}</label>
			</td>
		</c:if>
	</tr>

	<jsp:useBean id="movSvc" scope="page" class="com.movie.model.MovService" />
	<tr>
		<td><b>種類</b></td>
		<td>
			<!-- 多選checkbox -->
				<input class="mr-left mr-btm-sm" type="checkbox" name="movver" value="2D"      <c:forEach var="i" begin="0" end="2"> <c:if test="${movverToken[i].contains('2D')}">      checked </c:if></c:forEach> ><span>2D</span><br/>
				<input class="mr-left mr-btm-sm" type="checkbox" name="movver" value="3D"      <c:forEach var="i" begin="0" end="2"> <c:if test="${movverToken[i].contains('3D')}">      checked </c:if></c:forEach> ><span>3D</span><br/>
				<input class="mr-left mr-btm-sm" type="checkbox" name="movver" value="IMAX"    <c:forEach var="i" begin="0" end="2"> <c:if test="${movverToken[i].contains('IMAX')}">    checked </c:if></c:forEach> ><span>IMAX</span><br/>
		</td>
		<c:if test="${not empty errorMsgs.movver}">
			<td class="errmsg-pos">		
				<i class="fa fa-hand-o-left" style="color:#bb9d52"></i>
				<label class="err-color">${errorMsgs.movver}</label>
			</td>
		</c:if>
	</tr>
	<tr>
		<td><b>類型</b></td>
		<td>
			<select class="mr-left mr-btm-normal" name="movtype">
				<option value= "劇情片" <c:forEach var="movVO" items="${movSvc.all}">  <c:if test="${movVO.movtype.contains('劇情片')}"> selected </c:if></c:forEach> >劇情片</option>
				<option value= "動畫片" <c:forEach var="movVO" items="${movSvc.all}">  <c:if test="${movVO.movtype.contains('動畫片')}"> selected </c:if></c:forEach> >動畫片</option>
				<option value= "喜劇片" <c:forEach var="movVO" items="${movSvc.all}">  <c:if test="${movVO.movtype.contains('喜劇片')}"> selected </c:if></c:forEach> >喜劇片</option>
				<option value= "愛情片" <c:forEach var="movVO" items="${movSvc.all}">  <c:if test="${movVO.movtype.contains('愛情片')}"> selected </c:if></c:forEach> >愛情片</option>
				<option value= "科幻片" <c:forEach var="movVO" items="${movSvc.all}">  <c:if test="${movVO.movtype.contains('科幻片')}"> selected </c:if></c:forEach> >科幻片</option>
				<option value= "恐怖片" <c:forEach var="movVO" items="${movSvc.all}">  <c:if test="${movVO.movtype.contains('恐怖片')}"> selected </c:if></c:forEach> >恐怖片</option>
			</select>
		</td>
		<c:if test="${not empty errorMsgs.movtype}">
			<td class="errmsg-pos">		
				<i class="fa fa-hand-o-left" style="color:#bb9d52"></i>
				<label class="err-color">${errorMsgs.movtype}</label>
			</td>
		</c:if>
	</tr>
	<tr>
		<td><b>語言</b></td>
		<td>
			<!-- 多選checkbox -->
			<input class="mr-left mr-btm-sm" type="checkbox" name="movlan" value="英文" <c:forEach var="i" begin="0" end="1"> <c:if test="${movlanToken[i].contains('英文')}"> checked </c:if></c:forEach> ><span>英文</span><br/>
			<input class="mr-left mr-btm-sm" type="checkbox" name="movlan" value="中文" <c:forEach var="i" begin="0" end="1"> <c:if test="${movlanToken[i].contains('中文')}"> checked </c:if></c:forEach> ><span>中文</span><br/>
			<input class="mr-left mr-btm-sm" type="checkbox" name="movlan" value="日文" <c:forEach var="i" begin="0" end="1"> <c:if test="${movlanToken[i].contains('日文')}"> checked </c:if></c:forEach> ><span>日文</span><br/>
		</td>
		<c:if test="${not empty errorMsgs.movlan}">
			<td class="errmsg-pos">		
				<i class="fa fa-hand-o-left" style="color:#bb9d52"></i>
				<label class="err-color">${errorMsgs.movlan}</label>
			</td>
		</c:if>
	</tr>
	<tr>
		<td><b>上映日期</b></td>
		<td><input class="sty-input mr-left mr-btm-normal" name="movondate" id="mov_ondate" type="text"></td>
		<c:if test="${not empty errorMsgs.movondate}">
			<td class="errmsg-pos">		
				<i class="fa fa-hand-o-left" style="color:#bb9d52"></i>
				<label class="err-color">${errorMsgs.movondate}</label>
			</td>
		</c:if>
	</tr>
	<tr>
		<td><b>下檔日期</b></td>
		<td><input class="sty-input mr-left mr-btm-normal" name="movoffdate" id="mov_offdate" type="text"></td>
		<c:if test="${not empty errorMsgs.movoffdate}">
			<td class="errmsg-pos">		
				<i class="fa fa-hand-o-left" style="color:#bb9d52"></i>
				<label class="err-color">${errorMsgs.movoffdate}</label>
			</td>
		</c:if>
	</tr>
	<tr>
		<td style="position:relative;"><b>片長</b></td>
		<td class="fake-txt"><input class="sty-input mr-left mr-btm-normal" type="text" name="movdurat" value="${ empty movVO.movdurat ? '2' : movVO.movdurat}"/></td>
		<c:if test="${not empty errorMsgs.movdurat}">
			<td class="errmsg-pos" style="padding-left: 25%;">		
				<i class="fa fa-hand-o-left" style="color:#bb9d52"></i>
				<label class="err-color">${errorMsgs.movdurat}</label>
			</td>
		</c:if>
	</tr>
	<tr>
		<td><b>級數</b></td>
		<td>
			<select class="mr-left mr-btm-normal" name="movrating">
				<option value="普遍級" <c:forEach var="movVO" items="${movSvc.all}"><c:if test="${movVO.movrating.contains('普遍級')}"> selected </c:if></c:forEach> >普遍級</option>
				<option value="保護級" <c:forEach var="movVO" items="${movSvc.all}"><c:if test="${movVO.movrating.contains('保護級')}"> selected </c:if></c:forEach> >保護級</option>
				<option value="輔導級" <c:forEach var="movVO" items="${movSvc.all}"><c:if test="${movVO.movrating.contains('輔導級')}"> selected </c:if></c:forEach> >輔導級</option>
				<option value="限制級" <c:forEach var="movVO" items="${movSvc.all}"><c:if test="${movVO.movrating.contains('限制級')}"> selected </c:if></c:forEach> >限制級</option>
			</select>
		</td>
	</tr>
	<tr>
		<td><b>導演</b></td>
		<td><input class="sty-input mr-left mr-btm-normal" type="text" name="movditor" value="${movVO.movditor}" /></td>
		<c:if test="${not empty errorMsgs.movditor}">
			<td class="errmsg-pos">		
				<i class="fa fa-hand-o-left" style="color:#bb9d52"></i>
				<label class="err-color">${errorMsgs.movditor}</label>
			</td>
		</c:if>
	</tr>
	<tr>
		<td><b>演員</b></td>
		<td><input class="sty-input mr-left mr-btm-normal" type="text" name="movcast" value="${movVO.movcast}" /></td>
		<c:if test="${not empty errorMsgs.movcast}">
			<td class="errmsg-pos">		
				<i class="fa fa-hand-o-left" style="color:#bb9d52"></i>
				<label class="err-color">${errorMsgs.movcast}</label>
			</td>
		</c:if>
	</tr>
	<tr>
		<td><b>簡介</b></td>
		<td>
			<textarea name="movdes" class="sty-input mr-left">${movVO.movdes}</textarea>
		</td>
		<c:if test="${not empty errorMsgs.movdes}">
			<td class="errmsg-pos">		
				<i class="fa fa-hand-o-left" style="color:#bb9d52"></i>
				<label class="err-color">${errorMsgs.movdes}</label>
			</td>
		</c:if>
	</tr>
	<tr></tr>
	<tr>
		<td><b>海報</b></td>	
		<td>
			<label class="btn" style="margin-left: 35%;">
			<input style="display:none;" type="file" name="movpos" value="${movVO.movpos}"/>
				<i class="fa fa-photo"></i>
			</label>
			<c:if test="${not empty movVO.movpos}">
				<img src="<%=request.getContextPath()%>/movie/mov.do?movno=${movVO.movno}&img=movpos&action=get_One_MovPic">
			</c:if>
		</td>
	</tr>
	<tr>
		<td><b>預告片</b></td>
		<td>			
			<label class="btn" style="margin-left: 35%;">
			<input style="display:none;" type="file" name="movtra" value="${movVO.movtra}"/>
				<i class="fa fa-film"></i>
			</label>
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
<!-- <a class="btn btn-light btn-radius btn-brd grd1 effect-1 btn-pos" style="background-color:#bb9d52;"> -->
<a class="btn btn-light btn-radius btn-brd grd1 effect-1 btn-pos" style="background-color: black;">
	<input type="submit" value="修改" class="input-pos" style="color: #fff;">
</a>
</FORM>
</body>

<!-- =========================================================================================== 
    								以下 DATETIME PICKER
	 ===========================================================================================  -->
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