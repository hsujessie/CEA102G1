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
<c:choose>
    <c:when test="${cssForListSessionsByCompositeQuery}">
      .form-sty{
			padding: 6% 0 0 21%;
       }   	
	  .fake-txt::after{
	    top: 46%;
    	left: 67.5%;
	    right: 0;
	    bottom: 0;
	  }
	  .btn-pos{
	  	margin-left: 30%;
	    margin-top: 10%;
	    margin-bottom: 1%;
	  }
	  .input-pos {
	    position: absolute;
	    top: 1%;
	    right: 0;
	    left: 15%;
	    bottom: 0;
	    font-size: 14px;
	    text-decoration: none;
	    background-color: transparent;
	    border: 0px;
	    cursor: pointer;
      }
      
/*------------------------------------------------------------------
    BUTTON
-------------------------------------------------------------------*/      
	.btn {
	    width: 30px;
	    height: 22px;
    }
	.grd1 {
		color: #ffffff;
	    background: rgb(16,16,16);
	}
	.grd1:hover,
	.grd1:focus {
		color: #ffffff;
	    background: #bb9d52;
	}
	.effect-1:after, .btn-brd {
	    -webkit-border-radius: 10px;
	    -moz-border-radius: 10px;
	    border-radius: 10px;
	}	
	.effect-1:after {
	    box-shadow: 0 0 0 2px #bb9d52;
	}
	.effect-1 {
	    display: inline-block;
	    cursor: pointer;
	    text-align: center;
	    position: relative;
	    text-decoration: none;
	    z-index: 1;
	}	
	.effect-1 {
	    -webkit-transition: background 0.2s, color 0.2s;
	    -moz-transition: background 0.2s, color 0.2s;
	    transition: background 0.2s, color 0.2s;
	}	
	.effect-1:after {
	    top: -2px;
	    left: -2px;
	    padding: 2px;
	    box-shadow: 0 0 0 2px #bb9d52;
	    -webkit-transition: -webkit-transform 0.2s, opacity 0.2s;
	    -webkit-transform: scale(.8);
	    -moz-transition: -moz-transform 0.2s, opacity 0.2s;
	    -moz-transform: scale(.8);
	    -ms-transform: scale(.8);
	    transition: transform 0.2s, opacity 0.2s;
	    transform: scale(.8);
	    opacity: 0;
	}	
	.effect-1:after {
	    pointer-events: none;
	    position: absolute;
	    width: 100%;
	    height: 100%;
	    border-radius: 10px;
	    content: '';
	    -webkit-box-sizing: content-box;
	    -moz-box-sizing: content-box;
	    box-sizing: content-box;
	}
	.effect-1:hover:after {
	    -webkit-transform: scale(1);
	    -moz-transform: scale(1);
	    -ms-transform: scale(1);
	    transform: scale(1);
	    opacity: 1;
	}	
	.effect-1:after {
	    -webkit-transform: scale(1.2);
	    -moz-transform: scale(1.2);
	    -ms-transform: scale(1.2);
	    transform: scale(1.2);
	}	
	.effect-1:hover:after {
	    -webkit-transform: scale(1);
	    -moz-transform: scale(1);
	    -ms-transform: scale(1);
	    transform: scale(1);
	    opacity: 1;
	}
    </c:when>
    <c:otherwise>
    	.form-sty{
			padding: 6% 0 0 23%;
    	}  	
	  .fake-txt::after{
	    top: 40.5%;
	    left: 67%;
	    right: 0;
	    bottom: 0;
	  }
	  .btn-pos{
	  	margin-left: -46%;
	    margin-top: 10%;
	    margin-bottom: 1%;
	  }
    </c:otherwise>
</c:choose>
</style>

</head>
<body>
<FORM class="center-linehigh-content" style="width:100%; margin: 6% 0 0 23%;" method="post" action="<%=request.getContextPath()%>/session/ses.do" name="form_addSession" enctype="multipart/form-data">
<table class="add-mov-table">
	<tr>	
		<jsp:useBean id="movSvc" scope="page" class="com.movie.model.MovService"/>
		<td><b>電影</b></td>
		<td style="color: #bb9d52; padding-left: 3%;">
			<c:if test="${not empty sesVO.movNo}"> <!-- 沒寫這行判斷，會有java.lang.NullPointerException -->
				<c:set value="${movSvc.getOneMov(sesVO.movNo)}" var="movObj"></c:set>
			    ${movObj.movname}
		   </c:if>
		</td>
	</tr>
	<tr style="line-height: 28px;"></tr>
	<tr>
		<td><b>廳院</b></td>
		<td style="padding-left: 10px;">
			<!-- 多選checkbox -->			
			<input class="mr-left mr-btm-sm" type="radio" name="theNo" value="1" <c:if test="${sesVO.theNo == 1}">checked</c:if> ><span>Ａ廳(2D)</span><br>
			<input class="mr-left mr-btm-sm" type="radio" name="theNo" value="2" <c:if test="${sesVO.theNo == 2}">checked</c:if> ><span>B廳(3D)</span><br>
			<input class="mr-left mr-btm-sm" type="radio" name="theNo" value="3" <c:if test="${sesVO.theNo == 3}">checked</c:if> ><span>C廳(IMAX)</span><br>
		</td>
		<c:if test="${not empty errorMsgs.theNo}">
			<td class="errmsg-pos">		
				<i class="fa fa-hand-o-left" style="color:#bb9d52"></i>
				<label class="err-color">${errorMsgs.theNo}</label>
			</td>
		</c:if>
	</tr>
	<tr style="line-height: 28px;"></tr>
	<tr>
		<td><b>日期</b></td>
		<td>
			<input class="sty-input" name="sesDate" id="" type="date" value="${sesVO.sesDate}" style="margin-left: 10px;">
		</td>
		<c:if test="${not empty errorMsgs.sesDate}">
			<td class="errmsg-pos">		
				<i class="fa fa-hand-o-left" style="color:#bb9d52"></i>
				<label class="err-color">${errorMsgs.sesDate}</label>
			</td>
		</c:if>
	</tr>
	<tr style="line-height: 28px;"></tr>
	<tr>
		<td><b>時間</b></td>
		<td style="padding-left: 10px;">	
		    <input class="sty-input" type="time" name="sesTime" value="${sesVO.sesTime}">
		</td>
	</tr>
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
</html>