<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.movie.model.*"%>

<%MovVO movVO = (MovVO) request.getAttribute("movVO");%>

<html>
<head>
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<link rel="stylesheet" href="../../sources/css/cssReset.css">
	<link rel="stylesheet" href="../../sources/css/style.css">
	<link rel="stylesheet" href="../../sources/css/backendMovie.css">
	<link href='https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css' rel='stylesheet'></link>
<title>電影新增 - addMov.jsp</title>

<style>
  .errColor{
   	color:red;
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
    margin-left: 20%;
  }
  .mr-btm-normal{
    margin-bottom: 10%;
  }
  .mr-btm-sm{
    margin-bottom: 5%;
  }
</style>

</head>
<body>
<FORM class="center-linehigh-content" method="post" action="<%=request.getContextPath()%>/movie/mov.do" name="form_addMovie" enctype="multipart/form-data">
<table>
	<tr>
		<td><b>名稱</b></td>
		<td><input class="sty-input mr-left mr-btm-normal" type="text" name="movname" value="<%= (movVO==null)? "金牌特務" : movVO.getMovname()%>" /></td>
		<td class="errColor">${errorMsgs.movname}</td>
	</tr>
	<tr>
		<td><b>種類</b></td>
		<td>
			<!-- 多選checkbox -->
			<input class="mr-left mr-btm-sm" type="checkbox" name="movver" value="2D" ${movver == null? "checked":""} >2D<br>
			<input class="mr-left mr-btm-sm" type="checkbox" name="movver" value="3D">3D<br>
			<input class="mr-left mr-btm-sm" type="checkbox" name="movver" value="IMAX">IMAX<br>
		</td>
		<td class="errColor">${errorMsgs.movver}</td>
	</tr>
	<tr>
		<td><b>類型</b></td>
		<td>
			<select class="mr-left mr-btm-normal" name="movtype">
				<option value="動畫片">動畫片</option>
				<option value="喜劇片">喜劇片</option>
				<option value="愛情片">愛情片</option>
				<option value="科幻片">科幻片</option>
				<option value="恐怖片">恐怖片</option>
			</select>
		</td>
		<td class="errColor">${errorMsgs.movtype}</td>
	</tr>
	<tr>
		<td><b>語言</b></td>
		<td>
			<!-- 多選checkbox -->
			<input class="mr-left mr-btm-sm" type="checkbox" name="movlan" value="英文" ${movlan == null? "checked":""} >英文<br>
			<input class="mr-left mr-btm-sm" type="checkbox" name="movlan" value="中文">中文<br>
			<input class="mr-left mr-btm-sm" type="checkbox" name="movlan" value="日文">日文<br>
		</td>
		<td class="errColor">${errorMsgs.movlan}</td>
	</tr>
	<tr>
		<td><b>上映日期</b></td>
		<td><input class="sty-input mr-left mr-btm-normal" name="movondate" id="mov_ondate" type="text"></td>
		<td class="errColor">${errorMsgs.movondate}</td>
	</tr>
	<tr>
		<td><b>下檔日期</b></td>
		<td><input class="sty-input mr-left mr-btm-normal" name="movoffdate" id="mov_offdate" type="text"></td>
		<td class="errColor">${errorMsgs.movoffdate}</td>
	</tr>
	<tr>
		<td><b>片長</b></td>
		<td><input class="sty-input mr-left mr-btm-normal" type="text" name="movdurat" value="<%= (movVO==null)? "2" : movVO.getMovdurat()%>"/>小時</td>
		<td class="errColor">${errorMsgs.movdurat}</td>
	</tr>
	<tr>
		<td><b>級數</b></td>
		<td>
			<select class="mr-left mr-btm-normal" name="movrating">
				<option value="普遍級">普遍級</option>
				<option value="保護級">保護級</option>
				<option value="輔導級">輔導級</option>
				<option value="限制級">限制級</option>
			</select>
		</td>
	</tr>
	<tr>
		<td><b>導演</b></td>
		<td><input class="sty-input mr-left mr-btm-normal" type="text" name="movditor" value="<%= (movVO==null)? "dicrector" : movVO.getMovditor()%>" /></td>	
		<td class="errColor">${errorMsgs.movditor}</td>
	</tr>
	<tr>
		<td><b>演員</b></td>
		<td><input class="sty-input mr-left mr-btm-normal" type="text" name="movcast" value="<%= (movVO==null)? "actors" : movVO.getMovcast()%>" /></td>
		<td class="errColor">${errorMsgs.movcast}</td>
	</tr>
	<tr>
		<td><b>簡介</b></td>
		<td><textarea name="movdes" class="sty-input mr-left mr-btm-normal">
			<%= (movVO==null)? "description" : movVO.getMovdes()%></textarea>
		</td>
		<td class="errColor">${errorMsgs.movcast}</td>
	</tr>
	<tr>
		<td><b>海報</b></td>	
		<td>	
			<label class="btn" style="margin-left:10%;">
			<input style="display:none;" type="file" name="movpos" value="<%= (movVO==null)? "poster" : movVO.getMovpos()%>"/>
				<i class="fa fa-photo"></i>
			</label>
		</td>
	</tr>
	<tr>
		<td><b>預告片</b></td>
		<td>
			<label class="btn" style="margin-left:10%;">
			<input style="display:none;" type="file" name="movtra" value="<%=  (movVO==null)? "trailer" : movVO.getMovtra()%>"/>
				<i class="fa fa-film"></i>
			</label>
		</td>
	</tr>
</table>
<br>
<input type="hidden" name="action" value="insert">
<a class="btn btn-light btn-radius btn-brd grd1 effect-1">
	<input type="submit" value="新增" class="input-pos">
</a>
</FORM>
</body>

<!-- =========================================================================================== 
    								以下 DATETIME PICKER
	 ===========================================================================================  -->
<%
  java.sql.Date movondate = null;
  java.sql.Date movoffdate = null;
  try {
	  movondate = movVO.getMovondate();
	  movoffdate = movVO.getMovoffdate();
   } catch (Exception e) {
	   movondate = new java.sql.Date(System.currentTimeMillis());
	   movoffdate = new java.sql.Date(System.currentTimeMillis());
   }
%>
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
jQuery(function(){
    jQuery('#mov_ondate').datetimepicker({
        format:'Y-m-d',
        value: '<%=movondate%>',
        onShow:function( ct ){
        this.setOptions({
            maxDate:jQuery('#mov_offdate').val()?jQuery('#mov_offdate').val():false
        })
        },
        timepicker:false
 });
jQuery('#mov_offdate').datetimepicker({
    format:'Y-m-d',
    value: '<%=movoffdate%>',
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