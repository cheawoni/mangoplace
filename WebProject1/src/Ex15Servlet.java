

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

/**
 * Servlet implementation class Ex15Servlet
 */
@WebServlet("/Ex15Servlet")
public class Ex15Servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Connection getConnection() {
		Connection conn = null;
				
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String dbId = "test1017";
		String dbPw = "1234";
		
		try {
			Class.forName(driver);
			System.out.println("JDBC 드라이버 로딩 성공");
			conn = DriverManager.getConnection(url, dbId, dbPw);
			System.out.println("접속 성공");
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("오라클 접속 실패");
		}
		return conn;
	}
	private boolean updateBoard(int bno) throws Exception {	// true리턴: 성공, false리턴: 실패.
		Connection conn = getConnection();
		
		String sql = "UPDATE simple_board SET title = title || '!' WHERE bno=?";
		int result = 0;	// update문 실행결과(1:성공, 0:실패)
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, bno);
		result = pstmt.executeUpdate();
		pstmt.close();
		conn.close();
		
		return result==1;
	}
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int bno = Integer.parseInt( request.getParameter("bno") );
		boolean res = false; // true:업데이트문 실행 성공 / false:업데이트문 실행 실패
		try {
			res = updateBoard(bno);
		} catch(Exception e) { e.printStackTrace(); }
		
		// 응답 만듦:
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		
		// json객체) result-->TRUE 또는 FAIL
		JSONObject obj = new JSONObject();
		if(res) {
			obj.put("result", "TRUE");
		} else {
			obj.put("result", "FAIL");
		}
		
		out.println(obj);
	}
}
