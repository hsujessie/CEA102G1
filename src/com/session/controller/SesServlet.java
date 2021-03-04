package com.session.controller;

import java.io.IOException;
import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.LinkedHashMap;
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

		// 來自select_page.jsp的請求---複合查詢
		if("listSessions_ByCompositeQuery".equals(action)) {
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
			SesService sesSvc = new SesService();
			List<SesVO> list  = sesSvc.getAll(map);
			
			/***************************3.查詢完成,準備轉交(Send the Success view)************/
			req.setAttribute("listSessions_ByCompositeQuery", list); // 資料庫取出的list物件,存入request
			RequestDispatcher successView = req.getRequestDispatcher("/back-end/session/listSessions_ByCompositeQuery.jsp"); // 成功轉交listSessions_ByCompositeQuery.jsp
			successView.forward(req, res);
			
			/***************************其他可能的錯誤處理**********************************/
			}catch(Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/session/select_page.jsp");
				failureView.forward(req, res);
			}
		}
	
	
		if ("insert".equals(action)) {
            Map<String,String> errorMsgs = new LinkedHashMap<String,String>();
            req.setAttribute("errorMsgs",errorMsgs);

            SesVO sesVO = new SesVO();
            try {
                /***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
                 Integer movNo = new Integer(req.getParameter("movNo"));
                 System.out.println("movNo= " + movNo);
                 
                 String[] theNoArr = req.getParameterValues("theNo");
                 Integer theNo = null;
                 if (theNoArr == null || theNoArr.length == 0) {
                     System.out.println("theNo is empty!");
                 }else {
                     for(int i = 0; i < theNoArr.length; i++) {                       
                         theNo = new Integer(theNoArr[i]);
                         System.out.println("theNo= " + theNo);  
                         sesVO.setTheNo(theNo);
                     }
                 }
                 
                 String sesDateBegin = req.getParameter("sesDateBegin").trim();
	             String sesDateEnd = req.getParameter("sesDateEnd").trim();            
	             List<String> sesDateList = null;
	             java.sql.Date sesDate = null;
	             try {
	            	 sesDateList = getDates(sesDateBegin,sesDateEnd);
	             } catch (ParseException e) {
					e.printStackTrace();
	             }
	             String[] sesDateArr = new String[sesDateList.size()];
	             sesDateArr = sesDateList.toArray(sesDateArr);
	             
           
	             Time sesTime = null;              
	             String[] sesTimeArr = req.getParameterValues("sesTime");
	             if (sesTimeArr == null || sesTimeArr.length == 0) {
                   System.out.println("sesTime is empty!");
	             }else {
                   for(int j = 0; j < sesTimeArr.length; j++) {
                     sesTime = Time.valueOf(java.time.LocalTime.parse(sesTimeArr[j]));  
                     System.out.println("sesTime= " + sesTime);
                   }
	             }
             
	             // Send the use back to the form, if there were errors
	             if (!errorMsgs.isEmpty()) {
					  Boolean openAddLightbox = true;
					  req.setAttribute("openAddLightbox", openAddLightbox);
					  String url = "/back-end/session/select_page.jsp";
					  RequestDispatcher failureView = req.getRequestDispatcher(url);
					  failureView.forward(req, res);
					  return;
	             }
              
            

               for(int i = 0; i < sesDateArr.length; i++) { 
                   for(int j = 0; j < sesTimeArr.length; j++) {
  	                 sesDate = Date.valueOf(sesDateArr[i]); 
                     sesTime = Time.valueOf(java.time.LocalTime.parse(sesTimeArr[j])); 

                     sesVO.setSesDate(sesDate);
                     sesVO.setSesTime(sesTime);      
                   }
               }

               
               /***************************2.開始新增資料***************************************/                
	              SesService sesSvc = new SesService();
	              sesSvc.addSes(movNo, theNo, sesDate, sesTime, null, null, 0); 
//	              sesSvc.addSes(movNo, theNo, sesDate, sesTime, null, null, null); 
              
              
             
               /***************************3.新增完成,準備轉交(Send the Success view)***********/                
              String addSuccess = "【 場次 】" + "新增成功";
              req.setAttribute("addSuccess", addSuccess);    
              
              String url = "/back-end/session/listAllSession.jsp";
              RequestDispatcher successView = req.getRequestDispatcher(url);
              successView.forward(req, res);    
               
               /***************************其他可能的錯誤處理**********************************/
			}catch (Exception e) {
	            errorMsgs.put("Exception",e.getMessage());
	            String url = "/back-end/session/select_page.jsp";
	            RequestDispatcher failureView = req.getRequestDispatcher(url);
	            failureView.forward(req, res);
	        }		
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
					List<SesVO> list  = sesSvc.getAll(map);
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
//				java.time.LocalTime sesTime = null;
				
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
	
	public List<String> getDates(String dateBegin, String dateEnd) throws ParseException, java.text.ParseException {
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
 
        // parse String dateBegin to Date
        Calendar calBegin = Calendar.getInstance();
        calBegin.setTime(format.parse(dateBegin));
 
        // parse String dateEnd to Date
        Calendar calEnd = Calendar.getInstance();
        calEnd.setTime(format.parse(dateEnd));
        
        List<String> Datelist = new ArrayList<String>();
        Datelist.add(format.format(calBegin.getTime()));
        
        // whether dateEnd is after calBegin
        // if it's true -> calBegin will be plus a day via using「 Calendar.DAY_OF_MONTH 」
        while (format.parse(dateEnd).after(calBegin.getTime()))  {
            calBegin.add(Calendar.DAY_OF_MONTH, 1);   // DAY_OF_MONTH 取出當前月的第幾天
            Datelist.add(format.format(calBegin.getTime()));
        }
        return Datelist;
    }
	
	public List<String> getTimes(String times) {
        List<String> TimeList = new ArrayList<String>();
        TimeList.add(times);
		return TimeList;
	}

}
