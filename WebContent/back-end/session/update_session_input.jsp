<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.session.model.*"%>

<html>
<head>
	<title>場次修改</title>	
	<!-- Common CSS -->
	<%@ include file="../files/comCssLinks.file"%>
	<!-- Your custom styles (optional) -->
	<link rel="stylesheet" href="<%=request.getContextPath()%>/resource/css/movie/backendMovie.css">
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
  #timetb th{
  	line-height: 28px;
  }
  #addtime, #delete{
    border: transparent;
    color: #fff;
    box-sizing: border-box;
    border-radius: 10px;
  }
  #delete{
  	background: rgb(16,16,16);
    padding: 6px 15px;
    font-size: 14px;
    position: absolute;
    left: 48%;
    bottom: 15.5%;
  }
  #addtime{
  	width: 80px;
    margin: 20px 0 8px 0;
    padding: 10px;
    background-color: #bb9d52;
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
			<c:set value="${movSvc.getOneMov(sesVO.movNo)}" var="movObj"></c:set>
		    <span>${movObj.movname}</span>
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
		<c:if test="${not empty errorMsgs.theNo}">
			<td class="errmsg-pos">		
				<i class="fa fa-hand-o-left" style="color:#bb9d52"></i>
				<label class="err-color">${errorMsgs.theNo}</label>
			</td>
		</c:if>
	</tr>
	<tr>
		<td><b>日期</b></td>
		<td>
			<input class="sty-input" name="sesDateBegin" id="" type="date" value="${sesVO.sesDate}" style="margin-left: 10px;"> 
	        ~<input class="sty-input" name="sesDateEnd" id="" type="date" value="">
		</td>
		<c:if test="${not empty errorMsgs.sesDate}">
			<td class="errmsg-pos">		
				<i class="fa fa-hand-o-left" style="color:#bb9d52"></i>
				<label class="err-color">${errorMsgs.sesDate}</label>
			</td>
		</c:if>
	</tr>
	<tr>
		<td>	
			<input id="addtime" type="button" value="新增時間">
		</td>
	</tr>
</table>

<table id="timetb" style="width:200px; display:${(not empty sesVO.sesTime)? none: block};">
	<tr>
		<th><b>編號</b></th>
		<th style="padding-left: 10px;"><b>時間</b></th>
	</tr>
   <%--  <c:forEach var="sesVO" items="${sesSvc.all}" varStatus="no" > --%>
		<tr>
		    <%-- <td>${no.index+1}</td> --%>
		    <td>1</td>
		    <td>
		        <input type="time" name="sesTime" value="${sesVO.sesTime}">
		    </td>
		    <td>
		        <input type="button" value="刪除" id="delete" onclick="removeTr(this)">
		    </td>
		</tr>
<%--     </c:forEach> --%>
</table>
<br>
<input type="hidden" name="action" value="update">
<input type="hidden" name="sesNo" value="${sesVO.sesNo}">
<input type="hidden" name="requestURL" value="<%=request.getParameter("requestURL")%>">
<input type="hidden" name="whichPage"  value="<%=request.getParameter("whichPage")%>">
<a class="btn btn-light btn-brd grd1 effect-1 btn-pos">
	<input type="submit" value="修改" class="input-pos">
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
		let tag = "<tr><td>"+i+"</td><td><input type="+"\""+"time"+"\""+"name="+"\""+"sestime"+"\""+"></td><td><input type="+"\""+"button"+"\""+"value="+"\""+"刪除"+"\""+"id="+"\""+"delete"+"\""+"onclick='removeTr(this)'></td></tr>";
		timetb.innerHTML += tag;
		
	},false);
	
	function removeTr(e){
		i--;
		e.closest('tr').remove();
	}
</script>
</html>