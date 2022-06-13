package reserve.service;

import java.sql.Connection;
import java.util.ArrayList;

import common.JDBCTemplate;
import reserve.vo.Branch;
import reserve.vo.Movie;
import reserve.vo.Schedule;
import reserve.vo.TheaterDetailSeat;
import reserve.dao.ReserveDao;

public class ReserveService {
	public ArrayList<Movie> selectMovieList() {
		Connection conn = JDBCTemplate.getConnection();
		ArrayList<Movie> mvlist = new ReserveDao().selectMovieList(conn);
		JDBCTemplate.close(conn);
		return mvlist;
	}

	public ArrayList<Branch> selectBranchList(int mvNo) {
		Connection conn = JDBCTemplate.getConnection();
		ArrayList<Branch> brlist = new ReserveDao().selectBranchList(conn,mvNo);
		JDBCTemplate.close(conn);
		return brlist;
	}


	public Schedule selectDayList(int mvNo, int brNo) {
		Connection conn = JDBCTemplate.getConnection();
		Schedule sc = new ReserveDao().selectDayList(conn,mvNo,brNo);
		JDBCTemplate.close(conn);
		return sc;
	}

	public ArrayList<TheaterDetailSeat> selectScheduleList(int mvNo, int brNo) {
		Connection conn = JDBCTemplate.getConnection();
		ArrayList<TheaterDetailSeat> list = new ReserveDao().selectScheduleList(conn,mvNo,brNo);
		JDBCTemplate.close(conn);
		return list;
	}
}
