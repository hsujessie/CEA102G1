package com.session.model;

import java.util.List;
import java.util.Map;

import com.movie.model.MovVO;

public interface SesDAO_interface {
	public void insert(SesVO sesVO);
	public void update(SesVO sesVO);
    public SesVO findByPrimaryKey(Integer sesNo);
    public List<SesVO> getAll();
    public List<SesVO> getAll(Map<String, String[]> map);  //複合查詢

}
