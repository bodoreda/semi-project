package reserve.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import reserve.vo.TheaterDetailSeat;
import reserve.service.ReserveService;

/**
 * Servlet implementation class AjaxScheduleListServlet
 */
@WebServlet(name = "AjaxScheduleList", urlPatterns = { "/ajaxScheduleList" })
public class AjaxScheduleListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AjaxScheduleListServlet() {
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
		int mvNo = Integer.parseInt(request.getParameter("mvNo"));
		int brNo = Integer.parseInt(request.getParameter("brNo"));
		//3.비즈니스 로직
		ArrayList<TheaterDetailSeat> list = new ReserveService().selectScheduleList(mvNo,brNo);
		//4.결과 처리
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		new Gson().toJson(list,response.getWriter());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
