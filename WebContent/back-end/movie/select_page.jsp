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
       <select size="1" name="movno">
         <c:forEach var="movVO" items="${movSvc.all}" > 
          <option value="${movVO.movno}">${movVO.movname}
         </c:forEach>
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="送出">
     </FORM>
  </li>
</ul>


<h3>電影管理</h3>

<ul>
  <li><a href='addMovie.jsp'>Add</a> a new Movie.</li>
</ul>
${movVO.movno}
</body>
</html>