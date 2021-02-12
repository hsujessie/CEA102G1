package com.comment_report.model;

import java.io.Serializable;
import java.sql.Timestamp;

public class ComRepVO implements Serializable{
	private Integer comRepNo;
	private Integer comNo;
	private Integer memNo;
	private String comrepReason;
	private Timestamp comrepTime;
	private Integer comrepStatus;
	
	public ComRepVO() {}

	public Integer getComRepNo() {
		return comRepNo;
	}

	public void setComRepNo(Integer comRepNo) {
		this.comRepNo = comRepNo;
	}

	public Integer getComNo() {
		return comNo;
	}

	public void setComNo(Integer comNo) {
		this.comNo = comNo;
	}

	public Integer getMemNo() {
		return memNo;
	}

	public void setMemNo(Integer memNo) {
		this.memNo = memNo;
	}

	public String getComrepReason() {
		return comrepReason;
	}

	public void setComrepReason(String comrepReason) {
		this.comrepReason = comrepReason;
	}

	public Timestamp getComrepTime() {
		return comrepTime;
	}

	public void setComrepTime(Timestamp comrepTime) {
		this.comrepTime = comrepTime;
	}

	public Integer getComrepStatus() {
		return comrepStatus;
	}

	public void setComrepStatus(Integer comrepStatus) {
		this.comrepStatus = comrepStatus;
	}
}