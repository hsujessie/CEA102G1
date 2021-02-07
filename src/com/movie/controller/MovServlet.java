package com.movie.controller;

import java.io.IOException;
import java.io.InputStream;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.movie.model.MovService;
import com.movie.model.MovVO;

public class MovServlet extends HttpServlet{
	private static final long serialVersionUID = 1L;  
	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException{
		doPost(req,res);
	}
	
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException{
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		// 來自select_page.jsp的請求
		if("getOne_For_Display".equals(action)) { 
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***************************1.接收請求參數*****************************************/
				String str = req.getParameter("movno");
				Integer movno = null;
				movno = new Integer(str);
				
				/***************************2.開始查詢資料*****************************************/
				MovService movSvc = new MovService();
				MovVO movVO = movSvc.getOneMov(movno);
				if (movVO == null) {
					errorMsgs.add("查無資料");
				}
				
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/movie/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("movVO", movVO);
				String url = "/back-end/movie/listOneMovie.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
				
			}catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureVoew = req.getRequestDispatcher("/back-end/movie/select_page.jsp");
				failureVoew.forward(req,res);
			}
		}
		
		// 來自addMov.jsp的請求 
		if ("insert".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs",errorMsgs);
			try {
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
				String movname = req.getParameter("movname").trim();
				String movnameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{1,30}$";
				if(movname == null || movname.length() == 0) {
					errorMsgs.add("電影名稱: 請勿空白");
				}else if(!movname.trim().matches(movnameReg)) {
					errorMsgs.add("電影名稱: 只能是中、英文字母、數字和_ , 且長度必需在1到30之間");
				}
				
				//多選checkbox
				String[] movverStr = req.getParameterValues("movver");	
		        StringBuilder movverSb = new StringBuilder();
		        String movver = null;
		        if (movverStr != null) {
		            for (int i = 0; i < movverStr.length; i++) {
		            	movverSb = movverSb.append(movverStr[i].trim());
		            	movver = movverSb.toString();
		            }
		            System.out.println("movver="+movver);
		        }
				
				//單選下拉選單
				String movtype = req.getParameter("movtype");
				
				//多選checkbox
				String[] movlanStr = req.getParameterValues("movlan");	
		        StringBuilder movlanSb = new StringBuilder();
		        String movlan = null;
		        if (movlanStr != null) {
		            for (int i = 0; i < movlanStr.length; i++) {
		            	movlanSb = movlanSb.append(movlanStr[i].trim());
		                movlan = movlanSb.toString();
		            }
		            System.out.println("movlan="+movlan);
		        }
						

				java.sql.Date movondate = null;
				try {
					movondate = java.sql.Date.valueOf(req.getParameter("movondate").trim());
				} catch (IllegalArgumentException e) {
					movondate = new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("請輸入上映日期!");
				}
				
				java.sql.Date movoffdate = null;
				try {
					movoffdate = java.sql.Date.valueOf(req.getParameter("movondate").trim());
				} catch (IllegalArgumentException e) {
					movoffdate = new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("請輸入下檔日期!");
				}
				Integer movdurat = null;
				try {
					movdurat = new Integer(req.getParameter("movdurat").trim());
				}catch(NumberFormatException e) {
					movdurat = 0;
					errorMsgs.add("片長請填數字!");
				}
				
				//單選下拉選單
				String movrating = req.getParameter("movrating");
				
				
				String movditor = req.getParameter("movditor").trim();
				String movditorReg = "^[(\u4e00-\u9fa5)(a-zA-Z)]{1,30}$";
				if(movditor == null || movditor.length() == 0) {
					errorMsgs.add("導演資料: 請勿空白");
				}else if(!movditor.trim().matches(movditorReg)) {
					errorMsgs.add("導演資料: 只能是中、英文字母, 且長度必需在1到30之間");
				}
				
				String movcast = req.getParameter("movcast").trim();
				String movcastReg = "^[(\u4e00-\u9fa5)(a-zA-Z)]{1,100}$";
				if(movcast == null || movcast.length() == 0) {
					errorMsgs.add("演員資料: 請勿空白");
				}else if(!movcast.trim().matches(movcastReg)) {
					errorMsgs.add("演員資料: 只能是中、英文字母, 且長度必需在1到100之間");
				}
				
				String movdes = req.getParameter("movdes").trim();
				String movdesReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{1,500}$";
				if(movdes == null || movname.length() == 0) {
					errorMsgs.add("電影簡介: 請勿空白");
				}else if(!movdes.trim().matches(movdesReg)) {
					errorMsgs.add("電影簡介: 長度必需在500字以內");
				}

				byte[] movpos = null;
				Part movposPart = req.getPart("movpos");
				InputStream movposis = movposPart.getInputStream();
				movpos = new byte[movposis.available()];
				movposis.read(movpos);
				movposis.close();

				byte[] movtra = null;
				Part movtraPart = req.getPart("movtra");
				InputStream movtrais = movtraPart.getInputStream();
				movtra = new byte[movtrais.available()];
				movtrais.read(movtra);
				movtrais.close();
				
				MovVO movVO = new MovVO();
				movVO.setMovname(movname);
				movVO.setMovver(movver);
				movVO.setMovtype(movtype);
				movVO.setMovlan(movlan);
				movVO.setMovondate(movondate);
				movVO.setMovoffdate(movoffdate);
				movVO.setMovdurat(movdurat);
				movVO.setMovrating(movrating);
				movVO.setMovditor(movditor);
				movVO.setMovcast(movcast);
				movVO.setMovdes(movdes);
				movVO.setMovpos(movpos);
				movVO.setMovtra(movtra);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("movVO", movVO);
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/movie/addMov.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始新增資料***************************************/
				
				MovService movSvc = new MovService();
				//movSvc.addMov(movname, movver, movtype, movlan, movondate, movoffdate, movdurat, movrating, movditor, movcast, movdes, movpos, movtra);
				System.out.print(movpos);
				System.out.print(movtra);
				movSvc.addMov(movname, movver, movtype, movlan, movondate, movoffdate, movdurat, movrating, movditor, movcast, movdes, movpos, movtra);

				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				String url = "/back-end/movie/listAllMovie.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);	
				
				/***************************其他可能的錯誤處理**********************************/
			}catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/movie/addMovie.jsp");
				failureView.forward(req, res);
			}
		} 
		
	}
	
}
