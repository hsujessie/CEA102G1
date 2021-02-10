package com.movie.controller;

import java.io.IOException;
import java.io.InputStream;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Set;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.movie.model.MovService;
import com.movie.model.MovVO;

@MultipartConfig()
public class MovServlet extends HttpServlet{
	private static final long serialVersionUID = 1L;  
	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException{
		doPost(req,res);
	}
	
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException{
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		System.out.println("action:"+action);
		
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
		
		// 來自listAllMovie.jsp的請求 - for displaying pictures
		if ("get_One_MovPic".equals(action)) {
			res.setContentType("img/jpg");
			Integer movno = new Integer(req.getParameter("movno").trim());
			MovService movSvc = new MovService();
			MovVO movVO = movSvc.getOneMov(movno);
			byte[] movpos = movVO.getMovpos();
			byte[] movtra = movVO.getMovtra();
			
			String img = req.getParameter("img");
			if(img.equals("movpos")) {
				if(movpos!=null) {
					res.getOutputStream().write(movpos);
					res.getOutputStream().flush();
					return;
				}
			}

			if(img.equals("movtra")) {
				if(movtra!=null) {
					res.getOutputStream().write(movtra);
					res.getOutputStream().flush();
					return;
				}				
			}
		}
				
		// 來自addMovie.jsp的請求 
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
		        String movver = "";
		        if (movverStr.length != 0) {
					movver = appendStr(movverStr);
		        }else {
					errorMsgs.add("電影種類: 請勿空白");
		        }
				
				//單選下拉選單
				String movtype = req.getParameter("movtype");

				//多選checkbox
				String[] movlanStr = req.getParameterValues("movlan");	
		        String movlan = "";
		        if (movlanStr.length != 0) {
		        	movlan = appendStr(movlanStr);
		        }else {
					errorMsgs.add("電影類型: 請勿空白");
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
				String movrating = req.getParameter("movrating").trim();
				
				
				String movditor = req.getParameter("movditor").trim();
				if(movditor == null || movditor.length() == 0) {
					errorMsgs.add("導演資料: 請勿空白");
				}
				
				String movcast = req.getParameter("movcast").trim();
				if(movcast == null || movcast.length() == 0) {
					errorMsgs.add("演員資料: 請勿空白");
				}
				
				String movdes = req.getParameter("movdes").trim();
				if(movdes == null || movname.length() == 0) {
					errorMsgs.add("電影簡介: 請勿空白");
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
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/movie/addMovie.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始新增資料***************************************/
				
				MovService movSvc = new MovService();
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
		
		 // 來自listAllMovie.jsp的請求
		if ("getOne_For_Update".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***************************1.接收請求參數****************************************/
				Integer movno = new Integer(req.getParameter("movno").trim());
				
				/***************************2.開始查詢資料****************************************/
				MovService movSvc = new MovService();
				MovVO movVO = movSvc.getOneMov(movno);

				
				//??? 我很有事，更新時，會把原本的值也存進去，傻眼ㄟ。-> 電影種類2D,3D,3D 
				//先split電影種類字串，再把值送到update_movie_input.jsp
				String movverStrs = movVO.getMovver();
				String[] movverToken = movverStrs.split(",");
				
				//先split電影語言字串，再把值送到update_movie_input.jsp
				String movlanStrs = movVO.getMovlan();
				String[] movlanToken = movlanStrs.split(",");
				
				
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("movVO", movVO); 
				req.setAttribute("movverToken", movverToken);    
				req.setAttribute("movlanToken", movlanToken);         
				
				String url = "/back-end/movie/update_movie_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);

				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/movie/listAllMovie.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		// 來自update_movie_input.jsp的請求
		if ("update".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
		
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				Integer movno = new Integer(req.getParameter("movno").trim());
				
				String movname = req.getParameter("movname").trim();
	            
				String movnameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{1,30}$";
				if(movname == null || movname.length() == 0) {
					errorMsgs.add("電影名稱: 請勿空白");
				}else if(!movname.trim().matches(movnameReg)) {
					errorMsgs.add("電影名稱: 只能是中、英文字母、數字和_ , 且長度必需在1到30之間");
				}
				
				//多選checkbox
				String[] movverStr = req.getParameterValues("movver");
				System.out.println("movverToken: "+movverStr);
		        String movver = "";
		        if (movverStr.length != 0) {
					movver = appendStr(movverStr);
		        }else {
					errorMsgs.add("電影種類: 請勿空白");
		        }
				
				//單選下拉選單
				String movtype = req.getParameter("movtype");
				
				//多選checkbox
				String[] movlanStr = req.getParameterValues("movlan");
				System.out.println("movlanToken: "+movlanStr);
		        String movlan = "";
		        if (movlanStr.length != 0) {
		        	movlan = appendStr(movlanStr);
		        }else {
					errorMsgs.add("電影類型: 請勿空白");
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
				String movrating = req.getParameter("movrating").trim();
				
				
				String movditor = req.getParameter("movditor").trim();
				if(movditor == null || movditor.length() == 0) {
					errorMsgs.add("導演資料: 請勿空白");
				}
				
				String movcast = req.getParameter("movcast").trim();
				if(movcast == null || movcast.length() == 0) {
					errorMsgs.add("演員資料: 請勿空白");
				}
				
				String movdes = req.getParameter("movdes").trim();
				if(movdes == null || movname.length() == 0) {
					errorMsgs.add("電影簡介: 請勿空白");
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
				
				//??????
                System.out.println("movver="+movver);
                System.out.println("movlan="+movlan);
                
				MovVO movVO = new MovVO();
				movVO.setMovno(movno);
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
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/movie/update_movie_input.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始修改資料*****************************************/
				MovService movSvc = new MovService();
				movVO = movSvc.updateMov(movname, movver, movtype, movlan, movondate, movoffdate, movdurat, movrating, movditor, movcast, movdes, movpos, movtra, movno);
				
				/***************************3.修改完成,準備轉交(Send the Success view)*************/
				req.setAttribute("movVO", movVO);
				String url = "/back-end/movie/listOneMovie.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:"+e.getMessage());

				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/movie/update_movie_input.jsp");
				failureView.forward(req, res);
			}
		}
	} 

	public static String appendStr(String[] str) {
		String resultStr = null;
        StringBuilder strSb = new StringBuilder();
        
        for (int i = 0; i < str.length; i++) {
        	if(i == 0) {
        		strSb = strSb.append(str[i].trim());
        	}else {
        		strSb = strSb.append(","+str[i].trim());
        	}
        	resultStr =  strSb.toString();
        }
		return resultStr;
	}
}
