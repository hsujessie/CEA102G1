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
		
		// �Ӧ�select_page.jsp���ШD
		if("getOne_For_Display".equals(action)) { 
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***************************1.�����ШD�Ѽ�*****************************************/
				String str = req.getParameter("movno");
				Integer movno = null;
				movno = new Integer(str);
				
				/***************************2.�}�l�d�߸��*****************************************/
				MovService movSvc = new MovService();
				MovVO movVO = movSvc.getOneMov(movno);
				if (movVO == null) {
					errorMsgs.add("�d�L���");
				}
				
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/movie/select_page.jsp");
					failureView.forward(req, res);
					return;//�{�����_
				}
				
				/***************************3.�d�ߧ���,�ǳ����(Send the Success view)*************/
				req.setAttribute("movVO", movVO);
				String url = "/back-end/movie/listOneMovie.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
				
			}catch (Exception e) {
				errorMsgs.add("�L�k���o���:" + e.getMessage());
				RequestDispatcher failureVoew = req.getRequestDispatcher("/back-end/movie/select_page.jsp");
				failureVoew.forward(req,res);
			}
		}
		
		// �Ӧ�addMov.jsp���ШD 
		if ("insert".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs",errorMsgs);
			try {
				/***********************1.�����ШD�Ѽ� - ��J�榡�����~�B�z*************************/
				String movname = req.getParameter("movname").trim();
				String movnameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{1,30}$";
				if(movname == null || movname.length() == 0) {
					errorMsgs.add("�q�v�W��: �ФŪť�");
				}else if(!movname.trim().matches(movnameReg)) {
					errorMsgs.add("�q�v�W��: �u��O���B�^��r���B�Ʀr�M_ , �B���ץ��ݦb1��30����");
				}
				
				//�h��checkbox
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
				
				//���U�Կ��
				String movtype = req.getParameter("movtype");
				
				//�h��checkbox
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
					errorMsgs.add("�п�J�W�M���!");
				}
				
				java.sql.Date movoffdate = null;
				try {
					movoffdate = java.sql.Date.valueOf(req.getParameter("movondate").trim());
				} catch (IllegalArgumentException e) {
					movoffdate = new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("�п�J�U�ɤ��!");
				}
				Integer movdurat = null;
				try {
					movdurat = new Integer(req.getParameter("movdurat").trim());
				}catch(NumberFormatException e) {
					movdurat = 0;
					errorMsgs.add("�����ж�Ʀr!");
				}
				
				//���U�Կ��
				String movrating = req.getParameter("movrating");
				
				
				String movditor = req.getParameter("movditor").trim();
				String movditorReg = "^[(\u4e00-\u9fa5)(a-zA-Z)]{1,30}$";
				if(movditor == null || movditor.length() == 0) {
					errorMsgs.add("�ɺt���: �ФŪť�");
				}else if(!movditor.trim().matches(movditorReg)) {
					errorMsgs.add("�ɺt���: �u��O���B�^��r��, �B���ץ��ݦb1��30����");
				}
				
				String movcast = req.getParameter("movcast").trim();
				String movcastReg = "^[(\u4e00-\u9fa5)(a-zA-Z)]{1,100}$";
				if(movcast == null || movcast.length() == 0) {
					errorMsgs.add("�t�����: �ФŪť�");
				}else if(!movcast.trim().matches(movcastReg)) {
					errorMsgs.add("�t�����: �u��O���B�^��r��, �B���ץ��ݦb1��100����");
				}
				
				String movdes = req.getParameter("movdes").trim();
				String movdesReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{1,500}$";
				if(movdes == null || movname.length() == 0) {
					errorMsgs.add("�q�v²��: �ФŪť�");
				}else if(!movdes.trim().matches(movdesReg)) {
					errorMsgs.add("�q�v²��: ���ץ��ݦb500�r�H��");
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
				
				/***************************2.�}�l�s�W���***************************************/
				
				MovService movSvc = new MovService();
				//movSvc.addMov(movname, movver, movtype, movlan, movondate, movoffdate, movdurat, movrating, movditor, movcast, movdes, movpos, movtra);
				System.out.print(movpos);
				System.out.print(movtra);
				movSvc.addMov(movname, movver, movtype, movlan, movondate, movoffdate, movdurat, movrating, movditor, movcast, movdes, movpos, movtra);

				/***************************3.�s�W����,�ǳ����(Send the Success view)***********/
				String url = "/back-end/movie/listAllMovie.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);	
				
				/***************************��L�i�઺���~�B�z**********************************/
			}catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/movie/addMovie.jsp");
				failureView.forward(req, res);
			}
		} 
		
	}
	
}
