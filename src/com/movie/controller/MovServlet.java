package com.movie.controller;

import java.io.IOException;
import java.io.InputStream;
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
				Integer movno = new Integer(req.getParameter("movno"));
				
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
					return;
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
		// �Ӧ�listAllMovie.jsp���ШD - for displaying trailers
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
				
		// �Ӧ�addMovie.jsp���ШD 
		if ("insert".equals(action)) {
			Map<String,String> errorMsgs = new LinkedHashMap<String,String>();
			req.setAttribute("errorMsgs",errorMsgs);
			
			try {
				/***********************1.�����ШD�Ѽ� - ��J�榡�����~�B�z*************************/
				String movname = req.getParameter("movname").trim();
				if(movname == null || movname.length() == 0) {
					errorMsgs.put("movname"," �q�v�W�� �ФŪť�");
				}
				
				//�h��checkbox
				String[] movverStr = req.getParameterValues("movver");	
		        String movver = "";
		        if (movverStr == null || movverStr.length == 0) {
					errorMsgs.put("movver"," �п�ܹq�v����");
		        }else {
					movver = appendStr(movverStr);
		        }
				
				//���U�Կ��
				String movtype = req.getParameter("movtype");
				if(movtype == null || movtype.trim().length() == 0) {
					errorMsgs.put("movtype"," �п�ܹq�v����");
				}

				//�h��checkbox
				String[] movlanStr = req.getParameterValues("movlan");	
		        String movlan = "";
		        if (movlanStr == null || movlanStr.length == 0) {
					errorMsgs.put("movlan"," �п�ܹq�v�y��");
		        }else {
		        	movlan = appendStr(movlanStr);
		        }					
		        
				java.sql.Date movondate = null;
				try {
					movondate = java.sql.Date.valueOf(req.getParameter("movondate").trim());
				} catch (IllegalArgumentException e) {
					movondate = new java.sql.Date(System.currentTimeMillis());
					errorMsgs.put("movondate"," �п�J�W�M���!");
				}

				java.sql.Date movoffdate = null;
				try {
					movoffdate = java.sql.Date.valueOf(req.getParameter("movondate").trim());
					
				} catch (IllegalArgumentException e) {
					movoffdate = new java.sql.Date(System.currentTimeMillis());
					errorMsgs.put("movoffdate"," �п�J�U�ɤ��!");
				}	
				
				Integer movdurat = null;
				try {
					movdurat = new Integer(req.getParameter("movdurat").trim());
				}catch(NumberFormatException e) {
					movdurat = 0;
					errorMsgs.put("movdurat"," �����ж�Ʀr!");
				}
				
				//���U�Կ��
				String movrating = req.getParameter("movrating").trim();
				
				
				String movditor = req.getParameter("movditor").trim();
				if(movditor == null || movditor.length() == 0) {
					errorMsgs.put("movditor"," �ɺt��� �ФŪť�");
				}
				
				String movcast = req.getParameter("movcast").trim();
				if(movcast == null || movcast.length() == 0) {
					errorMsgs.put("movcast"," �t����� �ФŪť�");
				}
				
				String movdes = req.getParameter("movdes").trim();
				if(movdes == null || movdes.equals("")) {
					errorMsgs.put("movdes"," �q�v²�� �ФŪť�");
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
					Boolean openAddLightbox = true;
					req.setAttribute("openAddLightbox", openAddLightbox);
					String url = "/back-end/movie/select_page.jsp";
					RequestDispatcher failureView = req.getRequestDispatcher(url);
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.�}�l�s�W���***************************************/				
				MovService movSvc = new MovService();
				movSvc.addMov(movname, movver, movtype, movlan, movondate, movoffdate, movdurat, movrating, movditor, movcast, movdes, movpos, movtra);
					
				/***************************3.�s�W����,�ǳ����(Send the Success view)***********/				
				String addSuccess = "�i  " + movname + " �j" + "�s�W���\";
				req.setAttribute("addSuccess", addSuccess);	
				
				String url = "/back-end/movie/listAllMovie.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);	
				
				/***************************��L�i�઺���~�B�z**********************************/
			}catch (Exception e) {
				errorMsgs.put("Exception",e.getMessage());
				Boolean openAddLightbox = true;
				req.setAttribute("openAddLightbox", openAddLightbox);
				String url = "/back-end/movie/select_page.jsp";
				RequestDispatcher failureView = req.getRequestDispatcher(url);
				failureView.forward(req, res);
			}
		} 
		
		 // �Ӧ�listAllMovie.jsp���ШD
		if ("getOne_For_Update".equals(action)) {
			Map<String,String> errorMsgs = new LinkedHashMap<String,String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			String requestURL = req.getParameter("requestURL");
			
			try {
				/***************************1.�����ШD�Ѽ�****************************************/
				Integer movno = new Integer(req.getParameter("movno").trim());
				
				/***************************2.�}�l�d�߸��****************************************/
				MovService movSvc = new MovService();
				MovVO movVO = movSvc.getOneMov(movno);
			
				//��split�q�v�����r��A�A��Ȱe��update_movie_input.jsp
				String movverStrs = movVO.getMovver();
	            String[] movverToken = null;
	            movverToken = token(movverStrs, movverToken);
								
				//��split�q�v�y���r��A�A��Ȱe��update_movie_input.jsp
				String movlanStrs = movVO.getMovlan();
	            String[] movlanToken = null;
	            movlanToken = token(movlanStrs, movlanToken);
								
				/***************************3.�d�ߧ���,�ǳ����(Send the Success view)************/
	            if(requestURL.equals("/back-end/movie/listMovies_ByCompositeQuery.jsp")){
					HttpSession session = req.getSession();
					Map<String, String[]> map = (Map<String, String[]>)session.getAttribute("map");
					List<MovVO> list  = movSvc.getAll(map);
					req.setAttribute("listMovies_ByCompositeQuery",list); //  �ƦX�d��, ��Ʈw���X��list����,�s�J
				}
	            
	            req.setAttribute("movVO", movVO);  
				req.setAttribute("movverToken", movverToken);    
				req.setAttribute("movlanToken", movlanToken);

				Boolean openUpdateLightbox = true;
				req.setAttribute("openUpdateLightbox", openUpdateLightbox);

				String url = requestURL;
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);

				/***************************��L�i�઺���~�B�z**********************************/
			} catch (Exception e) {
				errorMsgs.put("Exception"," �L�k���o�n�ק諸���:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher(requestURL);
				failureView.forward(req, res);
			}
		}
		
		
		// �Ӧ�update_movie_input.jsp���ШD
		if ("update".equals(action)) {
			Map<String,String> errorMsgs = new LinkedHashMap<String,String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			String requestURL = req.getParameter("requestURL");
			
			try {
				/***************************1.�����ШD�Ѽ� - ��J�榡�����~�B�z**********************/
				Integer movno = new Integer(req.getParameter("movno").trim());

				MovService movSvc = new MovService();
				MovVO movVO = movSvc.getOneMov(movno);
				
				//��split�r��A�A��Ȱe��update_movie_input.jsp
				String movverStrs = movVO.getMovver();
				String[] movverToken = null;
				String movlanStrs = movVO.getMovlan();
		        String[] movlanToken = null;

				//�h��checkbox
				String[] movverStr = req.getParameterValues("movver");
		        String movver = "";
		        //�h��checkbox
				String[] movlanStr = req.getParameterValues("movlan");
		        String movlan = "";
		        if (movverStr == null || movverStr.length == 0) {
					errorMsgs.put("movver"," �п�ܹq�v����");

					//��split�r��A�A��Ȱe��update_movie_input.jsp
					//�Y�S���AsetToken�Ajsp�|�줣��movverToken��movlanToken�A�|�L�k�O�d��l�Q�Ŀ窱�A�C
			        if (movverStr != null) {  
						movverToken = token(movverStrs, movverToken);
						req.setAttribute("movverToken", movverToken);	
					}
					if (movlanStr != null ) {
						movlanToken = token(movlanStrs, movlanToken);	  
						req.setAttribute("movlanToken", movlanToken); 	
					}
		        }else {
					movver = appendStr(movverStr);
		        }
		        
		        if (movlanStr == null || movlanStr.length == 0) {
					errorMsgs.put("movlan"," �п�ܹq�v�y��"); 

					//��split�r��A�A��Ȱe��update_movie_input.jsp
			        if (movverStr != null) {  
						movverToken = token(movverStrs, movverToken);
						req.setAttribute("movverToken", movverToken);	
					}
					if (movlanStr != null ) {
						movlanToken = token(movlanStrs, movlanToken);	  
						req.setAttribute("movlanToken", movlanToken); 	
					} 
		        }else {
		        	movlan = appendStr(movlanStr);
		        }				

		        
				String movname = req.getParameter("movname").trim();   
				if(movname == null || movname.length() == 0) {
					errorMsgs.put("movname"," �q�v�W�� �ФŪť�");
					
					//��split�r��A�A��Ȱe��update_movie_input.jsp 
			        if (movverStr != null) {  
						movverToken = token(movverStrs, movverToken);
						req.setAttribute("movverToken", movverToken);	
					}
					if (movlanStr != null ) {
						movlanToken = token(movlanStrs, movlanToken);	  
						req.setAttribute("movlanToken", movlanToken); 	
					}
				}				
				
				//���U�Կ��
				String movtype = req.getParameter("movtype");

				java.sql.Date movondate = null;
				try {
					movondate = java.sql.Date.valueOf(req.getParameter("movondate").trim());
				} catch (IllegalArgumentException e) {
					errorMsgs.put("movondate"," �п�J�W�M���!");
					
					//��split�r��A�A��Ȱe��update_movie_input.jsp
			        if (movverStr != null) {  
						movverToken = token(movverStrs, movverToken);
						req.setAttribute("movverToken", movverToken);	
					}
					if (movlanStr != null ) {
						movlanToken = token(movlanStrs, movlanToken);	  
						req.setAttribute("movlanToken", movlanToken); 	
					}
				}

				java.sql.Date movoffdate = null;
				try {
					movoffdate = java.sql.Date.valueOf(req.getParameter("movoffdate").trim());
				} catch (IllegalArgumentException e) {
					errorMsgs.put("movoffdate"," �п�J�U�ɤ��!");
					
					//��split�r��A�A��Ȱe��update_movie_input.jsp
			        if (movverStr != null) {  
						movverToken = token(movverStrs, movverToken);
						req.setAttribute("movverToken", movverToken);	
					}
					if (movlanStr != null ) {
						movlanToken = token(movlanStrs, movlanToken);	  
						req.setAttribute("movlanToken", movlanToken); 	
					}
				}

                /* �H�U�����D�A�̲��A�Ѷ}���ѡA�e�x�N�줣���??? */
//				if (movondate.getTime() == movoffdate.getTime()) {
//					errorMsgs.put("movondate","��������T�A�Э��s��J!		* ��:1.�W�M����P�U�ɤ�����i�۵��B2.�W�M������i��U�ɤ������B3.�U�ɤ�����i��W�M������e");
//
//					//��split�r��A�A��Ȱe��update_movie_input.jsp
//			        if (movverStr != null) {  
//						movverToken = token(movverStrs, movverToken);
//						req.setAttribute("movverToken", movverToken);	
//					}
//					if (movlanStr != null ) {
//						movlanToken = token(movlanStrs, movlanToken);	  
//						req.setAttribute("movlanToken", movlanToken); 	
//					} 
//				}

				Integer movdurat = null;
				try {
					movdurat = new Integer(req.getParameter("movdurat").trim());
				}catch(NumberFormatException e) {
					movdurat = 0;
					errorMsgs.put("movdurat"," �����ж�Ʀr!");
					
					//��split�r��A�A��Ȱe��update_movie_input.jsp
			        if (movverStr != null) {  
						movverToken = token(movverStrs, movverToken);
						req.setAttribute("movverToken", movverToken);	
					}
					if (movlanStr != null ) {
						movlanToken = token(movlanStrs, movlanToken);	  
						req.setAttribute("movlanToken", movlanToken); 	
					}
				}
				
				//���U�Կ��
				String movrating = req.getParameter("movrating").trim();
				
				String movditor = req.getParameter("movditor").trim();
				if(movditor == null || movditor.length() == 0) {
					errorMsgs.put("movditor"," �ɺt��� �ФŪť�");
					
					//��split�r��A�A��Ȱe��update_movie_input.jsp
			        if (movverStr != null) {  
						movverToken = token(movverStrs, movverToken);
						req.setAttribute("movverToken", movverToken);	
					}
					if (movlanStr != null ) {
						movlanToken = token(movlanStrs, movlanToken);	  
						req.setAttribute("movlanToken", movlanToken); 	
					}
				}
				
				String movcast = req.getParameter("movcast").trim();
				if(movcast == null || movcast.length() == 0) {
					errorMsgs.put("movcast"," �t����� �ФŪť�");
					
					//��split�r��A�A��Ȱe��update_movie_input.jsp
			        if (movverStr != null) {  
						movverToken = token(movverStrs, movverToken);
						req.setAttribute("movverToken", movverToken);	
					}
					if (movlanStr != null ) {
						movlanToken = token(movlanStrs, movlanToken);	  
						req.setAttribute("movlanToken", movlanToken); 	
					}
				}

				String movdes = req.getParameter("movdes").trim();
				if(movdes == null || movdes.equals("")) {
					errorMsgs.put("movdes"," �q�v²�� �ФŪť�");
					
					//��split�r��A�A��Ȱe��update_movie_input.jsp
			        if (movverStr != null) {  
						movverToken = token(movverStrs, movverToken);
						req.setAttribute("movverToken", movverToken);	
					}
					if (movlanStr != null ) {
						movlanToken = token(movlanStrs, movlanToken);	  
						req.setAttribute("movlanToken", movlanToken); 	
					}
				}

				
				/* �ק�ɡAcontentType�����image�ɡA�~update�A�쥻�J�����Ϥ~���|�����C */
				Part movposPart = req.getPart("movpos");	
				byte[] movpos = movVO.getMovpos();
				if(movposPart.getContentType() != null && movposPart.getContentType().indexOf("image") >= 0) {  // movposPart.getContentType() �L�Ximage/jpeg
				//if(movposPart != null) {	//�o�˧P�_�O���諸�A�]���Y�K�S�F��A�|�^�ǳo�� application/octet-stream	 			
					
					InputStream movposis = movposPart.getInputStream();
					movpos = new byte[movposis.available()];
					movposis.read(movpos);
					movposis.close();
					
					movSvc.updateMovpos(movpos, movno);
				}
				
				/* �ק�ɡAcontentType�����video�ɡA�~update�A�쥻�J�����v���~���|�����C */
				Part movtraPart = req.getPart("movtra");
				byte[] movtra = movVO.getMovtra();
				if(movtraPart.getContentType() != null && movtraPart.getContentType().indexOf("video") >= 0) {	// movtraPart.getContentType() �L�Xvideo/mp4			
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
					Boolean openUpdateLightbox = true;
					req.setAttribute("openUpdateLightbox", openUpdateLightbox);
					
					RequestDispatcher failureView = req.getRequestDispatcher(requestURL);
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.�}�l�ק���*****************************************/
				movVO = movSvc.updateMov(movname, movver, movtype, movlan, movondate, movoffdate, movdurat, movrating, movditor, movcast, movdes, movno);
				
				/***************************3.�ק粒��,�ǳ����(Send the Success view)*************/	
				if(requestURL.equals("/back-end/movie/listMovies_ByCompositeQuery.jsp")){
					HttpSession session = req.getSession();
					Map<String, String[]> map = (Map<String, String[]>)session.getAttribute("map");
					List<MovVO> list  = movSvc.getAll(map);
					req.setAttribute("listMovies_ByCompositeQuery",list); //  �ƦX�d��, ��Ʈw���X��list����,�s�J
				}
				
				String updateSuccess = "�i  " + movname + " �j" + "�ק令�\";
				req.setAttribute("updateSuccess", updateSuccess);
				Boolean openUpdateLightbox = false;
				req.setAttribute("openUpdateLightbox", openUpdateLightbox); //update success���n���X�O�c

				String url = requestURL;
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);

				/***************************��L�i�઺���~�B�z*************************************/
			}catch (Exception e) {
				errorMsgs.put("Exception","�ק��ƥ���:"+e.getMessage());
				Boolean openUpdateLightbox = true;
				req.setAttribute("openUpdateLightbox", openUpdateLightbox);
				
				RequestDispatcher failureView = req.getRequestDispatcher(requestURL);
				failureView.forward(req, res);
			}
		}

		// �Ӧ�select_page.jsp���ШD---�ƦX�d��
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

			/***************************2.�}�l�ƦX�d��***************************************/
			MovService movSvc = new MovService();
			List<MovVO> list  = movSvc.getAll(map);
			
			/***************************3.�d�ߧ���,�ǳ����(Send the Success view)************/
			req.setAttribute("listMovies_ByCompositeQuery", list); // ��Ʈw���X��list����,�s�Jrequest
			RequestDispatcher successView = req.getRequestDispatcher("/back-end/movie/listMovies_ByCompositeQuery.jsp"); // ���\���listEmps_ByCompositeQuery.jsp
			successView.forward(req, res);
			
			/***************************��L�i�઺���~�B�z**********************************/
			}catch(Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/movie/select_page.jsp");
				failureView.forward(req, res);
			}
		}
	} 
	
	public static String[] token(String str, String[] token){
		if(str != null) {
			token = str.split(",");
		}
		return token;
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
