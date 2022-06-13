package reserve.vo;

public class Movie {
	private int movieNo;
	private String movieTitle;
	private String movieGrade;
	private String movieRuntime;
	private String movieDate;
	private int movieGenNo;
	private String moviePlot;
	private String movieDirector;
	private String movieCast;
	private String movieImg;
	public Movie() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Movie(int movieNo, String movieTitle, String movieGrade, String movieRuntime, String movieDate,
			int movieGenNo, String moviePlot, String movieDirector, String movieCast, String movieImg) {
		super();
		this.movieNo = movieNo;
		this.movieTitle = movieTitle;
		this.movieGrade = movieGrade;
		this.movieRuntime = movieRuntime;
		this.movieDate = movieDate;
		this.movieGenNo = movieGenNo;
		this.moviePlot = moviePlot;
		this.movieDirector = movieDirector;
		this.movieCast = movieCast;
		this.movieImg = movieImg;
	}
	public int getMovieNo() {
		return movieNo;
	}
	public void setMovieNo(int movieNo) {
		this.movieNo = movieNo;
	}
	public String getMovieTitle() {
		return movieTitle;
	}
	public void setMovieTitle(String movieTitle) {
		this.movieTitle = movieTitle;
	}
	public String getMovieGrade() {
		return movieGrade;
	}
	public void setMovieGrade(String movieGrade) {
		this.movieGrade = movieGrade;
	}
	public String getMovieRuntime() {
		return movieRuntime;
	}
	public void setMovieRuntime(String movieRuntime) {
		this.movieRuntime = movieRuntime;
	}
	public String getMovieDate() {
		return movieDate;
	}
	public void setMovieDate(String movieDate) {
		this.movieDate = movieDate;
	}
	public int getMovieGenNo() {
		return movieGenNo;
	}
	public void setMovieGenNo(int movieGenNo) {
		this.movieGenNo = movieGenNo;
	}
	public String getMoviePlot() {
		return moviePlot;
	}
	public void setMoviePlot(String moviePlot) {
		this.moviePlot = moviePlot;
	}
	public String getMovieDirector() {
		return movieDirector;
	}
	public void setMovieDirector(String movieDirector) {
		this.movieDirector = movieDirector;
	}
	public String getMovieCast() {
		return movieCast;
	}
	public void setMovieCast(String movieCast) {
		this.movieCast = movieCast;
	}
	public String getMovieImg() {
		return movieImg;
	}
	public void setMovieImg(String movieImg) {
		this.movieImg = movieImg;
	}
}
