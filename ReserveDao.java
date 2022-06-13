package reserve.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import common.JDBCTemplate;
import reserve.vo.Branch;
import reserve.vo.Movie;
import reserve.vo.Schedule;
import reserve.vo.TheaterDetailSeat;

public class ReserveDao {
	public ArrayList<Movie> selectMovieList(Connection conn) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		ArrayList<Movie> mvlist = new ArrayList<Movie>();
		String query = "select * from movie_tbl";
		try {
			pstmt = conn.prepareStatement(query);
			rset = pstmt.executeQuery();
			while(rset.next()) {
				Movie mv = new Movie();
				mv.setMovieNo(rset.getInt("movie_no"));
				mv.setMovieTitle(rset.getString("movie_title"));
				mv.setMovieGrade(rset.getString("movie_grade"));
				mvlist.add(mv);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(pstmt);
			JDBCTemplate.close(rset);
		}
		return mvlist;
	}

	public ArrayList<Branch> selectBranchList(Connection conn, int mvNo) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		ArrayList<Branch> brlist = new ArrayList<Branch>();
		String query = "SELECT DISTINCT MOVIE_NO, BRANCH_NAME, BRANCH_NO FROM" + 
				"(SELECT MOVIE_NO, BRANCH_NO FROM SCHEDULE_TBL JOIN THEATER_TBL USING (THEATER_NO) WHERE MOVIE_NO=?)" + 
				"JOIN BRANCH_TBL USING (BRANCH_NO)" + 
				"WHERE MOVIE_NO=?";
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, mvNo);
			pstmt.setInt(2, mvNo);
			rset = pstmt.executeQuery();
			while(rset.next()) {
				Branch br = new Branch();
				br.setBranchName(rset.getString("branch_name"));
				br.setBranchNo(rset.getInt("branch_no"));
				brlist.add(br);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(pstmt);
			JDBCTemplate.close(rset);
		}
		return brlist;
	}

	public Schedule selectDayList(Connection conn, int mvNo, int brNo) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		Schedule sc = new Schedule();
		String query = "SELECT START_DATE,END_DATE FROM THEATER_TBL\r\n" + 
				"JOIN SCHEDULE_TBL USING (THEATER_NO)\r\n" + 
				"WHERE MOVIE_NO=? AND BRANCH_NO=?";
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, mvNo);
			pstmt.setInt(2, brNo);
			rset = pstmt.executeQuery();
			rset.next();
			sc.setStartDate(rset.getDate("start_date"));
			sc.setEndDate(rset.getDate("end_date"));
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(pstmt);
			JDBCTemplate.close(rset);
		}
		return sc;
	}
	
	public ArrayList<TheaterDetailSeat> selectScheduleList(Connection conn, int mvNo, int brNo) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		ArrayList<TheaterDetailSeat> list = new ArrayList<TheaterDetailSeat>();
		String query = "SELECT THEATER_NO,THEATER_NAME,START_TIME,END_TIME,(SELECT COUNT(SEAT_EXIST) FROM SEAT_JY WHERE SEAT_EXIST=0) as available \r\n" + 
				"FROM BRANCH_TBL\r\n" + 
				"JOIN THEATER_TBL USING (BRANCH_NO)\r\n" + 
				"JOIN SCHEDULE_TBL USING (THEATER_NO)\r\n" + 
				"JOIN DETAIL_TBL USING (SCHEDULE_NO)\r\n" + 
				"WHERE MOVIE_NO=? AND BRANCH_NO=?";
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, mvNo);
			pstmt.setInt(2, brNo);
			rset = pstmt.executeQuery();
			while(rset.next()) {
				TheaterDetailSeat th = new TheaterDetailSeat();
				th.setTheaterNo(rset.getInt("theater_no"));
				th.setTheaterName(rset.getString("theater_name"));
				th.setStartTime(rset.getString("start_time"));
				th.setEndTime(rset.getString("end_time"));
				th.setSeatExist(rset.getInt("available"));
				list.add(th);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
}
