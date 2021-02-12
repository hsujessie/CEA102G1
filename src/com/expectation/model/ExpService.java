package com.expectation.model;

import java.util.List;

public class ExpService {
	private ExpDAO_interface dao;
	
	public ExpService() {
		dao = new ExpDAO();
	}
	
	public ExpVO addExp(Integer movNo, Integer memNo, Integer expRating) {
		ExpVO expVO = new ExpVO();
		
		expVO.setMovNo(movNo);
		expVO.setMemNo(memNo);
		expVO.setExpRating(expRating);
		dao.insert(expVO);
		
		return expVO;
	}
	
	public ExpVO updateSat(Integer movNo, Integer memNo, Integer expRating) {
		ExpVO expVO = new ExpVO();
		
		expVO.setMovNo(movNo);
		expVO.setMemNo(memNo);
		expVO.setExpRating(expRating);
		dao.update(expVO);
		
		return expVO;
	}
	
	public ExpVO getOneMov(Integer movNo, Integer memNo) {
		return dao.findByPrimaryKey(movNo,memNo);
	}
	
	public List<ExpVO> getAll(){
		return dao.getAll();
	}
}
