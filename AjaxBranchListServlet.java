package reserve.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import reserve.vo.Branch;
import reserve.vo.Movie;
import reserve.service.ReserveService;

/**
 * Servlet implementation class AjaxBranchListServlet
 */
@WebServlet(name = "AjaxBranchList", urlPatterns = { "/ajaxBranchList" })
public class AjaxBranchListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AjaxBranchListServlet() {
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
				//3.비즈니스로직
				ArrayList<Branch> brlist = new ReserveService().selectBranchList(mvNo);
				//4.결과처리
				response.setContentType("application/json");
				response.setCharacterEncoding("UTF-8");
				new Gson().toJson(brlist,response.getWriter());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
