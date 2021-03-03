package com.session.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.movie.model.MovVO;

import jdbc.util.CompositeQuery.jdbcUtil_CompositeQuery_Movie;

public class SesDAO implements SesDAO_interface{
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/seenema");
		}catch(NamingException e) {
			e.printStackTrace();
		}
	}

	
	private static final String INSERT_STMT =
		"INSERT INTO SESSION (mov_no,the_no,ses_date,ses_time,ses_seat_status,ses_seatno,ses_order) VALUES (?,?,?,?,?,?,?)"; 
	private static final String GET_ALL_STMT =
		"SELECT ses_no,mov_no,the_no,ses_date,ses_time,ses_seat_status,ses_seatno,ses_order FROM SESSION ORDER BY ses_no";
	private static final String GET_ONE_STMT =
		"SELECT ses_no,mov_no,the_no,ses_date,ses_time,ses_seat_status,ses_seatno,ses_order FROM SESSION WHERE ses_no=?";
	private static final String UPDATE =
		"UPDATE SESSION SET mov_no=?,the_no=?,ses_date=?,ses_time=?,ses_order=? WHERE ses_no=?";

	@Override
	public void insert(SesVO sesVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			
			pstmt = con.prepareStatement(INSERT_STMT);
			pstmt.setInt(1,sesVO.getMovNo());
			pstmt.setInt(2,sesVO.getTheNo());
			pstmt.setDate(3,sesVO.getSesDate());
			pstmt.setTimestamp(4,sesVO.getSesTime());
			pstmt.setString(5,sesVO.getSesSeatStatus());
			pstmt.setString(6,sesVO.getSesSeatNo());
			pstmt.setInt(7,sesVO.getSesOrder());
			
			pstmt.executeUpdate();
			
		} catch(SQLException se) {
			throw new RuntimeException("SesDAO insert A database error occured. " + se.getMessage());		
		} finally {
			if(pstmt !=  null) {
				try {
					pstmt.close();
				}catch(SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if(con != null) {
				try {
					con.close();
				}catch(Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		
	}

	@Override
	public void update(SesVO sesVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ds.getConnection();
			
			pstmt = con.prepareStatement(UPDATE);
			pstmt.setInt(1,sesVO.getMovNo());
			pstmt.setInt(2,sesVO.getTheNo());
			pstmt.setDate(3,sesVO.getSesDate());
			pstmt.setTimestamp(4,sesVO.getSesTime());
			pstmt.setInt(5,sesVO.getSesOrder());
			pstmt.setInt(6,sesVO.getSesNo());
			
			pstmt.executeUpdate();
			
		} catch(SQLException se) {
			throw new RuntimeException("SesDAO update A database error occured. " + se.getMessage());
		
		} finally {
			if(pstmt !=  null) {
				try {
					pstmt.close();
				}catch(SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if(con != null) {
				try {
					con.close();
				}catch(Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}	
		
	}

	@Override
	public SesVO findByPrimaryKey(Integer sesNo) {
		SesVO sesVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			
			pstmt = con.prepareStatement(GET_ONE_STMT);
			pstmt.setInt(1,sesNo);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				sesVO = new SesVO();
				sesVO.setSesNo(rs.getInt("ses_no"));
				sesVO.setMovNo(rs.getInt("mov_no"));
				sesVO.setTheNo(rs.getInt("the_no"));
				sesVO.setSesDate(rs.getDate("ses_date"));
				sesVO.setSesTime(rs.getTimestamp("ses_time"));
				sesVO.setSesSeatStatus(rs.getString("ses_seat_status"));
				sesVO.setSesSeatNo(rs.getString("ses_seatno"));
				sesVO.setSesOrder(rs.getInt("ses_order"));
			}		
			
		} catch(SQLException se) {
			throw new RuntimeException("SesDAO findByPrimaryKey A database error occured. " + se.getMessage());	
		} finally {
			if(rs != null) {
				try {
					rs.close();
				}catch(SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			
			if(pstmt != null) {
				try {
					pstmt.close();
				}catch(SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			
			if(con != null) {
				try {
					con.close();
				}catch(Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return sesVO;
	}

	@Override
	public List<SesVO> getAll() {
		List<SesVO> list = new ArrayList<SesVO>();
		SesVO sesVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();			
			while(rs.next()){
				sesVO = new SesVO();
				sesVO.setSesNo(rs.getInt("ses_no"));
				sesVO.setMovNo(rs.getInt("mov_no"));
				sesVO.setTheNo(rs.getInt("the_no"));
				sesVO.setSesDate(rs.getDate("ses_date"));
				sesVO.setSesTime(rs.getTimestamp("ses_time"));
				sesVO.setSesSeatStatus(rs.getString("ses_seat_status"));
				sesVO.setSesSeatNo(rs.getString("ses_seatno"));
				sesVO.setSesOrder(rs.getInt("ses_order"));
				list.add(sesVO);
			}
			
		} catch(SQLException se) {
			throw new RuntimeException("SesDAO getAll A database error occured. " + se.getMessage());	
		} finally {
			if(rs != null) {
				try {
					rs.close();
				}catch(SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			
			if(pstmt != null) {
				try {
					pstmt.close();
				}catch(SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			
			if(con != null) {
				try {
					con.close();
				}catch(Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		
		return list;
	}

	@Override
	public List<SesVO> getAll(Map<String, String[]> map) {
		List<SesVO> list = new ArrayList<SesVO>();
		SesVO sesVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			
			String finalSQL = "select * from session"
			          		   + jdbcUtil_CompositeQuery_Movie.get_WhereCondition(map)
			          		   + " order by ses_date";
			pstmt = con.prepareStatement(finalSQL);
			System.out.println("●●finalSQL(by SesDAO) = "+finalSQL);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				sesVO = new SesVO();
//				movVO.setMovno(rs.getInt("mov_no"));
//				movVO.setMovname(rs.getString("mov_name"));
//				movVO.setMovver(rs.getString("mov_ver"));
//				movVO.setMovtype(rs.getString("mov_type"));
//				movVO.setMovlan(rs.getString("mov_lan"));
//				movVO.setMovondate(rs.getDate("mov_ondate"));
//				movVO.setMovoffdate(rs.getDate("mov_offdate"));
//				movVO.setMovdurat(rs.getInt("mov_durat"));
//				movVO.setMovrating(rs.getString("mov_rating"));
//				movVO.setMovditor(rs.getString("mov_ditor"));
//				movVO.setMovcast(rs.getString("mov_cast"));
//				movVO.setMovdes(rs.getString("mov_des"));
//				movVO.setMovpos(rs.getBytes("mov_pos"));
//				movVO.setMovtra(rs.getBytes("mov_tra"));
//				movVO.setMovsatitotal(rs.getInt("mov_satitotal"));
//				movVO.setMovsatipers(rs.getInt("mov_satipers"));
//				movVO.setMovexpetotal(rs.getInt("mov_expetotal"));
//				movVO.setMovexpepers(rs.getInt("mov_expepers"));
//				list.add(movVO);
			}
		}catch(SQLException se) {
			throw new RuntimeException("MovDAO Map getAll A database error occured. " + se.getMessage());
		} finally {
			if(rs != null) {
				try {
					rs.close();
				}catch(SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if(pstmt != null) {
				try {
					pstmt.close();
				}catch(SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if(con != null) {
				try {
					con.close();
				}catch(SQLException se) {
					se.printStackTrace(System.err);
				}
			}
		}
		
		return list;
	}

}
