package reserve.vo;

import java.util.Date;

public class Schedule {
	private int scheduleNo;
	private int theaterNo;
	private Date startDate;
	private Date endDate;
	private int movieNo;
	public Schedule() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Schedule(int scheduleNo, int theaterNo, Date startDate, Date endDate, int movieNo) {
		super();
		this.scheduleNo = scheduleNo;
		this.theaterNo = theaterNo;
		this.startDate = startDate;
		this.endDate = endDate;
		this.movieNo = movieNo;
	}
	public int getScheduleNo() {
		return scheduleNo;
	}
	public void setScheduleNo(int scheduleNo) {
		this.scheduleNo = scheduleNo;
	}
	public int getTheaterNo() {
		return theaterNo;
	}
	public void setTheaterNo(int theaterNo) {
		this.theaterNo = theaterNo;
	}
	public Date getStartDate() {
		return startDate;
	}
	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}
	public Date getEndDate() {
		return endDate;
	}
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	public int getMovieNo() {
		return movieNo;
	}
	public void setMovieNo(int movieNo) {
		this.movieNo = movieNo;
	}
}
