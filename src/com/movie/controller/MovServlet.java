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
		
		// �Ӧ�listAllMovie.jsp���ШD - for displaying pictures
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
				
		// �Ӧ�addMovie.jsp���ШD 
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
		        String movver = "";
		        if (movverStr.length != 0) {
					movver = appendStr(movverStr);
		        }else {
					errorMsgs.add("�q�v����: �ФŪť�");
		        }
				
				//���U�Կ��
				String movtype = req.getParameter("movtype");

				//�h��checkbox
				String[] movlanStr = req.getParameterValues("movlan");	
		        String movlan = "";
		        if (movlanStr.length != 0) {
		        	movlan = appendStr(movlanStr);
		        }else {
					errorMsgs.add("�q�v����: �ФŪť�");
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
				String movrating = req.getParameter("movrating").trim();
				
				
				String movditor = req.getParameter("movditor").trim();
				if(movditor == null || movditor.length() == 0) {
					errorMsgs.add("�ɺt���: �ФŪť�");
				}
				
				String movcast = req.getParameter("movcast").trim();
				if(movcast == null || movcast.length() == 0) {
					errorMsgs.add("�t�����: �ФŪť�");
				}
				
				String movdes = req.getParameter("movdes").trim();
				if(movdes == null || movname.length() == 0) {
					errorMsgs.add("�q�v²��: �ФŪť�");
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
				
				/***************************2.�}�l�s�W���***************************************/
				
				MovService movSvc = new MovService();
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
		
		 // �Ӧ�listAllMovie.jsp���ШD
		if ("getOne_For_Update".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***************************1.�����ШD�Ѽ�****************************************/
				Integer movno = new Integer(req.getParameter("movno").trim());
				
				/***************************2.�}�l�d�߸��****************************************/
				MovService movSvc = new MovService();
				MovVO movVO = movSvc.getOneMov(movno);

				
				//??? �ګܦ��ơA��s�ɡA�|��쥻���Ȥ]�s�i�h�A�̲����C-> �q�v����2D,3D,3D 
				//��split�q�v�����r��A�A��Ȱe��update_movie_input.jsp
				String movverStrs = movVO.getMovver();
				String[] movverToken = movverStrs.split(",");
				
				//��split�q�v�y���r��A�A��Ȱe��update_movie_input.jsp
				String movlanStrs = movVO.getMovlan();
				String[] movlanToken = movlanStrs.split(",");
				
				
				/***************************3.�d�ߧ���,�ǳ����(Send the Success view)************/
				req.setAttribute("movVO", movVO); 
				req.setAttribute("movverToken", movverToken);    
				req.setAttribute("movlanToken", movlanToken);         
				
				String url = "/back-end/movie/update_movie_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);

				/***************************��L�i�઺���~�B�z**********************************/
			} catch (Exception e) {
				errorMsgs.add("�L�k���o�n�ק諸���:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/movie/listAllMovie.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		// �Ӧ�update_movie_input.jsp���ШD
		if ("update".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
		
			try {
				/***************************1.�����ШD�Ѽ� - ��J�榡�����~�B�z**********************/
				Integer movno = new Integer(req.getParameter("movno").trim());
				
				String movname = req.getParameter("movname").trim();
	            
				String movnameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{1,30}$";
				if(movname == null || movname.length() == 0) {
					errorMsgs.add("�q�v�W��: �ФŪť�");
				}else if(!movname.trim().matches(movnameReg)) {
					errorMsgs.add("�q�v�W��: �u��O���B�^��r���B�Ʀr�M_ , �B���ץ��ݦb1��30����");
				}
				
				//�h��checkbox
				String[] movverStr = req.getParameterValues("movver");
				System.out.println("movverToken: "+movverStr);
		        String movver = "";
		        if (movverStr.length != 0) {
					movver = appendStr(movverStr);
		        }else {
					errorMsgs.add("�q�v����: �ФŪť�");
		        }
				
				//���U�Կ��
				String movtype = req.getParameter("movtype");
				
				//�h��checkbox
				String[] movlanStr = req.getParameterValues("movlan");
				System.out.println("movlanToken: "+movlanStr);
		        String movlan = "";
		        if (movlanStr.length != 0) {
		        	movlan = appendStr(movlanStr);
		        }else {
					errorMsgs.add("�q�v����: �ФŪť�");
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
				String movrating = req.getParameter("movrating").trim();
				
				
				String movditor = req.getParameter("movditor").trim();
				if(movditor == null || movditor.length() == 0) {
					errorMsgs.add("�ɺt���: �ФŪť�");
				}
				
				String movcast = req.getParameter("movcast").trim();
				if(movcast == null || movcast.length() == 0) {
					errorMsgs.add("�t�����: �ФŪť�");
				}
				
				String movdes = req.getParameter("movdes").trim();
				if(movdes == null || movname.length() == 0) {
					errorMsgs.add("�q�v²��: �ФŪť�");
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
				
				/***************************2.�}�l�ק���*****************************************/
				MovService movSvc = new MovService();
				movVO = movSvc.updateMov(movname, movver, movtype, movlan, movondate, movoffdate, movdurat, movrating, movditor, movcast, movdes, movpos, movtra, movno);
				
				/***************************3.�ק粒��,�ǳ����(Send the Success view)*************/
				req.setAttribute("movVO", movVO);
				String url = "/back-end/movie/listOneMovie.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);

				/***************************��L�i�઺���~�B�z*************************************/
			} catch (Exception e) {
				errorMsgs.add("�ק��ƥ���:"+e.getMessage());

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
