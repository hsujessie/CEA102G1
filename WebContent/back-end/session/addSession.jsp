<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.session.model.*"%>
<%@ page import="com.movie.model.*"%>

<%SesVO sesVO = (SesVO) request.getAttribute("sesVO");%>

<html>
<head>
	<title>場次新增</title>	
	<!-- Common CSS -->
	<%@ include file="../files/comCssLinks.file"%>
	<!-- Your custom styles (optional) -->
	<link rel="stylesheet" href="<%=request.getContextPath()%>/resource/css/backendMovie.css">
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
  .mr-btm-sm{
    margin-bottom: 5%;
  }
  .fake-txt::after{
   	content: "小時";
    color: #bb9d52;
    position: absolute;
    top: 40%;
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
  #timetb tbody{
  	border-bottom: 2px dotted #bb9d52;
  }
  #addtime{
  	width: 80px;
    margin: 20px 0 8px 0;
    border: transparent;
    color: #fff;
    background-color: #bb9d52;
    box-sizing: border-box;
    padding: 10px;
    border-radius: 10px;
}
  }
</style>

</head>
<body>
<FORM class="center-linehigh-content" style="width:100%; margin: 6% 0 0 23%;" method="post" action="<%=request.getContextPath()%>/session/ses.do" name="form_addSession" enctype="multipart/form-data">
<table class="add-mov-table">
	<tr style="line-height: 50px;">
	
		<jsp:useBean id="movSvc" scope="page" class="com.movie.model.MovService"/>
		<td><b>電影</b></td>
		<td>
			<select name="movNo">
	             <option value=""></option>
	             <c:forEach var="movVO" items="${movSvc.all}" >
	             	<option value="${movVO.movno}">${movVO.movname}
	             </c:forEach>
             </select>
		</td>
	</tr>
	<tr>
		<td><b>廳院</b></td>
		<td style="padding-left: 10px;">
			<!-- 多選checkbox -->
			<input class="mr-left mr-btm-sm" type="checkbox" name="theNo" value="1"><span>Ａ廳(2D)</span><br>
			<input class="mr-left mr-btm-sm" type="checkbox" name="theNo" value="2"><span>B廳(3D)</span><br>
			<input class="mr-left mr-btm-sm" type="checkbox" name="theNo" value="3"><span>C廳(IMAX)</span><br>
		</td>
	</tr>
	<tr>
		<td><b>日期</b></td>
		<td>
			<input class="sty-input" name="sesDateBegin" id="" type="date" value="" style="margin-left: 10px;"> 
	        ~<input class="sty-input" name="sesDateEnd" id="" type="date" value="">
		</td>
	</tr>
	<tr>
		<td>	
			<input id="addtime" type="button" value="新增時間">
		</td>
	</tr>
</table>
<table id="timetb" style="width:200px; display:none;">
	<tr>
		<th><b>編號</b></th>
		<th style="padding-left: 10px;"><b>時間</b></th>
	</tr>
</table>
<br>
<input type="hidden" name="action" value="insert">
<a class="btn btn-light btn-brd grd1 effect-1 btn-pos">
	<input type="submit" value="送出" class="input-pos">
</a>
</FORM>
</body>
<script>
	let addtime = document.getElementById("addtime");
	let i = 0;
	addtime.addEventListener("click",function(){
		i+=1;
		let timetb = document.getElementById("timetb");
		timetb.style.display="block";
		let tag = "<tr><td>"+i+"</td><td><input type="+"\""+"time"+"\""+"name="+"\""+"sesTime"+"\""+"></td><td><input type="+"\""+"button"+"\""+"value="+"\""+"刪除"+"\""+"id="+"\""+"delete"+"\""+"onclick='removeTr(this)'></td></tr>";
		timetb.innerHTML += tag;
		
	},false);
	
	function removeTr(e){
		i--;
		e.closest('tr').remove();
	}
</script>
</html>