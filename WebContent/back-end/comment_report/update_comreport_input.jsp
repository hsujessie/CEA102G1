<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.session.model.*"%>

<html>
<head>
	<title>短評檢舉審核</title>
	<%@ include file="/back-end/files/sb_head.file"%>
	
<style>
  table {
	width: 750px;
	margin: 5px auto 5px auto;
    background-color: rgb(255,255,255);
    border-radius: 10px;
	-webkit-box-shadow: 0px 3px 5px rgb(8,8,8, 0.3);
	-moz-box-shadow: 0px 3px 5px rgb(8,8,8, 0.3);
	box-shadow: 0px 3px 5px rgb(8,8,8, 0.3);
  }
  th,td{
  	box-sizing:border-box;
    border-radius: 10px;
  }
  th{
  	width: 100px;
  	padding: 10px 0px 10px 70px;
  }
  td{
  	width: 250px;
  	padding: 10px 20px 10px 30px;
    border-bottom: 2px dotted #bb9d52;
  }
  .listOne-h3-pos{
  	display: inline-block;	
  	margin-left: 45%;
  }
  .ml-ten{
  	margin-left: 10px;
  }
</style>
</head>
<body class="sb-nav-fixed">
		<%@ include file="/back-end/files/sb_navbar.file"%> <!-- 引入navbar (上方) -->
        <div id="layoutSidenav">
            <div id="layoutSidenav_nav">
                <c:set value="movieComreportSub" var="urlRecog"></c:set> <!-- 給sb_sidebar.file的參數-Sub -->
				<%@ include file="/back-end/files/sb_sidebar.file"%> <!-- 引入sidebar (左方) -->
            </div>
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid">
                    
                       <!-- update comreport Start -->  
					   <FORM method="post" action="<%=request.getContextPath()%>/comment_report/comrep.do" name="form_updateComReport" enctype="multipart/form-data">	                 	
                       <h3 class="h3-style listOne-h3-pos">短評檢舉審核</h3>
						<c:if test="${addSuccess != null}">
							<span style="color: #bb9d52">  
								${addSuccess}
								<i class="fa fa-hand-peace-o"></i>
							</span>
						</c:if>
						<c:if test="${updateSuccess != null }">
							<span style="color: #bb9d52">  
								${updateSuccess}
								<i class="fa fa-hand-peace-o"></i>
							</span>
						</c:if>
						
			            <table>
							<tr>
								<th>短評編號</th>
								<td>	
									<input type="hidden" name="comNo" value="${comVO.comNo}">${comVO.comNo}						
								</td>
							</tr>
							<tr>
								<th>短評內容</th>
								<td>
									${comVO.comContent}							
								</td>
							</tr>
							<tr>
								<th>檢舉原因</th>								
									<c:if test="${comRepVO.getComRepReason() eq 1}"><td>與本電影無關、捏造假冒、不實敘述</td></c:if>	
									<c:if test="${comRepVO.getComRepReason() eq 2}"><td>具有廣告性質或大量重複散布</td></c:if>	
									<c:if test="${comRepVO.getComRepReason() eq 3}"><td>相互惡意攻訐、猥褻騷擾、人身攻擊</td></c:if>	
									<c:if test="${comRepVO.getComRepReason() eq 4}"><td>侵犯隱私權、違反智慧財產權、涉及違法情事</td></c:if>	
									<c:if test="${comRepVO.getComRepReason() eq 5}"><td>違背善良風俗</td></c:if>	
							</tr>							
							<tr>
								<th>狀態審核</th>
								<td>
									<input type="radio" name="comRepStatus" value="1"><label class="ml-ten">檢舉成功</label>&emsp;
									<input type="radio" name="comRepStatus" value="2"><label class="ml-ten">檢舉失敗</label>					
								</td>
							</tr>
						</table>
						<br>
						<input type="hidden" name="action" value="update">
						<input type="hidden" name="comRepNo" value="${comRepVO.comRepNo}">
						<input type="hidden" name="requestURL" value="<%=request.getParameter("requestURL")%>">
						<input type="hidden" name="whichPage"  value="<%=request.getParameter("whichPage")%>">
						<a class="btn btn-light btn-brd grd1 effect-1 btn-pos" style="margin: 1% 0 1% 50%;" >
							<input type="submit" value="送出" class="input-pos">
						</a>
						</FORM>
                       <!-- update comreport End -->
                    
                    </div>
                </main>
                <%@ include file="/back-end/files/sb_footer.file"%>
            </div>
        </div>
		<%@ include file="/back-end/files/sb_importJs.file"%> <!-- 引入template要用的js -->
</body>
</html>