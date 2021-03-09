package com.session.model;

import java.sql.Date;
import java.sql.Time;
import java.util.List;
import java.util.Map;

public class SesService {
	private SesDAO_interface dao;
	
	public SesService() {
		dao = new SesDAO();
	}
	
	public SesVO addSes(Integer movNo, Integer theNo, Date sesDate, Time sesTime, String sesSeatStatus, String sesSeatNo) {
		SesVO sesVO = new SesVO();
		sesVO.setMovNo(movNo);
		sesVO.setTheNo(theNo);
		sesVO.setSesDate(sesDate);
		sesVO.setSesTime(sesTime);
		sesVO.setSesSeatStatus(sesSeatStatus);
		sesVO.setSesSeatNo(sesSeatNo);
		dao.insert(sesVO);
		
		return sesVO;
	}
	
	
	public SesVO updateSes(Integer theNo, Date sesDate, Time sesTime, Integer sesNo) {
		SesVO sesVO = new SesVO();
		sesVO.setTheNo(theNo);
		sesVO.setSesDate(sesDate);
		sesVO.setSesTime(sesTime);
		sesVO.setSesNo(sesNo);
		dao.update(sesVO);
		
		return sesVO;
	}
	
	public SesVO getOneSes(Integer sesNo) {
		return dao.findByPrimaryKey(sesNo);
	}
	
	public List<SesVO> getAll(){
		return dao.getAll();
	}

	public List<SesVO> getAll(Map<String, String[]> map) {
		return dao.getAll(map);
	}

	public List<SesVO> getMoviesBySesDate(Date sesDate) {
		return dao.findMoviesBySesDate(sesDate);
	}

	public List<SesVO> getDistinctSesDate() {
		return dao.findDistinctSesDate();
	}
}
