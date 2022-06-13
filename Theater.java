package reserve.vo;

public class Theater {
	private int theaterNo;
	private String theaterName;
	private int branchNo;
	public Theater() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Theater(int theaterNo, String theaterName, int branchNo) {
		super();
		this.theaterNo = theaterNo;
		this.theaterName = theaterName;
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
	public int getBranchNo() {
		return branchNo;
	}
	public void setBranchNo(int branchNo) {
		this.branchNo = branchNo;
	}
}
