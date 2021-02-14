package com.movie.controller;

import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
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
				Integer movno = new Integer(req.getParameter("movno"));
				
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
					return;
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
		if ("get_One_MovPos".equals(action)) {
			res.setContentType("img/jpg");
			Integer movno = new Integer(req.getParameter("movno").trim());
			MovService movSvc = new MovService();
			MovVO movVO = movSvc.getOneMov(movno);
			byte[] movpos = movVO.getMovpos();
			
			if(movpos!=null) {
				res.getOutputStream().write(movpos);
				res.getOutputStream().flush();
				return;
			}
		}
		// 來自listAllMovie.jsp的請求 - for displaying trailers
		if ("get_One_MovTra".equals(action)) {
			res.setContentType("video/mp4");
			Integer movno = new Integer(req.getParameter("movno").trim());
			MovService movSvc = new MovService();
			MovVO movVO = movSvc.getOneMov(movno);
			byte[] movtra = movVO.getMovtra();
			
			if(movtra!=null) {
				res.getOutputStream().write(movtra);
				res.getOutputStream().flush();
				return;
			}				
		}
				
		// 來自addMovie.jsp的請求 
		if ("insert".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs",errorMsgs);
			
			try {
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
				String movname = req.getParameter("movname").trim();
				if(movname == null || movname.length() == 0) {
					errorMsgs.add("電影名稱: 請勿空白");
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
				if(movdes == null || movdes.length() == 0) {
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
			
			String requestURL = req.getParameter("requestURL");
			System.out.println("getOne_For_Update requestURL= " + requestURL);
			
			try {
				/***************************1.接收請求參數****************************************/
				Integer movno = new Integer(req.getParameter("movno").trim());
				
				/***************************2.開始查詢資料****************************************/
				MovService movSvc = new MovService();
				MovVO movVO = movSvc.getOneMov(movno);
			
				//先split電影種類字串，再把值送到update_movie_input.jsp
				String movverStrs = movVO.getMovver();
				String[] movverToken = {"2D"};
				if(movverStrs != null) {
					movverToken = movverStrs.split(",");
				}
				
				
				//先split電影語言字串，再把值送到update_movie_input.jsp
				String movlanStrs = movVO.getMovlan();
				String[] movlanToken = {""};
				if(movlanStrs != null) {
					movlanToken = movlanStrs.split(",");
				}
								
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
				RequestDispatcher failureView = req.getRequestDispatcher(requestURL);
				failureView.forward(req, res);
			}
		}
		
		
		// 來自update_movie_input.jsp的請求
		if ("update".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			String requestURL = req.getParameter("requestURL");
			System.out.println("update requestURL= " + requestURL);
			
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				Integer movno = new Integer(req.getParameter("movno").trim());
				
				String movname = req.getParameter("movname").trim();            
				if(movname == null || movname.length() == 0) {
					errorMsgs.add("電影名稱: 請勿空白");
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
				if(movdes == null || movdes.length() == 0) {
					errorMsgs.add("電影簡介: 請勿空白");
				}
											
				MovService movSvc = new MovService();
				MovVO movVO = movSvc.getOneMov(movno);
				
				Part movposPart = req.getPart("movpos");	
				byte[] movpos = movVO.getMovpos();
				System.out.println("~enter else movpos~ " + movpos);
				if(movposPart.getContentType() != null && movposPart.getContentType().indexOf("image") >= 0) {	
				//if(movposPart != null) {	//這樣判斷是不對的，因為即便沒東西，會回傳這個 application/octet-stream	 			
					
					InputStream movposis = movposPart.getInputStream();
					movpos = new byte[movposis.available()];
					movposis.read(movpos);
					movposis.close();
					
					movSvc.updateMovpos(movpos, movno);
				}

				Part movtraPart = req.getPart("movtra");
				byte[] movtra = movVO.getMovtra();
				System.out.println("~enter else movtra~ " + movtra);
				if(movtraPart.getContentType() != null && movtraPart.getContentType().indexOf("video") >= 0) {				
					InputStream movtrais = movtraPart.getInputStream();
					movtra = new byte[movtrais.available()];
					movtrais.read(movtra);
					movtrais.close();				
					
					movSvc.updateMovtra(movtra, movno);
				}

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

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("movVO", movVO);             
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/movie/update_movie_input.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始修改資料*****************************************/
				movVO = movSvc.updateMov(movname, movver, movtype, movlan, movondate, movoffdate, movdurat, movrating, movditor, movcast, movdes, movno);
				
				/***************************3.修改完成,準備轉交(Send the Success view)*************/
				//修改我  ///back-end/movie/listMovies_ByCompositeQuery.jsp
//				req.setAttribute("movVO", movVO);
//				String url = "/back-end/movie/listOneMovie.jsp";
				if(requestURL.equals("/back-end/movie/listMovies_ByCompositeQuery.jsp")){
					HttpSession session = req.getSession();
					Map<String, String[]> map = (Map<String, String[]>)session.getAttribute("map");
					List<MovVO> list  = movSvc.getAll(map);
					req.setAttribute("listMovies_ByCompositeQuery",list); //  複合查詢, 資料庫取出的list物件,存入request
				}
				String url = requestURL;
				
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:"+e.getMessage());

				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/movie/update_movie_input.jsp");
				failureView.forward(req, res);
			}
		}

		// 來自select_page.jsp的請求---複合查詢
		if("listMovies_ByCompositeQuery".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				HttpSession session = req.getSession();
				Map<String, String[]> map = (Map<String,String[]>)session.getAttribute("map");
				
				if(req.getParameter("whichPage") == null) {
					HashMap<String, String[]> map1 = new HashMap<String, String[]>(req.getParameterMap());
					
					session.setAttribute("map",map1);
					map = map1;
				}
				System.out.println("map.size()= " + map.size());

			/***************************2.開始複合查詢***************************************/
			MovService movSvc = new MovService();
			List<MovVO> list  = movSvc.getAll(map);
			
			/***************************3.查詢完成,準備轉交(Send the Success view)************/
			req.setAttribute("listMovies_ByCompositeQuery", list); // 資料庫取出的list物件,存入request
			RequestDispatcher successView = req.getRequestDispatcher("/back-end/movie/listMovies_ByCompositeQuery.jsp"); // 成功轉交listEmps_ByCompositeQuery.jsp
			successView.forward(req, res);
			
			/***************************其他可能的錯誤處理**********************************/
			}catch(Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/movie/select_page.jsp");
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
