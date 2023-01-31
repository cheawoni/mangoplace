import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Ex11Servlet")
public class Ex11Servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//System.out.println("서블릿에 GET 요청 들어옴.");
		int num1 = Integer.parseInt( request.getParameter("num1") );
		int num2 = Integer.parseInt( request.getParameter("num2") );
		int num3 = Integer.parseInt( request.getParameter("num3") );
		//System.out.println(num1 + "/" + num2 + "/" + num3);
		
		String result = (num1+num2==num3) ? "맞음!" : "틀렸음";
		// 1. forward방식. (암기)
		RequestDispatcher rd = request.getRequestDispatcher("jsp/Ex11Result.jsp");
		request.setAttribute("result", result);
		rd.forward(request, response);
		// 2. redirect방식.
//		response.sendRedirect("jsp/Ex11Result.jsp?result="+result);	// X
//		request.setAttribute("result", result);           // 무의미! (이해★★)
//		response.sendRedirect("jsp/Ex11Result.jsp");
		
	}
}
