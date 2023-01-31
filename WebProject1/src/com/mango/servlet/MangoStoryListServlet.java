package com.mango.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.mango.dao.MangoStoryListDao;
import com.mango.dto.MangoStoryListDto;

/**
 * Servlet implementation class MangoStoryListServlet
 */
@WebServlet("/MangoStoryListServlet")		// "/"	----->	"http://localhost:9090/WebProject1/"
public class MangoStoryListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("서블릿들어옴");
		// pageNum을 받아서, dto들의 모음을 돌려주는 서블릿.
		int storyListPageNumber = Integer.parseInt(request.getParameter("storyListPageNumber"));
		
		MangoStoryListDao slDao = new MangoStoryListDao();
		ArrayList<MangoStoryListDto> list = null;
		try {
			list = slDao.getListMangoFromStoryPage(storyListPageNumber);
		} catch(Exception e) { e.printStackTrace(); }
		
		// JSON-Array 만듦.
		JSONArray jsonArray = new JSONArray();
		for(int i=0; i<=list.size()-1; i++) {
			MangoStoryListDto dto = list.get(i);
			JSONObject obj = new JSONObject();
			obj.put("story_id", dto.getStoryId());
			obj.put("main_img", dto.getMainImg());
			obj.put("story_title", dto.getStoryTitle());
			obj.put("story_subtitle", dto.getStorySubtitle());
			obj.put("member_img", dto.getMemberImg());
			obj.put("member_id", dto.getMemberId());
			obj.put("recommended_review", dto.getRecommendedReview());
			jsonArray.add(obj);
		}
		
		// Remember: JSONArray를 JSONObject에 담아줘야돼...
		JSONObject objFinal = new JSONObject();
		objFinal.put("result", jsonArray);
		//objFinal.put("last_storyListPageNumber", value);
		
		// making response.
		response.setContentType("application/json");	// 응답의 형식을 제이쓴~이라고 정해줌!
		response.setCharacterEncoding("utf-8");			// 응답의 한글인코딩설정 : response.getWriter() 전에 해야 함!
		PrintWriter out = response.getWriter();			// JSONArray를 출력
		out.println(objFinal);
	}

}
