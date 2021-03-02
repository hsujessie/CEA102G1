package com.session.controller;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Date;
import java.sql.Timestamp;
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

		
		// �Ӧ�select_page.jsp���ШD
		if("getOne_For_Display".equals(action)) { 
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***************************1.�����ШD�Ѽ�*****************************************/
				Integer sesNo = new Integer(req.getParameter("sesNo"));
				Integer movNo = new Integer(req.getParameter("movNo"));
				
				/***************************2.�}�l�d�߸��*****************************************/
				SesService sesSvc = new SesService();
				SesVO sesVO = sesSvc.getOneSes(sesNo);
				if (sesVO == null) {
					errorMsgs.add("�d�L���");
				}
				
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/session/select_page.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************3.�d�ߧ���,�ǳ����(Send the Success view)*************/
				MovService movSvc = new MovService();
				MovVO movVO = movSvc.getOneMov(movNo);
				req.setAttribute("movVO", movVO);
				
				req.setAttribute("sesVO", sesVO);
				String url = "/back-end/session/listOneSession.jsp";
				
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
				
			}catch (Exception e) {
				errorMsgs.add("�L�k���o���:" + e.getMessage());
				RequestDispatcher failureVoew = req.getRequestDispatcher("/back-end/session/select_page.jsp");
				failureVoew.forward(req,res);
			}
		}
		
		if ("insert".equals(action)) {
			Map<String,String> errorMsgs = new LinkedHashMap<String,String>();
			req.setAttribute("errorMsgs",errorMsgs);
			
			try {
				/***********************1.�����ШD�Ѽ� - ��J�榡�����~�B�z*************************/
				 Integer sesNo = new Integer(req.getParameter("sesNo"));
                 Integer movNo = new Integer(req.getParameter("movNo"));
                 String[] theNoArr = req.getParameterValues("theNo");
                 String[] sestime = req.getParameterValues("sestime");    

                 java.sql.Date sesDateBegin = null;
                 sesDateBegin = java.sql.Date.valueOf(req.getParameter("sesDateBegin").trim());
                 java.sql.Date sesDateEnd = null;
                 sesDateEnd = java.sql.Date.valueOf(req.getParameter("sesDateEnd").trim());
                 java.sql.Date sesDate = null;
                 java.sql.Timestamp sesTime = null;

                 String theNoStr = null;
                 Integer theNo = null;
                 if (theNoArr == null || theNoArr.length == 0) {
                     System.out.println("theNo has errors!");
                 }else {
                     for(int i = 0; i<= theNoArr.length; i++) {
                         theNoStr = theNoArr[i];
                     }
                     theNo = new Integer(theNoStr);
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
				
                SesVO sesVO = new SesVO();
                sesVO.setSesNo(sesNo);
                sesVO.setTheNo(theNo);
                sesVO.setSesDate(sesDate);
                sesVO.setSesTime(sesTime);
                
				/***************************2.�}�l�s�W���***************************************/				
                SesService sesSvc = new SesService();
                sesSvc.addSes(movNo, theNo, sesDate, sesTime, null, null, null); 
                
                
               
				/***************************3.�s�W����,�ǳ����(Send the Success view)***********/				
				String addSuccess = "�i  " + sesNo + " �j" + "�s�W���\";
				req.setAttribute("addSuccess", addSuccess);	
				
				String url = "/back-end/movie/listAllMovie.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);	
				
				/***************************��L�i�઺���~�B�z**********************************/
			}catch (Exception e) {
				errorMsgs.put("Exception",e.getMessage());
				String url = "/back-end/session/select_page.jsp";
				RequestDispatcher failureView = req.getRequestDispatcher(url);
				failureView.forward(req, res);
			}
		} 
		
		
		
	}
}
