package com.movie.model;

import java.util.*;

import java.sql.*;

public class MovJDBCDAO implements MovDAO_interface{
	String driver = "com.mysql.cj.jdbc.Driver";
	String url = "jdbc:mysql://localhost:3306/seenema?serverTimezone=Asia/Taipei";
	String userid = "root";
	String passwd = "123456";
	
	//要先去資料庫，測試看看sql指令是否正確!!
	private static final String INSERT_STMT =
		"INSERT INTO movie (mov_name,mov_ver,mov_type,mov_lan,mov_ondate,mov_offdate,mov_durat,mov_rating,mov_ditor,mov_cast,mov_des,mov_pos,mov_tra) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?)"; 
	private static final String GET_ALL_STMT =
		"SELECT mov_no,mov_name,mov_ver,mov_type,mov_lan,mov_ondate,mov_offdate,mov_durat,mov_rating,mov_ditor,mov_cast,mov_des,mov_pos,mov_tra,mov_satitotal,mov_satipers,mov_expetotal,mov_expepers FROM movie order by mov_no";
	private static final String GET_ONE_STMT =
		"SELECT mov_no,mov_name,mov_ver,mov_type,mov_lan,mov_ondate,mov_offdate,mov_durat,mov_rating,mov_ditor,mov_cast,mov_des,mov_pos,mov_tra,mov_satitotal,mov_satipers,mov_expetotal,mov_expepers FROM movie where mov_no = ?";
	private static final String UPDATE =
		"UPDATE movie set mov_name=?, mov_ver=?, mov_type=?, mov_lan=?, mov_ondate=?, mov_offdate=?, mov_durat=?, mov_rating=?, mov_ditor=?, mov_cast=?, mov_des=?, mov_pos=?, mov_tra=? where mov_no = ?";

	@Override
	public void insert(MovVO movVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(INSERT_STMT);
			
			pstmt.setString(1,movVO.getMovname());
			pstmt.setString(2,movVO.getMovver());
			pstmt.setString(3,movVO.getMovtype());
			pstmt.setString(4,movVO.getMovlan());
			pstmt.setDate(5,movVO.getMovondate());
			pstmt.setDate(6,movVO.getMovoffdate());
			pstmt.setInt(7,movVO.getMovdurat());
			pstmt.setString(8,movVO.getMovrating());
			pstmt.setString(9,movVO.getMovditor());
			pstmt.setString(10,movVO.getMovcast());
			pstmt.setString(11,movVO.getMovdes());
			pstmt.setBytes(12, movVO.getMovpos());
			pstmt.setBytes(13, movVO.getMovtra());
			
			pstmt.executeUpdate();

			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}

	}

	@Override
	public void update(MovVO movVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setString(1,movVO.getMovname());
			pstmt.setString(2,movVO.getMovver());
			pstmt.setString(3,movVO.getMovtype());
			pstmt.setString(4,movVO.getMovlan());
			pstmt.setDate(5,movVO.getMovondate());
			pstmt.setDate(6,movVO.getMovoffdate());
			pstmt.setInt(7,movVO.getMovdurat());
			pstmt.setString(8,movVO.getMovrating());
			pstmt.setString(9,movVO.getMovditor());
			pstmt.setString(10,movVO.getMovcast());
			pstmt.setString(11,movVO.getMovdes());
			pstmt.setBytes(12, movVO.getMovpos());
			pstmt.setBytes(13, movVO.getMovtra());
			pstmt.setInt(14, movVO.getMovno());
			
			pstmt.executeUpdate();

			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}

	}

	@Override
	public MovVO findByPrimaryKey(Integer movno) {
		MovVO movVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ONE_STMT);
			pstmt.setInt(1,movno);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				movVO = new MovVO();
				movVO.setMovno(rs.getInt("mov_no"));
				movVO.setMovname(rs.getString("mov_name"));
				movVO.setMovver(rs.getString("mov_ver"));
				movVO.setMovtype(rs.getString("mov_type"));
				movVO.setMovlan(rs.getString("mov_lan"));
				movVO.setMovondate(rs.getDate("mov_ondate"));
				movVO.setMovoffdate(rs.getDate("mov_offdate"));
				movVO.setMovdurat(rs.getInt("mov_durat"));
				movVO.setMovrating(rs.getString("mov_rating"));
				movVO.setMovditor(rs.getString("mov_ditor"));
				movVO.setMovcast(rs.getString("mov_cast"));
				movVO.setMovdes(rs.getString("mov_des"));
				movVO.setMovpos(rs.getBytes("mov_pos"));
				movVO.setMovtra(rs.getBytes("mov_tra"));
				movVO.setMovsatitotal(rs.getInt("mov_satitotal"));
				movVO.setMovsatipers(rs.getInt("mov_satipers"));
				movVO.setMovexpetotal(rs.getInt("mov_expetotal"));
				movVO.setMovexpepers(rs.getInt("mov_expepers"));
			}

			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return movVO;
	}

	@Override
	public List<MovVO> getAll() {
		List<MovVO> list = new ArrayList<MovVO>();
		MovVO movVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				movVO = new MovVO();
				movVO.setMovno(rs.getInt("mov_no"));
				movVO.setMovname(rs.getString("mov_name"));
				movVO.setMovver(rs.getString("mov_ver"));
				movVO.setMovtype(rs.getString("mov_type"));
				movVO.setMovlan(rs.getString("mov_lan"));
				movVO.setMovondate(rs.getDate("mov_ondate"));
				movVO.setMovoffdate(rs.getDate("mov_offdate"));
				movVO.setMovdurat(rs.getInt("mov_durat"));
				movVO.setMovrating(rs.getString("mov_rating"));
				movVO.setMovditor(rs.getString("mov_ditor"));
				movVO.setMovcast(rs.getString("mov_cast"));
				movVO.setMovdes(rs.getString("mov_des"));
				movVO.setMovpos(rs.getBytes("mov_pos"));
				movVO.setMovtra(rs.getBytes("mov_tra"));
				movVO.setMovsatitotal(rs.getInt("mov_satitotal"));
				movVO.setMovsatipers(rs.getInt("mov_satipers"));
				movVO.setMovexpetotal(rs.getInt("mov_expetotal"));
				movVO.setMovexpepers(rs.getInt("mov_expepers"));
				list.add(movVO);
			}

			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		
		return list;
	}

	public static void main(String[] args) {

		MovJDBCDAO dao = new MovJDBCDAO();

		// 新增
		MovVO movVO1 = new MovVO();
		movVO1.setMovname("金牌特務");
		movVO1.setMovver("2D");
		movVO1.setMovtype("科幻片");
		movVO1.setMovlan("英文");
		movVO1.setMovondate(java.sql.Date.valueOf("2015-02-18"));
		movVO1.setMovoffdate(java.sql.Date.valueOf("2015-03-18"));
		movVO1.setMovdurat(2);
		movVO1.setMovrating("普遍級");
		movVO1.setMovditor("dicrector");
		movVO1.setMovcast("actors");
		movVO1.setMovdes("description");
		movVO1.setMovpos(null);
		movVO1.setMovtra(null);
		dao.insert(movVO1);

		// 修改
		MovVO movVO2 = new MovVO();
		movVO2.setMovname("金牌特務2");
		movVO2.setMovver("3D");
		movVO2.setMovtype("科幻片2");
		movVO2.setMovlan("英文2");
		movVO2.setMovondate(java.sql.Date.valueOf("2015-02-18"));
		movVO2.setMovoffdate(java.sql.Date.valueOf("2015-03-18"));
		movVO2.setMovdurat(2);
		movVO2.setMovrating("普遍級2");
		movVO2.setMovditor("dicrector2");
		movVO2.setMovcast("actors2");
		movVO2.setMovdes("description2");
		movVO2.setMovpos(null);
		movVO2.setMovtra(null);
		movVO2.setMovno(1);
		dao.update(movVO2);

		// 查詢
		MovVO movVO3 = dao.findByPrimaryKey(1);
		System.out.print(movVO3.getMovno() + ",");
		System.out.print(movVO3.getMovname() + ",");
		System.out.print(movVO3.getMovver() + ",");
		System.out.print(movVO3.getMovtype() + ",");
		System.out.print(movVO3.getMovlan() + ",");
		System.out.print(movVO3.getMovondate() + ",");
		System.out.println(movVO3.getMovoffdate());
		System.out.print(movVO3.getMovdurat() + ",");
		System.out.print(movVO3.getMovrating() + ",");
		System.out.print(movVO3.getMovditor() + ",");
		System.out.print(movVO3.getMovcast() + ",");
		System.out.print(movVO3.getMovdes() + ",");
		System.out.print(movVO3.getMovtra() + ",");
		System.out.print(movVO3.getMovsatitotal() + ",");
		System.out.print(movVO3.getMovsatipers() + ",");
		System.out.print(movVO3.getMovexpetotal() + ",");
		System.out.print(movVO3.getMovexpepers());
		System.out.println("---------------------");

		// 查詢
		List<MovVO> list = dao.getAll();
		for (MovVO aMov : list) {
			System.out.print(aMov.getMovno() + ",");
			System.out.print(aMov.getMovname() + ",");
			System.out.print(aMov.getMovver() + ",");
			System.out.print(aMov.getMovtype() + ",");
			System.out.print(aMov.getMovlan() + ",");
			System.out.print(aMov.getMovondate() + ",");
			System.out.print(aMov.getMovoffdate() + ",");
			System.out.print(aMov.getMovdurat() + ",");
			System.out.print(aMov.getMovrating() + ",");
			System.out.print(aMov.getMovditor() + ",");
			System.out.print(aMov.getMovcast() + ",");
			System.out.print(aMov.getMovdes() + ",");
			System.out.print(aMov.getMovtra() + ",");
			System.out.print(aMov.getMovsatitotal() + ",");
			System.out.print(aMov.getMovsatipers() + ",");
			System.out.print(aMov.getMovexpetotal() + ",");
			System.out.print(aMov.getMovexpepers());
			System.out.println();
		}
	}
}