package com.session.controller;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Date;
import java.sql.Timestamp;
import java.time.format.DateTimeFormatter;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.movie.model.MovService;
import com.movie.model.MovVO;
import com.session.model.SesService;
import com.session.model.SesVO;


@MultipartConfig()
public class SesServlet extends HttpServlet {
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
				Integer sesNo = new Integer(req.getParameter("sesNo"));
				Integer movNo = new Integer(req.getParameter("movNo"));
				
				/***************************2.開始查詢資料*****************************************/
				SesService sesSvc = new SesService();
				SesVO sesVO = sesSvc.getOneSes(sesNo);
				if (sesVO == null) {
					errorMsgs.add("查無資料");
				}
				
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/session/select_page.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				MovService movSvc = new MovService();
				MovVO movVO = movSvc.getOneMov(movNo);
				req.setAttribute("movVO", movVO);
				
				req.setAttribute("sesVO", sesVO);
				String url = "/back-end/session/listOneSession.jsp";
				
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
				
			}catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureVoew = req.getRequestDispatcher("/back-end/session/select_page.jsp");
				failureVoew.forward(req,res);
			}
		}
		
		if ("insert".equals(action)) {
            Map<String,String> errorMsgs = new LinkedHashMap<String,String>();
            req.setAttribute("errorMsgs",errorMsgs);
            
//            try {
                /***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
                 Integer movNo = new Integer(req.getParameter("movNo"));
                 String[] theNoArr = req.getParameterValues("theNo");

               java.sql.Date sesDate = null;
               java.sql.Date sesDateBegin = null;
               sesDateBegin = java.sql.Date.valueOf(req.getParameter("sesDateBegin").trim());
               java.sql.Date sesDateEnd = null;
               sesDateEnd = java.sql.Date.valueOf(req.getParameter("sesDateEnd").trim());
               java.time.LocalTime sesTime = null;
               sesTime = java.time.LocalTime.parse(req.getParameter("sesTime"));
               System.out.println("sesTime= " + sesTime);

               System.out.println("movNo= " + movNo);
               System.out.println("sesDateBegin= " + sesDateBegin);
               System.out.println("sesDateEnd= " + sesDateEnd);
               
               String theNoStr = null;
               Integer theNo = null;
               if (theNoArr == null || theNoArr.length == 0) {
                   System.out.println("theNo has errors!");
               }else {
                   for(int i = 0; i< theNoArr.length; i++) {
                       System.out.println("thenoArr= " + theNoArr[i]);
                       theNoStr = theNoArr[i];
                       
                       theNo = new Integer(theNoStr);
                       System.out.println("theNo= " + theNo);
                   }
               }

//	             String[] sesTimeArr = req.getParameterValues("sesTime");
//               String sesTimeStr = null;
//               if (sesTimeArr == null || sesTimeArr.length == 0) {
//                   System.out.println("sesTime has errors!");
//               }else {
//                   for(int i = 0; i<= sesTimeArr.length; i++) {
//                       System.out.println("sesTimeArr= " + sesTimeArr[i]);
//                       sesTimeStr = sesTimeArr[i];
//                   }
//                   sesTime = java.sql.Timestamp.valueOf(sesTimeStr);
//                   System.out.println("sesTime= " + sesTime);
//               }
//
//               
//              // Send the use back to the form, if there were errors
//              if (!errorMsgs.isEmpty()) {
//                  Boolean openAddLightbox = true;
//                  req.setAttribute("openAddLightbox", openAddLightbox);
//                  String url = "/back-end/session/select_page.jsp";
//                  RequestDispatcher failureView = req.getRequestDispatcher(url);
//                  failureView.forward(req, res);
//                  return;
//              }
//              
//              SesVO sesVO = new SesVO();
//              sesVO.setTheNo(theNo);
//              sesVO.setSesDate(sesDate);
//              sesVO.setSesTime(sesTime);
              
               /***************************2.開始新增資料***************************************/                
//              SesService sesSvc = new SesService();
//              sesSvc.addSes(movNo, theNo, sesDate, sesTime, null, null, null); 
              
              
             
               /***************************3.新增完成,準備轉交(Send the Success view)***********/                
//              String addSuccess = "【 場次 " + sesNo + " 】" + "新增成功";
//              req.setAttribute("addSuccess", addSuccess);    
//              
//              String url = "/back-end/movie/listAllMovie.jsp";
//              RequestDispatcher successView = req.getRequestDispatcher(url);
//              successView.forward(req, res);    
               
               /***************************其他可能的錯誤處理**********************************/
//			}catch (Exception e) {
//	            errorMsgs.put("Exception",e.getMessage());
//	            String url = "/back-end/session/select_page.jsp";
//	            RequestDispatcher failureView = req.getRequestDispatcher(url);
//	            failureView.forward(req, res);
//	        }		
		}
		
		// 來自listAllSession.jsp的請求
		if ("getOne_For_Update".equals(action)) {
			Map<String,String> errorMsgs = new LinkedHashMap<String,String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			String requestURL = req.getParameter("requestURL");
		
		
			try {
				/***************************1.接收請求參數****************************************/
				Integer sesNo = new Integer(req.getParameter("sesNo").trim());
				Integer movNo = new Integer(req.getParameter("movNo").trim());
				
				/***************************2.開始查詢資料****************************************/
				SesService sesSvc = new SesService();
				SesVO sesVO = sesSvc.getOneSes(sesNo);
				MovService movSvc = new MovService();
				MovVO movVO = movSvc.getOneMov(movNo);
								
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				String url = requestURL;
	            if(requestURL.equals("/back-end/session/listSessions_ByCompositeQuery.jsp")){
					HttpSession session = req.getSession();
					Map<String, String[]> map = (Map<String, String[]>)session.getAttribute("map");
					List<MovVO> list  = movSvc.getAll(map);
					req.setAttribute("listSessions_ByCompositeQuery",list); //  複合查詢, 資料庫取出的list物件,存入
					url = "/back-end/session/update_session_input.jsp";
				}
	            

	            req.setAttribute("sesVO", sesVO);  
	            req.setAttribute("movVO", movVO);  
	
				Boolean openUpdateLightbox = true;
				req.setAttribute("openUpdateLightbox", openUpdateLightbox);
	
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
	
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.put("Exception"," 無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher(requestURL);
				failureView.forward(req, res);
			}
		}
		
		// 來自update_session_input.jsp的請求
		if ("update".equals(action)) {
			Map<String,String> errorMsgs = new LinkedHashMap<String,String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			String requestURL = req.getParameter("requestURL");
			
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				Integer sesNo = new Integer(req.getParameter("sesNo").trim());
				Integer movNo = new Integer(req.getParameter("movNo").trim());
				Integer theNo = new Integer(req.getParameter("theNo").trim());
				java.sql.Date sesDate = null;
				
				SesVO sesVO = new SesVO();
                sesVO.setSesNo(sesNo);
                sesVO.setTheNo(theNo);
                sesVO.setSesDate(sesDate);
//                sesVO.setSesTime(sesTime);
				
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("sesVO", sesVO);       
					
					RequestDispatcher failureView = req.getRequestDispatcher(requestURL);
					failureView.forward(req, res);
					return;
				}
				/***************************2.開始修改資料*****************************************/
				SesService sesSvc = new SesService();
//				sesVO = sesSvc.updateSes(movNo, theNo, sesDate, sesTime, null, sesNo);
				
				/***************************3.修改完成,準備轉交(Send the Success view)*************/	
				if(requestURL.equals("/back-end/session/listSessions_ByCompositeQuery.jsp")){
					HttpSession session = req.getSession();
					Map<String, String[]> map = (Map<String, String[]>)session.getAttribute("map");
//					List<sesVO> list  = sesSvc.getAll(map);
//					req.setAttribute("listSessions_ByCompositeQuery",list); //  複合查詢, 資料庫取出的list物件,存入
				}
				String url = requestURL;

				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			}catch (Exception e) {
				errorMsgs.put("Exception","修改資料失敗:"+e.getMessage());
				Boolean openUpdateLightbox = true;
				req.setAttribute("openUpdateLightbox", openUpdateLightbox);
				
				RequestDispatcher failureView = req.getRequestDispatcher(requestURL);
				failureView.forward(req, res);
			}
			
			
		}
		
		
		
		
	}
}
