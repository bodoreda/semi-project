package reserve.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import reserve.vo.Reserve;

/**
 * Servlet implementation class Reserve1NextServlet
 */
@WebServlet(name = "Reserve1Next", urlPatterns = { "/reserve1Next" })
public class Reserve1NextServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Reserve1NextServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1.인코딩
		request.setCharacterEncoding("UTF-8");
		//2.값추출
		Reserve r = new Reserve();
		r.setMovieNo(Integer.parseInt(request.getParameter("movieNo")));
		r.setBranchNo(Integer.parseInt(request.getParameter("branchNo")));
		r.setTheaterNo(Integer.parseInt(request.getParameter("theaterNo")));
		r.setTheaterName(request.getParameter("theaterName"));
		r.setSelectDate(request.getParameter("selDate"));
		r.setSelectTime(request.getParameter("selectTime"));
		//3.비즈니스 로직
		//4.결과 처리
		RequestDispatcher rd = request.getRequestDispatcher("WEB-INF/views/reserve/reserve1Next.jsp");
		request.setAttribute("rsv", r);
		rd.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
