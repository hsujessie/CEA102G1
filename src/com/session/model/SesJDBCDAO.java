package com.session.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class SesJDBCDAO implements SesDAO_interface{
	String driver = "com.mysql.cj.jdbc.Driver";
	String url = "jdbc:mysql://localhost:3306/seenema?serverTimezone=Asia/Taipei";
	String userid = "root";
	String passwd = "123456";

	
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
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			
			pstmt = con.prepareStatement(INSERT_STMT);
			pstmt.setInt(1,sesVO.getMovNo());
			pstmt.setInt(2,sesVO.getTheNo());
			pstmt.setDate(3,sesVO.getSesDate());
			pstmt.setTimestamp(4,sesVO.getSesTime());
			pstmt.setString(5,sesVO.getSesSeatStatus());
			pstmt.setString(6,sesVO.getSesSeatNo());
			pstmt.setInt(7,sesVO.getSesOrder());
			
			pstmt.executeUpdate();
			
		} catch(ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
		} catch(SQLException se) {
			throw new RuntimeException("SesJDBCDAO insert A database error occured. " + se.getMessage());		
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
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			
			pstmt = con.prepareStatement(UPDATE);
			pstmt.setInt(1,sesVO.getMovNo());
			pstmt.setInt(2,sesVO.getTheNo());
			pstmt.setDate(3,sesVO.getSesDate());
			pstmt.setTimestamp(4,sesVO.getSesTime());
			pstmt.setInt(5,sesVO.getSesOrder());
			pstmt.setInt(6,sesVO.getSesNo());
			
			pstmt.executeUpdate();
			
		} catch(ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
		} catch(SQLException se) {
			throw new RuntimeException("SesJDBCDAO update A database error occured. " + se.getMessage());
		
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
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			
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
			
		}  catch(ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());			
		} catch(SQLException se) {
			throw new RuntimeException("SesJDBCDAO findByPrimaryKey A database error occured. " + se.getMessage());	
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
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			
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
			
		} catch(ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());	
		} catch(SQLException se) {
			throw new RuntimeException("SesJDBCDAO getAll A database error occured. " + se.getMessage());	
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
	
	public static void main(String[] args) {
		SesJDBCDAO dao = new SesJDBCDAO();
		
		// 新增
		SesVO sesVO = new SesVO();
		sesVO.setMovNo(1);
		sesVO.setTheNo(1);
		sesVO.setSesDate(null);
		sesVO.setSesTime(null);
		sesVO.setSesSeatStatus("9900");
		sesVO.setSesSeatNo("A01");
		sesVO.setSesOrder(1);
		dao.insert(sesVO);
		
		// 修改
		// mov_no=?,the_no=?,ses_date=?,ses_time=?,ses_order=?
		SesVO sesVO2 = new SesVO();
		sesVO2.setMovNo(1);
		sesVO2.setTheNo(1);
		sesVO2.setSesDate(null);
		sesVO2.setSesTime(null);
		sesVO2.setSesOrder(1);
		sesVO2.setSesNo(1);
		dao.update(sesVO2);
		
		// 查詢
		SesVO sesVO3 = dao.findByPrimaryKey(1);
		System.out.print(sesVO3.getSesNo() + ",");
		System.out.print(sesVO3.getMovNo() + ",");
		System.out.print(sesVO3.getTheNo() + ",");
		System.out.print(sesVO3.getSesDate() + ",");
		System.out.print(sesVO3.getSesTime() + ",");
		System.out.print(sesVO3.getSesSeatStatus() + ",");
		System.out.print(sesVO3.getSesSeatNo() + ",");
		System.out.print(sesVO3.getSesOrder());
		System.out.println("---------------------");
		
		// 查詢
		List<SesVO> list = dao.getAll();
		for (SesVO aSes : list) {
			System.out.print(aSes.getSesNo() + ",");
			System.out.print(aSes.getMovNo() + ",");
			System.out.print(aSes.getTheNo() + ",");
			System.out.print(aSes.getSesDate() + ",");
			System.out.print(aSes.getSesTime() + ",");
			System.out.print(aSes.getSesSeatStatus() + ",");
			System.out.print(aSes.getSesSeatNo() + ",");
			System.out.print(aSes.getSesOrder());
			System.out.println();
		}
	}
}
