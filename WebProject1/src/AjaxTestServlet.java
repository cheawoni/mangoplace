

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

/**
 * Servlet implementation class AjaxTestServlet
 * AJAX(비동기통신. Async......)
	- '동기' vs '비동기'
	- 응답이 HTML문서가 아님. (요청한 데이터만)
	- 두 가지 주요 형식:
	1) XML
	2) JSON★★★
			ex. { "ID":"YG", "PW":"1234" }
	- ajax함수 ---> JS / jQuery ( $.ajax() 함수 )	// (암기X)
	- 외부라이브러리, "json-simple.jar"
			(mvnrepository.com)
 */
@WebServlet("/AjaxTestServlet")
public class AjaxTestServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int num = Integer.parseInt( request.getParameter("num") );
		System.out.println("POST가 들어옴. num : " + num);
		
		// 응답을 만듦: response
		response.setContentType("application/json");	// 응답의 형식 지정(명시적으로)
		//request, response, session, application, out, "내장객체"
		PrintWriter out = response.getWriter();	// 펜이 준비가 됬다.
		
		JSONObject obj = new JSONObject();
		obj.put("result", "ch");
		
		out.println(obj);
	}

}
