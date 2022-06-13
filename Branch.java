package reserve.vo;

public class Branch {
	private int branchNo;
	private String branchName;
	public Branch() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Branch(int branchNo, String branchName) {
		super();
		this.branchNo = branchNo;
		this.branchName = branchName;
	}
	public int getBranchNo() {
		return branchNo;
	}
	public void setBranchNo(int branchNo) {
		this.branchNo = branchNo;
	}
	public String getBranchName() {
		return branchName;
	}
	public void setBranchName(String branchName) {
		this.branchName = branchName;
	}
}
