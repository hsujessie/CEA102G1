package com.movie.model;

import java.util.List;

public interface MovDAO_interface {
	public void insert(MovVO movVO);
	public void update(MovVO movVO);
    public MovVO findByPrimaryKey(Integer movno);
    public List<MovVO> getAll();
}
