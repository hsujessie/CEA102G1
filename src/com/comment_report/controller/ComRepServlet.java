package com.comment_report.controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.comment.model.ComService;
import com.comment.model.ComVO;
import com.comment_report.model.ComRepService;
import com.comment_report.model.ComRepVO;
import com.movie.model.MovService;
import com.movie.model.MovVO;

public class ComRepServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException{
		doPost(req,res);
	}
	
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException{
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		System.out.println("action:"+action);
		
		// 來自前台 movies_subpage.jsp的請求
		if ("insert".equals(action)) {
			Map<String,String> errorMsgs = new LinkedHashMap<String,String>();
			req.setAttribute("errorMsgs",errorMsgs);
			
			try {
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/					
				Integer comNo = null;
				comNo = new Integer(req.getParameter("comNo").trim());
				
				Integer memNo = null;
				memNo = new Integer(req.getParameter("memNo").trim());				
				
				String comRepReason = null;
				String[] comRepReasonArr = req.getParameterValues("comRepReason"); 
				for(int i = 0; i < comRepReasonArr.length; i++) {
					comRepReason = comRepReasonArr[i];
				}
				
				java.sql.Timestamp comRepTime = new Timestamp(System.currentTimeMillis());

				Integer comRepStatus = 0; //0:未處理 
				

				Integer movNo = new Integer(req.getParameter("movNo").trim());
				
				System.out.println("memNo= " + memNo);
				System.out.println("comNo= " + comNo);
				System.out.println("comRepReason= " + comRepReason);
				System.out.println("comRepTime= " + comRepTime);
				System.out.println("movNo= " + movNo);
				
//				ComRepVO comRepVO = new ComRepVO();
//				comRepVO.setComNo(comNo);
//				comRepVO.setMemNo(memNo);
//				comRepVO.setComRepTime(comRepTime);
//				comRepVO.setComRepReason(comRepReason);
//				comRepVO.setComRepStatus(comRepStatus);
				
				/***************************2.開始新增資料***************************************/				
				ComRepService comRepSvc = new ComRepService();
				comRepSvc.addComRep(comNo, memNo, comRepReason, comRepTime, comRepStatus);
				
//				ComService comSvc = new ComService();
//				ComVO comVO = comSvc.getOneCom(comNo);
//
//				MovService movSvc = new MovService();
//				MovVO movVO = movSvc.getOneMov(movNo);
					
				/***************************3.新增完成,準備轉交(Send the Success view)***********/	
//				req.setAttribute("comVO", comVO);
//				req.setAttribute("movVO", movVO);
//				
//				String url = "/front-end/movies/movies_subpage.jsp";
//				RequestDispatcher successView = req.getRequestDispatcher(url);
//				successView.forward(req, res);	
				
				/***************************其他可能的錯誤處理**********************************/
			}catch (Exception e) {
				errorMsgs.put("Exception",e.getMessage());
				String url = "/front-end/movies/movies_subpage.jsp";
				RequestDispatcher failureView = req.getRequestDispatcher(url);
				failureView.forward(req, res);
			}
		} 
				
				
								
		
	}
}
