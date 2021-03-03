package com.session.model;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;

public class SesService {
	private SesDAO_interface dao;
	
	public SesService() {
		dao = new SesDAO();
	}
	
	public SesVO addSes(Integer movNo, Integer theNo, Date sesDate, Timestamp sesTime, String sesSeatStatus, String sesSeatNo, Integer sesOrder) {
		SesVO sesVO = new SesVO();
		sesVO.setMovNo(movNo);
		sesVO.setTheNo(theNo);
		sesVO.setSesDate(sesDate);
		sesVO.setSesTime(sesTime);
		sesVO.setSesSeatStatus(sesSeatStatus);
		sesVO.setSesSeatNo(sesSeatNo);
		sesVO.setSesOrder(sesOrder);
		dao.insert(sesVO);
		
		return sesVO;
	}
	
	//mov_no=?,the_no=?,ses_date=?,ses_time=?,ses_order=?
	public SesVO updateSes(Integer movNo, Integer theNo, Date sesDate, Timestamp sesTime, Integer sesOrder, Integer sesNo) {
		SesVO sesVO = new SesVO();
		sesVO.setMovNo(movNo);
		sesVO.setTheNo(theNo);
		sesVO.setSesDate(sesDate);
		sesVO.setSesTime(sesTime);
		sesVO.setSesOrder(sesOrder);
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
}
