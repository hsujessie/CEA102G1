<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.movie.model.*"%>

<%MovVO movVO = (MovVO) request.getAttribute("movVO");%>

<html>
<head>
	<title>電影新增</title>	
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
  .btn-pos{
  	margin-left: -46%;
    margin-top: 10%;
    margin-bottom: 1%;
  }
</style>

</head>
<body>
<FORM class="center-linehigh-content" style="width:100%; margin: 6% 0 0 23%;" method="post" action="<%=request.getContextPath()%>/movie/mov.do" name="form_addMovie" enctype="multipart/form-data">
<table class="add-mov-table">
	<tr>
		<td><b>名稱</b></td>
		<td><input class="sty-input mr-left mr-btm-normal" type="text" name="movname" value="<%= (movVO==null)? "金牌特務" : movVO.getMovname()%>" /></td>		
		<c:if test="${not empty errorMsgs.movname}">
			<td class="errmsg-pos">		
				<i class="fa fa-hand-o-left" style="color:#bb9d52"></i>
				<label class="err-color">${errorMsgs.movname}</label>
			</td>
		</c:if>
	</tr>
	<tr>
		<td><b>種類</b></td>
		<td>
			<!-- 多選checkbox -->
			<input class="mr-left mr-btm-sm" type="checkbox" name="movver" value="2D" ${movver == null? "checked":""} ><span>2D</span><br>
			<input class="mr-left mr-btm-sm" type="checkbox" name="movver" value="3D"><span>3D</span><br>
			<input class="mr-left mr-btm-sm" type="checkbox" name="movver" value="IMAX"><span>IMAX</span><br>
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
				<option value="劇情片">劇情片</option>
				<option value="動作片">動作片</option>
				<option value="動畫片">動畫片</option>
				<option value="喜劇片">喜劇片</option>
				<option value="愛情片">愛情片</option>
				<option value="科幻片">科幻片</option>
				<option value="恐怖片">恐怖片</option>
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
			<input class="mr-left mr-btm-sm" type="checkbox" name="movlan" value="英文" ${movlan == null? "checked":""} ><span>英文</span><br>
			<input class="mr-left mr-btm-sm" type="checkbox" name="movlan" value="中文"><span>中文</span><br>
			<input class="mr-left mr-btm-sm" type="checkbox" name="movlan" value="日文"><span>日文</span><br>
		</td>
		<c:if test="${not empty errorMsgs.movlan}">
			<td class="errmsg-pos">		
				<i class="fa fa-hand-o-left" style="color:#bb9d52"></i>
				<label class="err-color">${errorMsgs.movlan}</label>
			</td>
		</c:if>
	</tr>
<%
  java.sql.Date movondate = null;
  try {
	  movondate = movVO.getMovondate();
   } catch (Exception e) {
	   movondate = new java.sql.Date(System.currentTimeMillis());
   }
%>
	<tr>
		<td><b>上映日期</b></td>
		<td><input class="sty-input mr-left mr-btm-normal" name="movondate" id="mov_ondate" type="date" value="<%=movondate%>"></td>
		<c:if test="${not empty errorMsgs.movondate}">
			<td class="errmsg-pos">		
				<i class="fa fa-hand-o-left" style="color:#bb9d52"></i>
				<label class="err-color">${errorMsgs.movondate}</label>
			</td>
		</c:if>
	</tr>
	<tr>
		<td><b>下檔日期</b></td>
		<td><input class="sty-input mr-left mr-btm-normal" name="movoffdate" id="mov_offdate" type="date" value=""></td>
		<c:if test="${not empty errorMsgs.movoffdate}">
			<td class="errmsg-pos">		
				<i class="fa fa-hand-o-left" style="color:#bb9d52"></i>
				<label class="err-color">${errorMsgs.movoffdate}</label>
			</td>
		</c:if>
	</tr>
	<tr>
		<td style="position:relative;"><b>片長</b></td>
		<td class="fake-txt"><input class="sty-input mr-left mr-btm-normal" type="text" name="movdurat" value="<%= (movVO==null)? "2" : movVO.getMovdurat()%>"/></td>
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
		<c:if test="${not empty errorMsgs.movditor}">
			<td class="errmsg-pos">		
				<i class="fa fa-hand-o-left" style="color:#bb9d52"></i>
				<label class="err-color">${errorMsgs.movditor}</label>
			</td>
		</c:if>
	</tr>
	<tr>
		<td><b>演員</b></td>
		<td><input class="sty-input mr-left mr-btm-normal" type="text" name="movcast" value="<%= (movVO==null)? "actors" : movVO.getMovcast()%>" /></td>
		<c:if test="${not empty errorMsgs.movcast}">
			<td class="errmsg-pos">		
				<i class="fa fa-hand-o-left" style="color:#bb9d52"></i>
				<label class="err-color">${errorMsgs.movcast}</label>
			</td>
		</c:if>
	</tr>
	<tr>
		<td><b>簡介</b></td>
		<td><textarea name="movdes" class="sty-input mr-left"><%= (movVO==null)? "description" : movVO.getMovdes()%></textarea></td>
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
			<i class="fa fa-photo"></i>
			<input id="uploadFile" style="display:none;" type="file" name="movpos" value="<%= (movVO==null)? "poster" : movVO.getMovpos()%>"/>			
			</label>
		</td>
	</tr>
	<tr>
		<td id="show-poster">
			<span id="fileImg"></span>
		</td>
	</tr>
	<tr>
		<td style="height: 50px;"></td>
	</tr>
	<tr>
		<td><b>預告片</b></td>
		<td>
			<label class="btn" style="margin-left: 35%;">
			<i class="fa fa-film"></i>
			<input id="uploadTrailer" style="display:none;" type="file" name="movtra" value="<%=  (movVO==null)? "trailer" : movVO.getMovtra()%>"/>	
			</label>
		</td>
	</tr>
	<tr>
		<td id="show-trailer">
			<span id="trailerVdo"></span>
		</td>
	</tr>
</table>
<br>
<input type="hidden" name="action" value="insert">
<a class="btn btn-light btn-brd grd1 effect-1 btn-pos">
	<input type="submit" value="新增" class="input-pos">
</a>
</FORM>
</body>

<!-- =========================================================================================== 
    								以下 CALCULATE mov_ondate & mov_offdate
	 ===========================================================================================  -->
	<script>
	<%@ include file="../files/changeMovOffDate.file"%>
		let mov_ondate = document.getElementById('mov_ondate');
		let mov_offdate_val = document.getElementById('mov_offdate').value;
		if(mov_offdate_val.length == 0){
			changeMovOffDate();
		}
		mov_ondate.addEventListener('change',function(){
			changeMovOffDate();
		});
		
		

	/* =========================================================================================== */
    								/* 以下 SHOW a UPLOADED IMAGE & VIDEO */
	/* =========================================================================================== */
function init(){
    let uploadFile = document.getElementById('uploadFile');
    let fileImg = document.getElementById('fileImg');
    let uploadTrailer = document.getElementById('uploadTrailer');
    let trailerVdo = document.getElementById('trailerVdo');
    
    uploadFile.addEventListener('change',function(e){
        let files = e.target.files;
        if(files){
            for(let i = 0; i<files.length; i++){
                let file = files[i];
                if(file.type.indexOf('image') != -1){
                    let reader = new FileReader();
                    reader.addEventListener('load',function(e){
                        let result = e.target.result;
                        let img = document.createElement('img');
                        img.classList.add('img');
                        img.src = result;
                        fileImg.append(img);
                    });

                    reader.readAsDataURL(file);
                }
            }
        }
    });
    

    uploadTrailer.addEventListener('change',function(e){
        let files = e.target.files;
        if(files){
            for(let i = 0; i<files.length; i++){
                let file = files[i];
                if(file.type.indexOf('video') != -1 ){
                    let reader = new FileReader();
                    reader.addEventListener('load',function(e){
                        let result = e.target.result;
                        let video = document.createElement('video');
                        video.classList.add('vdo');
                        video.src = result;
                        trailerVdo.append(video);
                    });

                    reader.readAsDataURL(file);    	
    			}
            }
        }
    });
}
window.onload = init;
</script>
</html>