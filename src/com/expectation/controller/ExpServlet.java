package com.expectation.controller;

import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.comment.model.ComService;
import com.comment.model.ComVO;
import com.expectation.model.ExpService;
import com.expectation.model.ExpVO;
import com.movie.model.MovService;
import com.movie.model.MovVO;


@MultipartConfig()
public class ExpServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException{
		doPost(req,res);
	}
	
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException{
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		System.out.println("action:"+action);
		

		 // �Ӧ۫e�x movies_subpage.jsp���ШD
		if ("insert".equals(action)) {
			Map<String,String> errorMsgs = new LinkedHashMap<String,String>();
			req.setAttribute("errorMsgs",errorMsgs);
			
			try {
				/***********************1.�����ШD�Ѽ� - ��J�榡�����~�B�z*************************/
				Integer expRating = null;
				expRating = new Integer(req.getParameter("expRating").trim());
				
				Integer movNo = null;
				Integer memNo = null;
				movNo = new Integer(req.getParameter("movNo").trim());
				memNo = new Integer(req.getParameter("memNo").trim());
				
				System.out.println("expRating= " + expRating);
				System.out.println("movNo= " + movNo);
				System.out.println("memNo= " + memNo);
				
				ExpVO expVO = new ExpVO();
				expVO.setExpRating(expRating);
				expVO.setMovNo(movNo);
				expVO.setMemNo(memNo);
				
				/***************************2.�}�l�s�W���***************************************/				
				ExpService expSvc = new ExpService();
				expSvc.addExp(movNo, memNo, expRating);
				
				/***************************3.�s�W����,�ǳ����(Send the Success view)***********/	
				req.setAttribute("expVO", expVO);
				
				MovService movSvc = new MovService();
				MovVO movVO = movSvc.getOneMov(movNo);
				req.setAttribute("movVO", movVO);
				
				ComService comSvc = new ComService();
				ComVO comVO = comSvc.getOneCom(movNo);
				req.setAttribute("comVO", comVO);
				
				String url = "/front-end/movies/movies_subpage.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);	
				
				/***************************��L�i�઺���~�B�z**********************************/
			}catch (Exception e) {
				errorMsgs.put("Exception",e.getMessage());
				String url = "/front-end/movies/movies_subpage.jsp";
				RequestDispatcher failureView = req.getRequestDispatcher(url);
				failureView.forward(req, res);
			}
		} 
		
		
	}
}
