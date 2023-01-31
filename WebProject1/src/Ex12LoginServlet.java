import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.yg.dao.MemberDAO;

@WebServlet("/Ex12LoginServlet")
public class Ex12LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		MemberDAO mDao = new MemberDAO();
		String id = request.getParameter("id");
		int pw = Integer.parseInt( request.getParameter("pw") );
		
		String str = "";
		try {
			if( mDao.loginCheck(id, pw) ) {
				str = "성공";
			}
			else {
				str = "실패";
			} 
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		RequestDispatcher rd = request.getRequestDispatcher("jsp/Ex12LoginResult.jsp");
		request.setAttribute("login_result", str);
		rd.forward(request, response);
	}	


	/*protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//System.out.println("서블릿 GET방식 성공");
		String id = request.getParameter("id");
		int pw = Integer.parseInt( request.getParameter("pw") );
		//System.out.println(id + "/" + pw);
		
		String str = "";
		try {
			if( mDao.loginCheck(id, pw) ) {
				str = "로그인성공";
			}
		} catch {
			if( mDao.loginCheck(id, pw) ) {
				str = "로그인실패";
			}
		}
		
		RequestDispatcher rd = request.getRequestDispatcher("jsp/Ex11LoginResult.jsp");
		request.setAttribute("result", result);
		rd.forward(request, response);
	}*/
	
}
