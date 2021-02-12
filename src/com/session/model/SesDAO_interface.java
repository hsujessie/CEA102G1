package com.session.model;

import java.util.List;

public interface SesDAO_interface {
	public void insert(SesVO sesVO);
	public void update(SesVO sesVO);
    public SesVO findByPrimaryKey(Integer sesNo);
    public List<SesVO> getAll();

}
