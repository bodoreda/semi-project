package reserve.vo;

public class TheaterDetailSeat {
	private int theaterNo;
	private String theaterName;
	private String startTime;
	private String endTime;
	private int seatExist;
	public TheaterDetailSeat() {
		super();
		// TODO Auto-generated constructor stub
	}
	public TheaterDetailSeat(int theaterNo, String theaterName, String startTime, String endTime, int seatExist) {
		super();
		this.theaterNo = theaterNo;
		this.theaterName = theaterName;
		this.startTime = startTime;
		this.endTime = endTime;
		this.seatExist = seatExist;
	}
	public int getTheaterNo() {
		return theaterNo;
	}
	public void setTheaterNo(int theaterNo) {
		this.theaterNo = theaterNo;
	}
	public String getTheaterName() {
		return theaterName;
	}
	public void setTheaterName(String theaterName) {
		this.theaterName = theaterName;
	}
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	public int getSeatExist() {
		return seatExist;
	}
	public void setSeatExist(int seatExist) {
		this.seatExist = seatExist;
	}
}
