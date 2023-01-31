package com.mango.matzip.servlet;

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

import com.mango.matzip.dao.MangoDAO;
import com.mango.matzip.dto.MatzipListDTO;
@WebServlet("/MatziplistServlet")    // "/" --------> "http://localhost:9093/WebProject1/"
public class MatziplistServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// pageNum을 받아서, dto들의 모음을 돌려주는 서블릿.
		int pageNum = Integer.parseInt(request.getParameter("page"));
		
		MangoDAO mDao = new MangoDAO();
		ArrayList<MatzipListDTO> list = null;
		try {
			list = mDao.getMatziplistWithPaging(pageNum);
		} catch(Exception e) { e.printStackTrace(); }
		
		// JSON-Array 만듦.
		JSONArray jsonArray = new JSONArray();
		for(int i=0; i<=list.size()-1; i++) {
			MatzipListDTO dto = list.get(i);
			JSONObject obj = new JSONObject();
			obj.put("main_img", dto.getMain_img());
			obj.put("ment", dto.getMent());
			obj.put("restaurant_list", dto.getRestaurant_list());
			obj.put("restaurant_list_idx", dto.getRestaurant_list_idx());
			jsonArray.add(obj);
		}
		
		// Remember: JSONArray를 JSONObject에 담아줘야돼...
		JSONObject objFinal = new JSONObject();
		objFinal.put("result", jsonArray);
		
		// making response.
		response.setContentType("application/json");   // 응답의 형식을 제이쓴~이라고 정해줌!
		response.setCharacterEncoding("utf-8");      // 응답의 한글인코딩설정 : response.getWriter() 전에 해야 함!
		PrintWriter out = response.getWriter();
		out.println(objFinal);
		
	}

}













