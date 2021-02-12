package com.session.model;

import java.io.Serializable;
import java.sql.Date;
import java.sql.Timestamp;

public class SesVO implements Serializable{
	private Integer sesNo;
	private Integer movNo;
	private Integer theNo;
	private Date sesDate;
	private Timestamp sesTime;
	private String sesSeatStatus;
	private String sesSeatNo;
	private Integer sesOrder;
	
	public SesVO() {}

	public Integer getSesNo() {
		return sesNo;
	}

	public void setSesNo(Integer sesNo) {
		this.sesNo = sesNo;
	}

	public Integer getMovNo() {
		return movNo;
	}

	public void setMovNo(Integer movNo) {
		this.movNo = movNo;
	}

	public Integer getTheNo() {
		return theNo;
	}

	public void setTheNo(Integer theNo) {
		this.theNo = theNo;
	}

	public Date getSesDate() {
		return sesDate;
	}

	public void setSesDate(Date sesDate) {
		this.sesDate = sesDate;
	}

	public Timestamp getSesTime() {
		return sesTime;
	}

	public void setSesTime(Timestamp sesTime) {
		this.sesTime = sesTime;
	}

	public String getSesSeatStatus() {
		return sesSeatStatus;
	}

	public void setSesSeatStatus(String sesSeatStatus) {
		this.sesSeatStatus = sesSeatStatus;
	}

	public String getSesSeatNo() {
		return sesSeatNo;
	}

	public void setSesSeatNo(String sesSeatNo) {
		this.sesSeatNo = sesSeatNo;
	}

	public Integer getSesOrder() {
		return sesOrder;
	}

	public void setSesOrder(Integer sesOrder) {
		this.sesOrder = sesOrder;
	}
}
