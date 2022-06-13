package reserve.vo;

public class Reserve {
	private int movieNo;
	private int branchNo;
	private int theaterNo;
	private String theaterName;
	private String selectDate;
	private String selectTime;
	public Reserve() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Reserve(int movieNo, int branchNo, int theaterNo, String theaterName, String selectDate, String selectTime) {
		super();
		this.movieNo = movieNo;
		this.branchNo = branchNo;
		this.theaterNo = theaterNo;
		this.theaterName = theaterName;
		this.selectDate = selectDate;
		this.selectTime = selectTime;
	}
	public int getMovieNo() {
		return movieNo;
	}
	public void setMovieNo(int movieNo) {
		this.movieNo = movieNo;
	}
	public int getBranchNo() {
		return branchNo;
	}
	public void setBranchNo(int branchNo) {
		this.branchNo = branchNo;
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
	public String getSelectDate() {
		return selectDate;
	}
	public void setSelectDate(String selectDate) {
		this.selectDate = selectDate;
	}
	public String getSelectTime() {
		return selectTime;
	}
	public void setSelectTime(String selectTime) {
		this.selectTime = selectTime;
	}
}
